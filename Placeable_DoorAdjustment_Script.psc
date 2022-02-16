Scriptname Placeable_DoorAdjustment_Script extends ObjectReference  


ObjectReference Property Activate_Object  Auto 
Message Property Menu_Action  Auto
Message Property  MenuUi_PositionSelect02  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
Message Property Rotate_Ui  Auto
Message Property MenuUi_MakeStatic_Activator  Auto
MiscObject property MiscObj  Auto
Activator Property ActivatorDummy  Auto
Actor Property PlayerRef  Auto
ObjectReference Property TeleportMarker  Auto
ObjectReference Property ReturnMarker  Auto
ObjectReference Property ReturnMarker02  Auto
ReferenceAlias Property Follower  Auto


Event OnLoad()

    BlockActivation()

endEvent

Event OnActivate(ObjectReference akActionRef)
self.BlockActivation()
Menu()
EndEvent



Function Menu(Int aiButton = 0)
      aiButton = Menu_Action.show()
      self.BlockActivation()


If aiButton == 0
     Activate_Object.Activate(Game.Getplayer())
     ReturnMarker.MoveTo(PlayerRef)
    ReturnMarker.SetAngle(0.0,0.0,(Self.GetAngleZ()+180.00))
    ;akActionRef.MoveTo(TeleportMarker)
    Follower.GetActorRef().MoveTo(TeleportMarker)
 
      ElseIf aiButton == 1
      MenuUi_PositionSelect02()
    
    ElseIf aiButton == 2
        self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()
        
       
     EndIf
EndFunction




Function MenuUi_PositionSelect02(Int aiButton = 0)
      aiButton = MenuUi_PositionSelect02.show()

    If aiButton == 1
        Z_Menu()
    ElseIf aiButton == 2
        Y_Menu()
    ElseIf aiButton == 3
        X_Menu()
    ElseIf aiButton == 4  
        Rotate_Menu()
      ElseIf aiButton == 5
     MenuUi_MakeStatic_Activator()
     EndIf

EndFunction


Function Z_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Z_Ui.show()
     If aiButton == 0
     abMenu = False
    ElseIf aiButton == 1
       SetPosition(X , Y, Z *1 - 50)
       Self.Enable()
   ElseIf aiButton == 2
       SetPosition(X , Y, Z*1 - 30 )
       Self.Enable()
    ElseIf aiButton == 3
      SetPosition(X , Y, Z*1 - 10)
      Self.Enable()
    ElseIf aiButton == 4
      SetPosition(X , Y, Z*1 - 1)
      Self.Enable()
    ElseIf aiButton == 5
      SetPosition(X , Y, Z*1 + 1)
      Self.Enable()
    ElseIf aiButton == 6
      SetPosition(X , Y, Z*1 + 10)
      Self.Enable()
    ElseIf aiButton == 7
      SetPosition(X , Y, Z*1 + 30)
      Self.Enable()
     ElseIf aiButton == 8
      SetPosition(X , Y, Z*1 + 50)
      Self.Enable()
    EndIf
    EndIf
    EndWhile
EndFunction

Function Y_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Y_Ui.show()
     If aiButton == 0
     abMenu = False
    ElseIf aiButton == 1
       SetPosition(X ,Y *1 - 50, Z)
       Self.Enable()
    ElseIf aiButton == 2
       SetPosition(X ,Y *1 - 30, Z)
        Self.Enable()
    ElseIf aiButton == 3
      SetPosition(X ,Y  *1 - 10, Z)
       Self.Enable()
    ElseIf aiButton == 4
      SetPosition(X ,Y *1 - 1, Z)
      Self.Enable()
     ElseIf aiButton == 5
      SetPosition(X ,Y  *1 + 1, Z)
      Self.Enable()
    ElseIf aiButton == 6
      SetPosition(X ,Y *1 + 10, Z)
      Self.Enable()
    ElseIf aiButton == 7
      SetPosition(X ,Y *1 + 30, Z)
      Self.Enable()
    ElseIf aiButton == 8
      SetPosition(X ,Y *1 + 50, Z)
      Self.Enable()

    EndIf
    EndIf
    EndWhile
EndFunction

Function X_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  X_Ui.show()
       If aiButton == 0
     abMenu = False
     ElseIf aiButton == 1
       SetPosition(X *1 - 50, Y, Z)
       Self.Enable()
    ElseIf aiButton == 2
       SetPosition(X *1 - 30, Y, Z)
       self.Enable()
    ElseIf aiButton == 3
      SetPosition(X *1 - 10, Y, Z)
      Self.Enable()
    ElseIf aiButton == 4
      SetPosition(X *1 - 1, Y, Z)
      Self.Enable()
    ElseIf aiButton == 5
      SetPosition(X *1 + 1, Y, Z)
      Self.Enable()
    ElseIf aiButton == 6
      SetPosition(X *1 + 10, Y, Z)
      Self.Enable()
     ElseIf aiButton == 7
      SetPosition(X *1 + 30, Y, Z)
      Self.Enable()
    ElseIf aiButton == 8
      SetPosition( X *1 + 50, Y, Z)
      Self.Enable()


    EndIf
    EndIf
    EndWhile
EndFunction

 

Function Rotate_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Rotate_Ui.show()
      If aiButton == 0
     abMenu = False

     ElseIf aiButton == 1
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
    EndIf
    EndWhile
EndFunction

Function MenuUi_MakeStatic_Activator(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_MakeStatic_Activator.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
   ;Debug.Messagebox("Switching Out Dummy")
    Self.PlaceatMe(ActivatorDummy)       
    ; Debug.Messagebox("Switching Out Dummy Complete")

    Self.DeleteWhenAble()
     Delete()
    EndIf

EndFunction 
