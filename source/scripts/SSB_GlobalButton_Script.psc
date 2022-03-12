Scriptname SSB_GlobalButton_Script extends ObjectReference  

GlobalVariable Property IO_01  Auto

Event OnActivate(ObjectReference akActionRef)
    If (IO_01.GetValue() == 0.0)
        IO_01.SetValue(1.0) 
        Debug.Notification("Lights On") 
        Debug.Trace("[LVX-SSS] Lights On")
    Else
        IO_01.SetValue(0.0) 
        Debug.Notification("Lights Off") 
        Debug.Trace("[LVX-SSS] Lights Off")
    EndIf
EndEvent