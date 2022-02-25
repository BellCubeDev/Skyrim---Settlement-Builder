Scriptname SSB_MISC_Adjust_Deploy extends ObjectReference  

;====================================================================================

Sound Property SoundFX  Auto
Activator Property PlaceableObject_Ind  Auto
Activator Property SSB_Scripted_Act  Auto
MiscObject Property Misc_ObjectKit  Auto
MiscObject Property MiscObj  Auto
Message Property MenuUi_Misc_Adjust_MSG  Auto

ObjectReference Useable_Obj_Act
       
Bool Property IsOptionState  Auto
Bool Loaded



Message Property MenuUi  Auto
Message Property MenuUi_SKSE  Auto
Message Property MenuUi_MakeStatic  Auto
Message Property MenuUi_MakeStatic_SKSE  Auto
Message Property MenuUi_Options  Auto
Message Property MenuUi_Options_SKSE  Auto
Message Property  MenuUi_Options_PositionerMenu  Auto
Message Property  MenuUi_Options_PositionerMenu_SKSE  Auto
Message Property Z_Ui  Auto
Message Property Y_Ui  Auto
Message Property X_Ui  Auto
Message Property Rotate_Ui  Auto
Actor Property PlayerRef  Auto
Static Property StaticDummy  Auto
Activator Property My_Activator_Static  Auto
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

Function Menu(Int aiButton = -1,  Bool abMenu = True)
    Utility.Wait(1.0)
    While abMenu
        aiButton =   MenuUi.show()
        If  aiButton == 0                        ;Move Up
            
        ElseIf aiButton == 1                    ;Move Down
            Z_Menu()
        ElseIf aiButton == 2                    ;Turn Left
             Y_Menu()
        ElseIf aiButton == 3                    ;Turn Right
            X_Menu()

        ElseIf aiButton == 4                    ;Start Over
            Rotate_Menu()

        ElseIf aiButton == 5    
                  Self.SetAngle(0.0, 0.0, Self.GetAngleZ())
                
          ElseIf aiButton == 6
             self.Disable(True)
             game.getPlayer().addItem(MiscObj)
             Delete()    
            
              ElseIf aiButton == 6
              MenuUi_MakeStatic()
                  
EndIf
    EndWhile
EndFunction


State PlaceItem

    Event OnBeginState()
             MEnu()
        Useable_Obj_Act = PlayerRef.PlaceAtMe(PlaceableObject_Ind)
        Useable_Obj_Act.MoveTo(PlayerRef, 200.0 * Math.Sin(PlayerRef.GetAngleZ()), 200.0 * Math.Cos(PlayerRef.GetAngleZ()), 60.0)
        Useable_Obj_Act.SetAngle(0.0, 0.0, Useable_Obj_Act.GetAngleZ())
      EndEvent    
      EndState

;====================================================================================
;---------------------------------------------------------------------------------------------------------Z_Menu---------------------------------------------------------------------

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
    ElseIf aiButton == 9
    MenuUi.show()


    EndIf
    EndIf
    EndWhile
EndFunction

;----------------------------------------------------------------------------------------------------Y_Menu--------------------------------------------------------------------------

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

;---------------------------------------------------------------------------------------------X_Menu-----------------------------------------------------------------------------------

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

;--------------------------------------------------------------------------------------Rotate_Menu------------------------------------------------------------------------------- 

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


Function MenuUi_MakeStatic(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_MakeStatic.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
   Self.PlaceatMe(StaticDummy)
   Self.PlaceAtMe(My_Activator_Static)       
    Delete()
    EndIf

EndFunction 
;------------------------------------------------------------------------------------Options_Menu----------------------------------------------------------------------------
State Dead
EndState