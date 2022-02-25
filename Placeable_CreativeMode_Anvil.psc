Scriptname SSB_CreativeMode_Anvil extends ObjectReference  


GlobalVariable Property CreativeMode  Auto
Actor Property PlayerRef  Auto



Event OnActivate(ObjectReference akActionRef)
  CreativeMode.SetValue(1.0)
  Utility.Wait(1.0)
  RegisterForSingleUpdate(0.5)
  
  
EndEvent
 
Event OnUpdate()
  If ( ! Game.IsLookingControlsEnabled() )
    RegisterForSingleUpdate(0.5)
    return
  else 
    CreativeMode.SetValue(0.0)
          

  EndIf
EndEvent