(
	/*
		v 0.1
		¡´loca button link with animat button
	*/
	
	global nfFakeLin_rut
	
	try ( destroydialog nfFakeLin_rut ) catch()
	rollout nfFakeLin_rut "Fake Link Tool" width:162 height:300
	(
		checkButton lock_ckb "LOCK" pos:[9,11] width:144 height:30
		pickbutton pickObj_pkb "Selec obj" pos:[9,46] width:144 height:22
		listBox obj_lbx "objects" pos:[9,104] width:144 height:11
		button add_btn "add" pos:[89,94] width:30 height:19
		button re_btn "R" pos:[123,94] width:30 height:19
		timer lock_tim interval:75 active:false
		
		local pivotObj
		local transObj = #()
		local pivTM_old
		local loc_trsObjTMs = #()
		
		fn check = try ( deleteItem transObj (findItem transObj pivotObj)) catch()
		
		fn updateRut =
		(
			if pivotObj != undefined then
				pickObj_pkb.text = pivotObj.name
			else
				pickObj_pkb.text = "Select obj"
			
			if transObj != #() then
				obj_lbx.items = for obj in transObj collect obj.name
			else
				obj_lbx.items = #()			 
		)
		
		on pickObj_pkb picked obj do
		(
			pivotObj = obj 
			pickObj_pkb.text = pivotObj.name
		)
		
		on add_btn pressed do
		(
			join transObj (selection as array)
			check()
			updateRut()
			
		)
		on re_btn pressed do
		(
			transObj = #()
			updateRut()
		)
		
		on lock_ckb changed stat do
		(
			if stat do
			(
				loc_trsObjTMs = for obj in transObj collect obj.transform * inverse pivotObj.transform							
			)
			
			lock_tim.active = stat
			
		)
		
		on lock_tim tick do
		(			
			for i = 1 to transObj.count do
			(
				obj = transObj[i]
				old_loc_trsTM = loc_trsObjTMs[i]
				
				obj.transform = old_loc_trsTM * pivotObj.transform
			)
			
			loc_trsObjTMs = for obj in transObj collect obj.transform * inverse pivotObj.transform
		)
	)
	
	createdialog nfFakeLin_rut 
)