ScriptName SSB_Test Extends ObjectReference


Message Property Main_Menu  Auto
Message Property Rotate_Ui_Left  Auto
Message Property Rotate_Ui_Right  Auto


Event OnActivate(ObjectReference akActionRef)
Game.DisablePlayerControls(False, False, False, False, False, True)  
Game.EnablePlayerControls(False, False, False, False, False, True)
Main_Menu()
EndEvent

Function Main_Menu( Int aiButton = 0)
     aiButton = Main_Menu.show()
                          If aiButton == 1
           Rotate_Ui_Left()
          
           ElseIf aiButton ==2 
           Rotate_Ui_Right()
 

EndIf
EndFunction


Function Rotate_Ui_Left(Bool abmenu= True, Int aiButton = 0)
    While abMenu            
               If aiButton != -1


          aiButton =  Rotate_Ui_Left.show()
                                 abMenu = False
           If aiButton == 1
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 5.0)
            Utility.Wait(1.0)    
     
     ElseIf aiButton == 2
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 10.0)
            Utility.Wait(1.0)    
     
        ElseIf aiButton == 3
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() - 15.0)
            Utility.Wait(1.0)    

 
    EndIf
EndIf 
EndWhile
   EndFunction


Function Rotate_Ui_Right(Int aiButton = 0)
      aiButton = Rotate_Ui_Right.show()

    If aiButton == 1
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 5.0)
            Utility.Wait(1.0)    
 
    ElseIf aiButton == 2
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 10.0)
            Utility.Wait(1.0)    
     
     ElseIf aiButton == 3
           Self.SetAngle(0.0, 0.0, self.GetAngleZ() + 15.0)
            Utility.Wait(1.0)    

     
EndIf
EndFunction