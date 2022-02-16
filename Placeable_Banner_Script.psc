Scriptname Placeable_Banner_Script extends ObjectReference  



 

;====================================================================================

Sound Property SoundFX  Auto
Activator Property PlaceableObject_Ind  Auto
Activator Property SSB_Scripted_Act  Auto
MiscObject Property Misc_ObjectKit  Auto

Message Property MenuUi_Misc_Adjust_MSG  Auto

ObjectReference Useable_Obj_Act
       
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
    If !Loaded
        If IsOptionState
            GoToState(" IsOptionState")
        Else
            GoToState("PlaceItem")
        EndIf
    EndIf
EndEvent

;====================================================================================

Function PosMenu(ObjectReference Object, Int iButton = -1,  Bool abMenu = True)
    Utility.Wait(1.0)
    Float PosX = Object.GetPositionX()
    Float PosY = Object.GetPositionY()
    While abMenu
        iButton =  MenuUi_Misc_Adjust_MSG.Show()
        If iButton == 0                        ;Move Up
            Object.SetPosition(PosX, PosY, Object.GetPositionZ() + 20.0)
            Utility.Wait(0.1)
        ElseIf iButton == 1                    ;Move Down
            Object.SetPosition(PosX, PosY, Object.GetPositionZ() - 20.0)
            Utility.Wait(0.1)
        ElseIf iButton == 2                    ;Turn Left
            Object.SetAngle(0.0, 0.0, Object.GetAngleZ() + 15.0)
            Utility.Wait(0.1)
        ElseIf iButton == 3                    ;Turn Right
            Object.SetAngle(0.0, 0.0, Object.GetAngleZ() - 15.0)
            Utility.Wait(0.1)
        ElseIf iButton == 4                    ;Start Over
            Object.Disable()
            Object.Delete()
            PlayerRef.AddItem(Misc_ObjectKit)
            abMenu = False
            GoToState("Dead")
        ElseIf iButton == 5                    ;Exit
            Object.Disable()
            Object.Delete()
                    Object.PlaceatMe(Placeable_Scripted_Act)       
                     Self.DeleteWhenAble()
                      Delete()
                    abMenu = False
            GoToState("Dead")
    EndIf
    EndWhile
EndFunction



;====================================================================================

State PlaceItem

    Event OnBeginState()
        Useable_Obj_Act = PlayerRef.PlaceAtMe(PlaceableObject_Ind)
        Useable_Obj_Act.MoveTo(PlayerRef, 250.0 * Math.Sin(PlayerRef.GetAngleZ()), 250.0 * Math.Cos(PlayerRef.GetAngleZ()), 170.0)
        Useable_Obj_Act.SetAngle(0.0, 0.0, Useable_Obj_Act.GetAngleZ() - 90)
        If Loaded
            Self.Disable()
            Self.Delete()
        Else
            PlayerRef.RemoveItem(Misc_ObjectKit, 1, True)
        EndIf
        SoundFX.Play(Useable_Obj_Act)
        PosMenu(Useable_Obj_Act)
    EndEvent

EndState

;====================================================================================

State Dead
EndState