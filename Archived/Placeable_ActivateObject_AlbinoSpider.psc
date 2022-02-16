Scriptname Placeable_ActivateObject_AlbinoSpider extends ObjectReference  


ObjectReference Property Activate_Object01  Auto
Actor Property AlbinoSpider01  Auto

Event OnActivate(ObjectReference akActionRef)
    Utility.Wait(0.5)
    Activate_Object01.Activate(Game.Getplayer())
    RegisterForSingleUpdate(0.5)
EndEvent

Event OnUpdate()
    If !Game.IsLookingControlsEnabled()
        RegisterForSingleUpdate(0.5)
        return
    else 
        self.SetOpen(False)
    EndIf
EndEvent