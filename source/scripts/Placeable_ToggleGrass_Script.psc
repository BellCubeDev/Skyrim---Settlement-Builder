Scriptname SSB_ToggleGrass_Script extends activemagiceffect  

Message Property SSB_AAA_ToggleGrass  Auto
Message Property SSB_AAA_ToggleGrass02  Auto


Event OnEffectStart(Actor akTarget, Actor akCaster)
SSB_AAA_ToggleGrass.Show()
Utility.Wait(1)
Toggle_GrassMenu()
EndEvent

Function Toggle_GrassMenu(Int aibutton = 0)
aibutton = SSB_AAA_ToggleGrass02.show()

If aibutton == 1
Utility.SetINIBool("bAllowCreateGrass:Grass", False)
Debug.Notification("Grass has been disabled - (Please Reload Cell)")
Debug.Trace("[LVX-SSS] Grass has been disabled - (Please Reload Cell)
      

EndIf
EndFunction



