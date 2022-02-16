Scriptname Placeable_UseFurniture_Script extends ObjectReference

;/$$$$$\ $$\      $$\ $$$$$$$\   $$$$$$\  $$$$$$$\  $$$$$$$$\  $$$$$$\  $$\   $$\ $$$$$$$$\ $$\ $$\ $$\
 \_$$ _| $$$\    $$$ |$$  __$$\ $$  __$$\ $$  __$$\ \__$$  __|$$  __$$\ $$$\  $$ |\__$$  __|$$ |$$ |$$ |
   $$ |  $$$$\  $$$$ |$$ |  $$ |$$ /  $$ |$$ |  $$ |   $$ |   $$ /  $$ |$$$$\ $$ |   $$ |   $$ |$$ |$$ |
   $$ |  $$\$$\$$ $$ |$$$$$$$  |$$ |  $$ |$$$$$$$  |   $$ |   $$$$$$$$ |$$ $$\$$ |   $$ |   $$ |$$ |$$ |
   $$ |  $$ \$$$  $$ |$$  ____/ $$ |  $$ |$$  __$$<    $$ |   $$  __$$ |$$ \$$$$ |   $$ |   \__|\__|\__|
   $$ |  $$ |\$  /$$ |$$ |      $$ |  $$ |$$ |  $$ |   $$ |   $$ |  $$ |$$ |\$$$ |   $$ |
 $$$$$$\ $$ | \_/ $$ |$$ |       $$$$$$  |$$ |  $$ |   $$ |   $$ |  $$ |$$ | \$$ |   $$ |   $$\ $$\ $$\
 \_____| \__|     \__|\__|       \______/ \__|  \__|   \__|   \__|  \__|\__|  \__|   \__|   \__|\__|\_/;

; Because I changed the menu functionallity, PLEASE UPDATE THE MENU ACCORDINGLY!



Message Property Menu_Use  Auto
Message Property  MenuUi  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
MiscObject property MiscObj  Auto

Event OnInit()
    Self.BlockActivation()
EndEvent


Event OnActivate(ObjectReference akActionRef)
    Menu()
EndEvent

Function Menu(Int aiButton = 0)
      aiButton = Menu_Use.show()

If aiButton == 0                         ; Use

    ;BELL: Making Activate()'s second argument true stops script processing and bypasses normal
    self.Activate(Game.GetPlayer(), True)


    ElseIf aiButton == 1        ;Position
    MenuUi()

    ElseIf aiButton == 2         ;Pickup
        self.Disable(True)
        game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()

    ;BELL: Since this button doesn't do anything, it is more efficient to simply comment it out (instead of making Papyrus do math)
    ;ElseIf aiButton == 3

    EndIf
EndFunction



;/ Because of what I did above, you don't actually need to repeat your functions!
Function MenuUi(Int aiButton = 0)
      aiButton = MenuUi.show()

    If aiButton == 1
        Z_Menu()
    ElseIf aiButton == 2
        Y_Menu()
    ElseIf aiButton == 3
        X_Menu()
    ElseIf aiButton == 4
        self.Disable(True)
        game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()

     EndIf

EndFunction


Function Z_Menu(Int aiButton = 0)
      aiButton =  Z_Ui.show()

    If aiButton == 1
       SetPosition(X , Y, Z *1 - 50)

    ElseIf aiButton == 2
       SetPosition(X , Y, Z*1 - 30)
    ElseIf aiButton == 3
      SetPosition(X , Y, Z*1 - 10)
    ElseIf aiButton == 4
      SetPosition(X , Y, Z*1 - 1)
    ElseIf aiButton == 5
      SetPosition(X , Y, Z*1 + 1)
    ElseIf aiButton == 6
      SetPosition(X , Y, Z*1 + 10)
    ElseIf aiButton == 7
      SetPosition(X , Y, Z*1 + 30)
    ElseIf aiButton == 8
      SetPosition(X , Y, Z*1 + 50)

    EndIf

EndFunction

Function Y_Menu(Int aiButton = 0)
      aiButton =  Y_Ui.show()

    If aiButton == 1
       SetPosition(X ,Y *1 - 50, Z)
    ElseIf aiButton == 2
       SetPosition(X ,Y *1 - 30, Z)
    ElseIf aiButton == 3
      SetPosition(X ,Y  *1 - 10, Z)
    ElseIf aiButton == 4
      SetPosition(X ,Y *1 - 1, Z)
     ElseIf aiButton == 5
      SetPosition(X ,Y  *1 + 1, Z)
    ElseIf aiButton == 6
      SetPosition(X ,Y *1 + 10, Z)
    ElseIf aiButton == 7
      SetPosition(X ,Y *1 + 30, Z)
    ElseIf aiButton == 8
      SetPosition(X ,Y *1 + 50, Z)



        ;Just exit with nothing
    EndIf

EndFunction

Function X_Menu(Int aiButton = 0)
      aiButton = X_Ui.show()

    If aiButton == 1
       SetPosition(X *1 - 50, Y, Z)
    ElseIf aiButton == 2
       SetPosition(X *1 - 30, Y, Z)
    ElseIf aiButton == 3
      SetPosition(X *1 - 10, Y, Z)
    ElseIf aiButton == 4
      SetPosition(X *1 - 1, Y, Z)
    ElseIf aiButton == 5
      SetPosition(X *1 + 1, Y, Z)
    ElseIf aiButton == 6
      SetPosition(X *1 + 10, Y, Z)
     ElseIf aiButton == 7
      SetPosition(X *1 + 30, Y, Z)
    ElseIf aiButton == 8
      SetPosition( X *1 + 50, Y, Z)
        ;Just exit with nothing
    EndIf

EndFunction

/;
