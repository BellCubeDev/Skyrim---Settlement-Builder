Scriptname Placeable_CloseAnimation_Script extends ObjectReference  




ObjectReference Property Activate_Object01  Auto




Event OnActivate(ObjectReference akActionRef)
Activate_Object01.Activate(Game.Getplayer())

 RegisterForSingleUpdate(0.5)
EndEvent
 

Event OnUpdate()
  If ( ! Game.IsLookingControlsEnabled() )
    RegisterForSingleUpdate(0.5)
    return
  else 
 Activate_Object01.SetOpen(False)
EndIf
EndEvent