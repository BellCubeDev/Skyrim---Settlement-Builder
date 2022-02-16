Scriptname Placeable_ButterChurn_Script extends ObjectReference  


Int Property iResetHours = 12 Auto

Event OnInit()
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent

Event OnUpdateGameTime()
    SELF.Reset()
    ;debug.Notification("Butters Ready")
    Debug.Trace("[LVX-SSS] Butters Ready")
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent