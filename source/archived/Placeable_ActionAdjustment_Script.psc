Scriptname SSB_ActionAdjustment_Script extends ObjectReference

ObjectReference Property Activate_Object  Auto
Message Property Menu_Action  Auto
Message Property  MenuUi_PositionSelect  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
Message Property Rotate_Ui  Auto
MiscObject property MiscObj  Auto

Actor PlayerREF = Game.GetPlayer()


Event OnActivate(ObjectReference akActionRef)
    ;Bell: Menu blocks activation already, no reason to call it twice
    Menu()
EndEvent



Function Menu()
    Int aiButton = Menu_Action.show()
    self.BlockActivation()

    If aiButton == 0
        Activate_Object.Activate(PlayerREF)

    ElseIf aiButton == 1
        MenuUi_PositionSelect()

    ElseIf aiButton == 2
        self.Disable(True)
        PlayerREF.addItem(MiscObj)
        ;Bell: DeleteWhenAble() isn't needed here since the object is already disabled. DeleteWhenAble() waits a little bit and checks If the object is no longer loaded, deleting it If it isn't loaded.
        Delete()

    EndIf
EndFunction




Function MenuUi_PositionSelect()
    Int aiButton = MenuUi_PositionSelect.show()

    ;Bell: Anything for 0? Or is 0 your "Exit" button? If so, remove this line, leaving: ; If 0, exit the menu

    If aiButton == 1
        Z_Menu()
    ElseIf aiButton == 2
        Y_Menu()
    ElseIf aiButton == 3
        X_Menu()
    ElseIf aiButton == 4
        Rotate_Menu()

    EndIf
EndFunction


Function Z_Menu()
    Int aiButton = 256

    While aiButton ;Bell: This is the same as "While aiButon != 0"
        aiButton =  Z_Ui.show()

        If aiButton == 1
            SetPosition(X , Y, Z - 50)
            Self.Enable()
        ElseIf aiButton == 2
            SetPosition(X , Y, Z - 30 )
            Self.Enable()
        ElseIf aiButton == 3
            SetPosition(X , Y, Z - 10)
            Self.Enable()
        ElseIf aiButton == 4
            SetPosition(X , Y, Z - 1)
            Self.Enable()
        ElseIf aiButton == 5
            SetPosition(X , Y, Z + 1)
            Self.Enable()
        ElseIf aiButton == 6
            SetPosition(X , Y, Z + 10)
            Self.Enable()
        ElseIf aiButton == 7
            SetPosition(X , Y, Z + 30)
            Self.Enable()
        ElseIf aiButton == 8
            SetPosition(X , Y, Z + 50)
            Self.Enable()
        EndIf
    EndWhile
    Menu() ;Bell: You'll always end up returning to the main menu anyway
EndFunction

Function Y_Menu()
    Int aiButton = 666

    While aiButton
        aiButton = Y_Ui.show()

        If aiButton == 1
            SetPosition(X ,Y - 50, Z)
            Self.Enable()
        ElseIf aiButton == 2
            SetPosition(X ,Y - 30, Z)
            Self.Enable()
        ElseIf aiButton == 3
            SetPosition(X ,Y - 10, Z)
            Self.Enable()
        ElseIf aiButton == 4
            SetPosition(X ,Y - 1, Z)
            Self.Enable()
        ElseIf aiButton == 5
            SetPosition(X ,Y + 1, Z)
            Self.Enable()
        ElseIf aiButton == 6
            SetPosition(X ,Y + 10, Z)
            Self.Enable()
        ElseIf aiButton == 7
            SetPosition(X ,Y + 30, Z)
            Self.Enable()
        ElseIf aiButton == 8
            SetPosition(X ,Y + 50, Z)
            Self.Enable()
        EndIf
    EndWhile
    Menu()
EndFunction

Function X_Menu()
    Int aiButton = 80085

    While aiButton
        aiButton =  X_Ui.show()

        If aiButton == 1
            SetPosition(X - 50, Y, Z)
            Self.Enable()
        ElseIf aiButton == 2
            SetPosition(X - 30, Y, Z)
            self.Enable()
        ElseIf aiButton == 3
            SetPosition(X - 10, Y, Z)
            Self.Enable()
        ElseIf aiButton == 4
            SetPosition(X - 1, Y, Z)
            Self.Enable()
        ElseIf aiButton == 5
            SetPosition(X + 1, Y, Z)
            Self.Enable()
        ElseIf aiButton == 6
            SetPosition(X + 10, Y, Z)
            Self.Enable()
        ElseIf aiButton == 7
            SetPosition(X + 30, Y, Z)
            Self.Enable()
        ElseIf aiButton == 8
            SetPosition( X + 50, Y, Z)
            Self.Enable()
        EndIf
    EndWhile
    Menu()
EndFunction



Function Rotate_Menu(Bool abMenu = True, , Bool abFadeOut = False)
    Int aiButton = 8311

    While aiButton
        aiButton =  Rotate_Ui.show()

        If aiButton == 1
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 50.0)
            Self.Enable()
        ElseIf aiButton == 2
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 30.0)
            Self.Enable()
        ElseIf aiButton == 3
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 10.0)
            Self.Enable()
        ElseIf aiButton == 4
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 1.0)
            Self.Enable()
        ElseIf aiButton == 5
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 1.0)
            Self.Enable()
        ElseIf aiButton == 6
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 10.0)
            Self.Enable()
        ElseIf aiButton == 7
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 30.0)
            Self.Enable()
        ElseIf aiButton == 8
            Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 50.0)
            Self.Enable()
        EndIf
    EndWhile
EndFunction
