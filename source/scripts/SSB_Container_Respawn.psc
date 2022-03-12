Scriptname SSB_Container_Respawn extends ObjectReference  

Int Property iResetHours = 48 Auto

Event OnInit()
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent

Event OnUpdateGameTime()
    self.Reset()
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent