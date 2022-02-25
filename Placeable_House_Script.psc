Scriptname SSB_House_Script extends ObjectReference  

ObjectReference Property Activate_Object  Auto 
Message Property Menu_Action  Auto
Message Property  MenuUi_PositionSelect  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
Message Property Rotate_Ui  Auto
MiscObject property MiscObj  Auto
Activator Property HouseDummy  Auto
Message Property MenuUi_MakeStatic_Activator  Auto

Event OnActivate(ObjectReference akActionRef)
self.BlockActivation()

 Menu()
EndEvent



Function Menu(Int aiButton = 0)
      aiButton = Menu_Action.show()
      self.BlockActivation()


If aiButton == 0
     Activate_Object.Activate(Game.Getplayer())

 
      ElseIf aiButton == 1
      MenuUi_PositionSelect()
    
    ElseIf aiButton == 2
        self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()
        
       
     EndIf
EndFunction




Function MenuUi_PositionSelect(Int aiButton = 0)
      aiButton = MenuUi_PositionSelect.show()

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
     
   Function Rotate_Menu(Int aiButton = 0)
      aiButton = Rotate_Ui.show()
     
    If aiButton == 1
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 1.0)
            Utility.Wait(1.0)    
     
     ElseIf aiButton == 2
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 10.0)
            Utility.Wait(1.0)    
     
        ElseIf aiButton == 3
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 30.0)
            Utility.Wait(1.0)    
               
             ElseIf aiButton == 4
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 50.0)
            Utility.Wait(1.0)    
 
    ElseIf aiButton == 5
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 1.0)
            Utility.Wait(1.0)    
 
    ElseIf aiButton == 6
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 10.0)
            Utility.Wait(1.0)    
     
     ElseIf aiButton == 7
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 30.0)
            Utility.Wait(1.0)    

      ElseIf aiButton == 8
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 50.0)
            Utility.Wait(1.0)    

     EndIf
     EndFunction

Function MenuUi_MakeStatic_Activator(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_MakeStatic_Activator.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
   ;Debug.Messagebox("Switching Out Dummy")
    Self.PlaceatMe(HouseDummy)       
    ; Debug.Messagebox("Switching Out Dummy Complete")

    Self.DeleteWhenAble()
     Delete()
    EndIf

EndFunction 


          


