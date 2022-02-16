Scriptname Placeable_AdventurersBasement_Script extends ObjectReference  


;====================================================================================

Sound Property SoundFX  Auto
Activator Property PlaceableObject  Auto

MiscObject Property ObjectKit  Auto

Message Property SSB_AdvBsmtDoorMsg  Auto

ObjectReference UseableObject

Bool Property IsOptionState  Auto
Bool Loaded


Actor Property PlayerRef  Auto

Event OnLoad()
    Loaded = True
    If IsOptionState
        GoToState(" IsOptionState")
    Else
        GoToState("PlaceItem")
    EndIf
EndEvent

Event OnEquipped(Actor akActor)
    ; BELL: Early return avoids the annoying-to-read Nested IFs
    If !Loaded
        return
    EndIf

    If IsOptionState
        GoToState(" IsOptionState")
    Else
        GoToState("PlaceItem")
    EndIf
EndEvent

;====================================================================================

; BELL: What a DRY new Function! (DRY = Don't Repeat Yourself)
Function boolWait(Bool abDoWaits, Float afDuration)
    If doWaits
        boolWait(abDoWaits, afDuration)
    EndIf
EndFunction

Function PosMenu(ObjectReference akObjectToMove, Bool abDoWaits = False)
    boolWait(abDoWaits, 1.0)
    Float PosX = akObjectToMove.GetPositionX()
    Float PosY = akObjectToMove.GetPositionY()

    Int iButton
    Bool abMenu = True

    While abMenu
        iButton = Placeable_AdvBsmtDoorMsg.Show() ; 0 through 5

        ; MOVEMENT
        ; Move Up
        If iButton == 0
            akObjectToMove.SetPosition(PosX, PosY, akObjectToMove.GetPositionZ() + 5.0)
            boolWait(abDoWaits, 1.0)
        
        ; Move Down
        ElseIf iButton == 1
            akObjectToMove.SetPosition(PosX, PosY, akObjectToMove.GetPositionZ() - 5.0)
            boolWait(abDoWaits, 1.0)


        ; ROTATION
        ; Turn Left
        ElseIf iButton == 2
            akObjectToMove.SetAngle(0.0, 0.0, akObjectToMove.GetAngleZ() + 5.0)
            boolWait(abDoWaits, 1.0)

        ; Turn Right
        ElseIf iButton == 3
            akObjectToMove.SetAngle(0.0, 0.0, akObjectToMove.GetAngleZ() - 5.0)
            boolWait(abDoWaits, 1.0)

        ; START OVER
        ElseIf iButton == 4
            akObjectToMove.Disable()
            akObjectToMove.Delete()
            PlayerRef.AddItem(ObjectKit)
            abMenu = False
            GoToState("Disabled")

        ; EXIT
        ElseIf iButton == 5
            abMenu = False
            GoToState("Disabled")
        EndIf
    EndWhile
EndFunction

;====================================================================================

State IsOptionState

    Event OnBeginState()
        UseableObject = PlayerRef.PlaceAtMe(PlaceableObject)
        UseableObject.MoveTo(PlayerRef, 100.0 * Math.Sin(PlayerRef.GetAngleZ()), 100.0 * Math.Cos(PlayerRef.GetAngleZ()), 0.0)
        Float zOffset = UseableObject.GetHeadingAngle(PlayerRef)
        UseableObject.SetAngle(0.0, 0.0, UseableObject.GetAngleZ() + zOffset)
        If Loaded
            Self.Disable()
            Self.Delete()
        Else
            PlayerRef.RemoveItem(ObjectKit, 1, True)
        EndIf
        SoundFX.PlayAndWait(UseableObject)
        SoundFX.PlayAndWait(UseableObject)
        SoundFX.Play(UseableObject)
        PosMenu(UseableObject)
    EndEvent

EndState

;====================================================================================

State PlaceItem

    Event OnBeginState()
        UseableObject = PlayerRef.PlaceAtMe(PlaceableObject)
        UseableObject.MoveTo(PlayerRef, 100.0 * Math.Sin(PlayerRef.GetAngleZ()), 100.0 * Math.Cos(PlayerRef.GetAngleZ()), 60.0)
        UseableObject.SetAngle(0.0, 0.0, UseableObject.GetAngleZ())
        If Loaded
            Self.Disable(True)
            Self.Delete()
        Else
            PlayerRef.RemoveItem(ObjectKit, 1, True)
        EndIf
        SoundFX.Play(UseableObject)
        PosMenu(UseableObject)
    EndEvent

EndState

;====================================================================================

State Disabled
EndState