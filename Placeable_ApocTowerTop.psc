Scriptname SSB_ApocTowerTop extends ObjectReference  



Message Property MenuUi  Auto
Message Property MenuUi_MakeStatic  Auto
Message Property Z_Ui  Auto
Message Property Y_Ui  Auto
Message Property X_Ui  Auto
Message Property Rotate_Ui  Auto
Message Property NoStatic  Auto
MiscObject property MiscObj  Auto
Static Property StaticDummy  Auto


Event OnActivate(ObjectReference akActionRef)
   Menu()
EndEvent

Function Menu(Int aiButton = 0)
      aiButton = MenuUi.show()

    If aiButton == 1
        Z_Menu()
    ElseIf aiButton == 2
        Y_Menu()
    ElseIf aiButton == 3
        X_Menu()
  
      ElseIf aiButton == 4
    Rotate_Menu()
    ;Debug.Notification("Object is facing "+ GetAngleZ()+" Degrees")
    Debug.Trace("[LVX-SSS] Object is facing "+ GetAngleZ()
    Utility.wait(0.1)

    ElseIf aiButton == 5
       DisableNoWait(True)
       self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()
     ElseIf aiButton == 6
     MenuUi_MakeStatic() 
        NoStatic.Show()
          


           
       EndIf

EndFunction




Function Z_Menu(Int aiButton = 0)
      aiButton =  Z_Ui.show()

    If aiButton == 1
       SetPosition(X , Y, Z *1 - 500)
   
    ElseIf aiButton == 2
       SetPosition(X , Y, Z*1 - 30 )
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
      SetPosition(X , Y, Z*1 + 500)

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

Function MenuUi_MakeStatic(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_MakeStatic.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
   Self.PlaceatMe(StaticDummy)       
    Self.DeleteWhenAble()
     Delete()
    EndIf

EndFunction 




