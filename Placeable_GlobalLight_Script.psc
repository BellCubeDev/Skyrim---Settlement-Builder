Scriptname SSB_GlobalLight_Script extends ObjectReference  



GlobalVariable Property IO_01  Auto

Event OnInit()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
    If (IO_01.GetValue() as Bool)
        Enable()
    Else
        Disable()
    EndIf

    RegisterForSingleUpdate(1.0)
EndEvent