Scriptname SSB_EggIncubator_Script extends ObjectReference  


Int Property iResetHours = 72 Auto

Event OnInit()
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent

Event OnUpdateGameTime()
    SELF.Reset()
    ;debug.Notification("Eggs Ready")
    Debug.Trace("[LVX-SSS] Eggs Ready")
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent