Scriptname Placeable_AnimatedObjects_Script extends ObjectReference  

Bool property bAllowInterrupt = False Auto
{Allow interrupts While animation? Default: False}
; BELL: DocuStrings!!! YES!!! And now it works!

Bool property startDown = True Auto



Event Onactivate(ObjectReference akActionRef)
    If bAllowInterrupt
        If startDown
            Self.PlayAnimation("StartLowered")
            GoToState("Lowered")
        Else
            GoToState("Raised")
        EndIf
    Else ; If DON'T bAllowInterupt
        If startDown
            Self.PlayAnimation("StartLowered")
            GoToState("Lowered")
        Else
            GoToState("Raised")
        EndIf
    EndIf
EndEvent

State Raised
    Event OnActivate(ObjectReference UNUSED)
        Self.PlayAnimationAndWait("Lower", "Done")
        GoToState("Lowered")
    EndEvent
EndState

State RaisedINTERRUPTS
    Event OnActivate(ObjectReference UNUSED)
        Self.PlayAnimation("Lower")
        GoToState("LoweredINTERRUPTS")
    EndEvent
EndState

State Lowered
    Event OnActivate(ObjectReference UNUSED)
        Self.PlayAnimationAndWait("Raise", "Done")
        GoToState("Raised")
    EndEvent
EndState

State LoweredINTERRUPTS
    Event OnActivate(ObjectReference UNUSED)
        Self.PlayAnimation("Raise")
        GoToState("RaisedINTERRUPTS")
    EndEvent
EndState
