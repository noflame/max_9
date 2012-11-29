(
/*
	--deleteChangeHandler myId
	--deleteAllChangeHandlers()
	global pivotObj
	global transObj

	global povotTM_old
	global myId


	myId = when transform $Dummy01 changes do
	(	
		for obj in transObj do
		(
			-- calculate ne TM
			
		)
		
		rotValur = [$Dummy01.rotation.controller.x_rotation.controller.value,$Dummy01.rotation.controller.y_rotation.controller.value,$Dummy01.rotation.controller.z_rotation.controller.value]
		tm = (eulerToQuat (eulerAngles rotValur.x rotValur.y rotValur.z) order:1) as matrix3
		tm.row4 = $Dummy01.pos
		print tm
		
		$Dummy02.transform = $Dummy02.transform *inverse
	)
	*/
	
	global nfFakeLin_rut
	
	try ( destroydialog nfFakeLin_rut ) catch()
	rollout fakeLin_rut "Fake Link Tool" width:162 height:300
	(
		checkButton lock_ckb "LOCK" pos:[9,11] width:144 height:30
		pickbutton pickObj_pkb "" pos:[9,46] width:144 height:22
		listBox obj_lbx "objects" pos:[9,104] width:144 height:11
		button add_btn "add" pos:[89,94] width:30 height:19
		button re_btn "R" pos:[123,94] width:30 height:19
		timer lock_tim interval:100 active:false
		
		local pivotObj
		local transObj = #()
		local pivTM_old
		local loc_trsObjTMs = #()
		
		on pickObj_pkb pick obj do
		(
			pickObj_pkb.text = obj.name			
		)
		
		on lock_ckb change stat do
		(
			for obj in transObj collect 
			(			
				if obj.parent != undefined then 
					obj.transform * inverse obj.parent.transform
				else 
					obj.transform
			)
			
			lock_tim.active = stat
		)
		
		on lock_tim tick do
		(
			for i = 1 to transObj.count do
			(
				obj = transObj[i]
				old_trsTM = loc_trsObjTMs[i]
				
				if obj.parent == undefined then 
					obj.transform = loc_trsObjTMs
				else
				-- ¼g¨ì³o¸Ì
					obj.transform = loc_trsObjTMs
			)
		)
	)
	
	createdialog nfFakeLin_rut 
)