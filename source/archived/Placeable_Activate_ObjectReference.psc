Scriptname SSB_Activate_ObjectReference extends ObjectReference  


ObjectReference Property Activate_Object01  Auto

Event OnActivate(ObjectReference akActionRef) 
     Self.SetOpen()
     Utility.Wait(0.5)
     Activate_Object01.Activate(Game.Getplayer())
     Registerforsingleupdate(1.0)
EndEvent

Event OnUpdate()
     If ( ! Game.IsLookingControlsEnabled() )
          RegisterForSingleUpdate(0.5)
          ; BELL: No reason to use a Return here
     else
          Utility.Wait(0.5) 
          Self.SetOpen(False)
     EndIf
EndEvent
