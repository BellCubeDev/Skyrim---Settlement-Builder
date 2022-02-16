Scriptname Placeable_Door_Adjustment_Script extends ObjectReference  


Message Property MenuUi_Door_MainMenu  Auto
Message Property MenuUi_Place_Door_Activator  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
Message Property Rotate_Ui  Auto

MiscObject property MiscObj  Auto
Activator Property Activator01  Auto
Static Property StaticDummy  Auto
;--------------------------------------------------------SKSE Propertys-----------------
Actor Property PlayerREf  Auto
GlobalVariable Property SSB_Positioner_SKSE_Global  Auto
Message Property MenuUi  Auto
Message Property MenuUi_Door_MainMenu_SKSE  Auto
Message Property MenuUi_MakeStatic  Auto
Message Property MenuUi_MakeStatic_SKSE  Auto
Message Property MenuUi_Options  Auto
Message Property MenuUi_Options_SKSE  Auto
Message Property  MenuUi_Options_PositionerMenu  Auto
Message Property  MenuUi_Options_PositionerMenu_SKSE  Auto

Message Property Z_Ui_SKSE  Auto
Message Property Y_Ui_SKSE  Auto
Message Property X_Ui_SKSE  Auto
Message Property Rotate_Ui_SKSE  Auto


Spell Property SSB_SKSE_Positioner_Toggle  Auto
ObjectReference Property Teleport_Activator  Auto

Formlist Placeable_A_DeleteAll
;----------------------------------------Auto - Object Leveling - System ----------------------------------------------------------------------------
Spell Placeable_Auto_Level_Object_Global_Toggle_Spell
GlobalVariable Placeable_Auto_Leveling_Items

Event OnInit() ; This event will run once, when the script is initialized
    
;===========================================Delete All Fomlist Property================================================
Placeable_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist;  | 
;======================================================================================================================


  
    Placeable_Auto_Level_Object_Global_Toggle_Spell = Game.GetFormFromFile(0x00DE456D, "LvxMagicks-CampfireUnleashed.Esm") as Spell ;Auto Level Object Spell Formlist


    Placeable_Auto_Leveling_Items = Game.GetFormFromFile(0x00DD0161, "LvxMagicks-CampfireUnleashed.Esm") as GlobalVariable ; Auto Level Object Global Var Formlist
    ;debug.Notification(Placeable_Auto_Leveling_Items+": "+Placeable_Auto_Leveling_Items.GetValue())
    Debug.Trace("[LVX-SSS] " + Placeable_Auto_Leveling_Items+": "+Placeable_Auto_Leveling_Items.GetValue()
   
If (Placeable_Auto_Leveling_Items.GetValue() == 0)
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
    If (Placeable_Auto_Leveling_Items.GetValue() == 1)
    
    ;debug.Notification("Object Auto-Leveled OFF")
    
    Debug.Trace("[LVX-SSS] Object Auto-Leveled OFF")

   Else

     Self.SetAngle(0.0, 0.0, Self.GetAngleZ()) ; Default
    ;debug.Notification("Object Auto-Level System Working")
    Debug.Trace("[LVX-SSS] Object Auto-Level System Working")
    
EndIf
EndEvent
EndState
;-------------------------------------------------------------------------------------------------------------------------------------------






Event OnLoad()

    BlockActivation()

endEvent


;---------------------------------------------------SKSE CHECK---------------------------------------------------
Event OnActivate(ObjectReference akActionRef)
    If akActionRef == Game.GetPlayer()&& SKSE.GetVersion() > 0                                   ;is SKSE present
    If (Placeable_Positioner_SKSE_Global.GetValue() == 0.0)    ;is SKSE menu choice selected
      MenuUi_SKSE()                                              ;use SKSE menu
    Else                                                       ;otherwise 
      Menu()                                                     ;use regular menu
    EndIf
    Else                                                       ;otherwise
    Menu()                                                     ;use regular menu
  EndIf
Endevent

Function Menu(Int aiButton = 0)
      aiButton =  MenuUi_Door_MainMenu.show()
           
           If aiButton == 1
            OpenDoor()                      
 
          
    ElseIf aiButton == 2
          Z_Menu()
    ElseIf aiButton == 3
          Y_Menu()
    ElseIf aiButton == 4
          X_Menu()
    ElseIf aiButton == 5   
          Rotate_Menu()


    ElseIf aiButton == 6
     Auto_Level_Button()     ;Level Object Angle
  
    ElseIf aiButton == 7    ; Pickup
     self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()
    

    ElseIf aiButton == 8   ; Options
      MenuUi_Options()



     ElseIf aiButton == 9  ; Place Gate
     MenuUi_PlaceActivator_SKSE() 
     

    EndIf
EndFunction


;------------------------------------------------------------------------Auto-Level_Button Function-----------------------------------------------------------------

    Function Auto_Level_Button()

    If (Placeable_Auto_Leveling_Items.GetValue() == 1)
    Self.SetAngle(0.0, 0.0, Self.GetAngleZ())
    

    Else
      
    debug.Messagebox("Object Auto-Level System Working - No need to use button.. You can turn off Automated Leveling Objects in the Options - Campfire Unleashed Spells.. Then this button will be active again")
    

    EndIf
    EndFunction

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------



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
     
   
   ElseIf aiButton==1
   MenuUi_Options_PositionerMenu()
   
EndIf
EndIf
EndFunction


Function MenuUi_Options_PositionerMenu( Int aiButton = 0, Bool abFadeOut = False) ; Show Option Menu
      If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)
aiButton= MenuUi_Options_PositionerMenu.Show()
  If aibutton == 0
  

   ElseIf aiButton==1
Placeable_SKSE_Positioner_Toggle.cast(PlayerRef)

   ElseIf aiButton == 2
   Placeable_Auto_Level_Object_Global_Toggle_Spell.cast(PlayerRef)

EndIf
EndIf

EndFunction

;--------------------------------------Place Lights------------------------------

Function MenuUi_PlaceActivator(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_Place_Door_Activator.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
   Self.PlaceatMe(Activator01)       
    Self.DeleteWhenAble()
     Delete()
    EndIf

EndFunction 



;=========================================================================
;----------------------------------------------SKSE MAIN MENU-------------------------------------------------------------------------------
;===========================================================================



Function MenuUi_SKSE(Bool abFadeIn = False)
   Int aiButton =  MenuUi_Door_MainMenu_SKSE.show()       
      
    If aiButton == 1
            OpenDoor() 

       ;Debug.Notification("SKSE Positioner Active") 

       Debug.Trace("[LVX-SSS] SKSE Positioner Active")
    ElseIf aiButton == 2
        Z_Menu_SKSE()
       ElseIf aiButton == 3
        Y_Menu_SKSE()
    ElseIf aiButton == 4
        X_Menu_SKSE()
    
    ElseIf aiButton == 5
    Rotate_Menu_SKSE()
    ;Debug.Notification("Object is facing "+ GetAngleZ()+" Degrees")
    Debug.Trace("[LVX-SSS] Object is facing "+ GetAngleZ()
    Utility.wait(0.1)
 
     
    ElseIf aiButton == 6
     Auto_Level_Button()
  
    
    ElseIf aiButton == 7
       self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        Delete()
     
    ElseIf aiButton == 8   ; Options
      MenuUi_Options_SKSE()


    ElseIf aiButton == 9
    MenuUi_PlaceActivator_SKSE() 
       
EndIf
EndFunction

;----------------------------------------------------------------------------Z_SKSE_Menu--------------------------------------------------------------------------------------------------------------------------------------

Function Z_Menu_SKSE(Bool abFadeIn = False)
   Int aiButton =  Z_Ui_SKSE.show()


    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4) ;static
   
    If aiButton == 0
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        PositionObject.Delete()
        Self.Enable()   
   
    ElseIf aiButton == 1
        ;Self.Enable()
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), (PositionObject.GetPositionZ() - 5), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
        Z_Menu_SKSE(abFadeIn) ;re-opens menu
   
    ElseIf aiButton == 2
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), (PositionObject.GetPositionZ() + 5), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
        Z_Menu_SKSE(abFadeIn) ;re-opens menu
    EndIf
EndFunction
 
;---------------------------------------------------------------------------------Function_Y_SKSE-------------------------------------
 
Function Y_Menu_SKSE(Bool abFadeIn = False)
   Int aiButton =  Y_Ui_SKSE.show()


    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4) ;static
   
    If aiButton == 0
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        PositionObject.Delete()
        Self.Enable()   

           
   
    ElseIf aiButton == 1
        ;Self.Enable()
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), (PositionObject.GetPositionY() - 5), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
        Y_Menu_SKSE(abFadeIn) ;re-opens menu
   
    ElseIf aiButton == 2
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), (PositionObject.GetPositionY() + 5), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
        Y_Menu_SKSE(abFadeIn) ;re-opens menu
    EndIf
EndFunction
 
    
;----------------------------------------------------------------------------------Funtion_X_SKSE-----------------------------------------------------------
 
 
 
Function X_Menu_SKSE(Bool abFadeIn = False)
   Int aiButton =  X_Ui_SKSE.show()


    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4) ;static
   
    If aiButton == 0
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        PositionObject.Delete()
        Self.Enable()   

           
   
    ElseIf aiButton == 1
        ;Self.Enable()
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo( (PositionObject.GetPositionX() - 5), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
        X_Menu_SKSE(abFadeIn) ;re-opens menu
   
    ElseIf aiButton == 2
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo( (PositionObject.GetPositionX() + 5), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
        X_Menu_SKSE(abFadeIn) ;re-opens menu
    EndIf
EndFunction
 
;--------------------------------------------------------------------------------Rotate_SKSE------------------------------------------------------------------
 
Function Rotate_Menu_SKSE(Bool abFadeIn = False)
   Int aiButton =  Rotate_Ui_SKSE.show()
   
    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(StaticDummy, 1)
    PositionObject.SetMotionType(4) ;static




   
    Utility.Wait(0.1)
    Self.Disable()
       

    If aiButton == 0
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        PositionObject.Delete()
        Self.Enable()   

   
    ElseIf aiButton == 1
        ;Self.Enable()
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object down until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ() - 5, 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        Self.SetAngle(PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ())
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
        
       Rotate_Menu_SKSE(abFadeIn) ;Re- opens menu



   
    ElseIf aiButton == 2
        Int ActivateKey = Input.GetMappedKey("Activate")
        While Input.IsKeyPressed(ActivateKey) || Input.IsKeyPressed(256) ;moves object up until the activate key or left mouse button is released. 
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ() + 5, 500, 0)    
        EndWhile
        
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        PositionObject.Disable()
        Self.SetAngle(PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ())
        Self.Enable()
        PositionObject.Delete()
   
       Rotate_Menu_SKSE(abFadeIn) ;Re- opens menu

    
EndIf
EndFunction
;-----------------------------------------------------------------------------------------------------------------Options_SKSE------------------------------------------------------------------------------

Function MenuUi_Options_SKSE(Int aiButton = 0, Bool abFadeOut = False)
   
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  MenuUi_Options_SKSE.show()
      If aiButton == 0
     

   
   ElseIf aiButton==1
   MenuUi_Options_PositionerMenu()

   ElseIf aiButton == 2
   Placeable_Auto_Level_Object_Global_Toggle_Spell.cast(PlayerRef)
   
EndIf
EndIf
EndFunction


Function MenuUi_Options_PositionerMenu_SKSE(Int aiButton = 0, Bool abFadeOut = False) ; Show Option Menu
  
    If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)
aiButton= MenuUi_Options_PositionerMenu_SKSE.Show()
  If aibutton == 0
   

   ElseIf aiButton==1
Placeable_SKSE_Positioner_Toggle.cast(PlayerRef)
EndIf
EndIf
EndFunction


;--------------------------------------Place Door------------------------------

Function MenuUi_PlaceActivator_SKSE(Int aiButton = 0) ;Place Door
      aiButton = MenuUi_Place_Door_Activator.show()

    If aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
    Placeable_A_DeleteAll.AddForm(PlaceatMe(Activator01))       
    Delete()
    EndIf

EndFunction 
 
;=========================================================================
;
;                                                                                USE/OPEN DOOR
;
;==========================================================================


Function OpenDoor()
Teleport_Activator.Activate(Game.GetPlayer())
If Self.SetOpen()


Else 
Self.SetOpen(False)
EndIf

EndFunction





