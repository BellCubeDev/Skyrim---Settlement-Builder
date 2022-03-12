Scriptname SSB_Container_Close_Script extends ObjectReference  

Actor Property PlayerRef  Auto

Event OnActivate(ObjectReference akActionRef)
Self.SetOpen()
Utility.Wait(0.5)
If ( ! Game.IsLookingControlsEnabled() )
    RegisterForSingleUpdate(0.5)
    return
  else 
 Self.SetOpen(False)
EndIf
EndEvent


Event Oninit()
If PlayerRef.IsSneaking()
self.BlockActivation()
EndIf
EndEvent