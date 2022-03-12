Scriptname SSB_BeeApiary_Script extends ObjectReference  

Int Property iResetHours = 72 Auto

Event OnInit()
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent

Event OnUpdateGameTime()
   self.Reset()
    RegisterForSingleUpdateGameTime(iResetHours)
EndEvent