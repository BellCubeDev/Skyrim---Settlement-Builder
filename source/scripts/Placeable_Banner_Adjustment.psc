Scriptname SSB_Banner_Adjustment extends ObjectReference  
 


Actor Property PlayerREf  Auto
GlobalVariable Property SSB_Positioner_SKSE_Global  Auto
;GlobalVariable Property SSB_Auto_Leveling_Items  Auto ; Defualt = (1.0)
Message Property MenuUi_Banner  Auto
Message Property MenuUi_Banner_SKSE  Auto
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
Message Property Z_Ui_SKSE  Auto
Message Property Y_Ui_SKSE  Auto
Message Property X_Ui_SKSE  Auto
Message Property Rotate_Ui_SKSE  Auto
MiscObject property MiscObj  Auto
;Static Property StaticDummy  Auto

Activator Property My_Banner  Auto
Spell Property SSB_SKSE_Positioner_Toggle  Auto
;Spell Property SSB_Auto_Level_Object_Global_Toggle_Spell  Auto






Formlist SSB_A_DeleteAll 

;----------------------------------------Auto - Object Leveling - System ----------------------------------------------------------------------------
Spell SSB_Auto_Level_Object_Global_Toggle_Spell
GlobalVariable SSB_Auto_Leveling_Items

Event OnInit() ; This event will run once, when the script is initialized
 
                                               ;Caution
;===========================================Delete All Fomlist Property================================================
SSB_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist;  | 
;======================================================================================================================

;---------------------------Auto-Level-Toggle-Spell-------------------
SSB_Auto_Level_Object_Global_Toggle_Spell = Game.GetFormFromFile(0x00DE456D, "LvxMagicks-CampfireUnleashed.Esm") as Spell
    



 ;-------------------------Auto-Level-Object--------------------------    
    SSB_Auto_Leveling_Items = Game.GetFormFromFile(0x00DD0161, "LvxMagicks-CampfireUnleashed.Esm") as GlobalVariable
    ;debug.Notification(SSB_Auto_Leveling_Items+": "+SSB_Auto_Leveling_Items.GetValue())
    Debug.Trace("[LVX-SSS] " + SSB_Auto_Leveling_Items+": "+SSB_Auto_Leveling_Items.GetValue()
   
If (SSB_Auto_Leveling_Items.GetValue() == 0)
    GoToState("Auto_Level")
    

     Else
      ;GetValueint
    ; DO Nothing
    ;debug.Notification("Object Auto-Level Not Working")
    Debug.Trace("[LVX-SSS] Object Auto-Level Not Working")
 EndIf
EndEvent

State Auto_Level
Event OnBeginState()
    If (SSB_Auto_Leveling_Items.GetValue() == 1)
    
    ;debug.Notification("Object Auto-Leveled OFF")
    
    Debug.Trace("[LVX-SSS] Object Auto-Leveled OFF")

   Else

     Self.SetAngle(0.0, 0.0, Self.GetAngleZ()) ; Default
    ;debug.Notification("Object Auto-Level System Working")
    Debug.Trace("[LVX-SSS] Object Auto-Level System Working")
    

    EndIf
EndEvent
EndState


Event OnActivate(ObjectReference akActionRef)
                                           ;otherwise
    Menu()                                                     ;use regular menu

Endevent

  
;--------------------------------------------------------------------------------------------Main Menu--------------------------------------------------------------------------
 
 Function Menu(Int aiButton = 0)
   aiButton =MenuUi_Banner.show()
      ;Debug.Notification("Legacy Positioner UI Active")
      Debug.Trace("[LVX-SSS] Legacy Positioner UI Active")
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
        Auto_Level_Button()
        Debug.MessageBox("Level Button")
    



    ElseIf aiButton == 6
       Self.Disable(True)
       Game.GetPlayer().addItem(MiscObj)
       Delete()
      
   
    ElseIf aiButton == 7   ; Options
      MenuUi_MakeStatic()

    ElseIf aiButton == 8
     MenuUi_MakeStatic() 



EndIf
EndFunction


;------------------------------------------------------------------------Auto-Level_Button Function-----------------------------------------------------------------

    Function Auto_Level_Button()

    If (SSB_Auto_Leveling_Items.GetValue() == 1)
    Self.SetAngle(0.0, 0.0, Self.GetAngleZ())
    

    Else
      
    debug.Messagebox("Object Auto-Level System Working - No need to use button.. You can turn off Automated Leveling Objects in the Options - Campfire Unleashed Spells.. Then this button will be active again")
    

    EndIf
    EndFunction




;---------------------------------------------------------------------------------------------------------Z_Menu---------------------------------------------------------------------

Function Z_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)

   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)  
   aiButton =  Z_Ui.show()
     If aiButton == 0
     abMenu = False
     Menu()
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

;----------------------------------------------------------------------------------------------------Y_Menu--------------------------------------------------------------------------

Function Y_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Y_Ui.show()
     If aiButton == 0
     abMenu = False
     Menu()
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
     Menu()
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
     Menu()

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

;------------------------------------------------------------------------------------Options_Menu----------------------------------------------------------------------------

Function MenuUi_Options( Int aiButton = 0, Bool abFadeOut = False)
     If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  MenuUi_Options.show()
      If aiButton == 0
      Menu()
   
   ElseIf aiButton==1
   MenuUi_Options_PositionerMenu()
   
EndIf
EndIf
EndFunction


Function MenuUi_Options_PositionerMenu( Int aiButton = 0, Bool abFadeOut = False) ; Show Option Menu
      If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)
aiButton= MenuUi_Options_PositionerMenu.Show()
  If aibutton == 0
  MenuUi_Options()

   ElseIf aiButton== 1
SSB_SKSE_Positioner_Toggle.cast(PlayerRef)

   ElseIf aiButton == 2
SSB_Auto_Level_Object_Global_Toggle_Spell.Cast(PlayerRef)

EndIf
EndIf

EndFunction
   

;--------------------------------------------------------------------------------------------Static_Menu---------------------------------------------------------------------


Function MenuUi_MakeStatic(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_MakeStatic.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
    SSB_A_DeleteAll.AddForm(PlaceatMe(My_Banner))       
    Delete()
    EndIf

EndFunction 


