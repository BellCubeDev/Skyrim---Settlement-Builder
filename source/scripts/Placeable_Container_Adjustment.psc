Scriptname SSB_Container_Adjustment extends ObjectReference  

  

ObjectReference Property Activate_Object  Auto 
Message Property MenuUi_Make_Container_Permanent  Auto
Message Property MenuUi_Container_Placement  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
Message Property Rotate_Ui  Auto
Message Property MenuUi_PositionSelect_Container  Auto
Message Property MenuUi_Make_BuryContainer_Static  Auto
MiscObject property MiscObj  Auto
MiscObject Property Shovel01  Auto
MiscObject Property Shovel02  Auto
Activator Property Permanent_ContainerAct  Auto
Activator Property Activator_Dirt_Pile  Auto
Activator Property DummyActivator  Auto
Sound Property SSB_NPCHumanShovel  Auto
Sound Property SSB_NPCHumanShovelDump  Auto

;----------------------------------------------SKSE Properys---------------------------------

Actor Property PlayerREf  Auto
GlobalVariable Property SSB_Positioner_SKSE_Global  Auto

Message Property MenuUi  Auto
Message Property MenuUi_SKSE  Auto
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
Activator Property My_Activator_Static  Auto
Static Property StaticDummy  Auto
Spell Property SSB_SKSE_Positioner_Toggle  Auto

FormList SSB_A_DeleteAll; RESET MODE Formlist!!!


;----------------------------------------Auto - Object Leveling - System ----------------------------------------------------------------------------
Spell SSB_Auto_Level_Object_Global_Toggle_Spell
GlobalVariable SSB_Auto_Leveling_Items

Event OnInit() ; This event will run once, when the script is initialized
    BlockActivation(self) 
                                                ;Caution
;===========================================Delete All Fomlist Property================================================
SSB_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist;  | 
;======================================================================================================================

    SSB_Auto_Level_Object_Global_Toggle_Spell = Game.GetFormFromFile(0x00DE456D, "LvxMagicks-CampfireUnleashed.Esm") as Spell ;Auto Level Object Spell Formlist

    SSB_Auto_Leveling_Items = Game.GetFormFromFile(0x00DD0161, "LvxMagicks-CampfireUnleashed.Esm") as GlobalVariable ; Auto Level Object Global Var Formlist
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
;-------------------------------------------------------------------------------------------------------------------------------------------



;----------------------------------------------------------------SKSE CHECKER--------------------------------------
Event OnActivate(ObjectReference akActionRef)
BlockActivation(self)

 If SKSE.GetVersion() > 0                                   ;is SKSE present
    If (SSB_Positioner_SKSE_Global.GetValue() == 0.0)    ;is SKSE menu choice selected
      MenuUi_SKSE()                                              ;use SKSE menu
    Else                                                       ;otherwise 
      Menu()                                                     ;use regular menu
    EndIf
  Else                                                       ;otherwise
    Menu()                                                     ;use regular menu
  EndIf
EndEvent










;-----------------------------------------------------------------------Main Menu---------------------------



Function Menu(Int aiButton = 0)
      aiButton = MenuUi_Container_Placement.show()
                Utility.Wait(0.1)
    
If aiButton == 0            ;Open Container
    Self.SetOpen()
      Utility.Wait(0.0)
      Activate_Object.Activate(Game.Getplayer())
      Registerforsingleupdate(1.0)
      OnUpdate()
    If ( ! Game.IsLookingControlsEnabled() )
      RegisterForSingleUpdate(0.5)
    return
    else
      Utility.Wait(0.5) 
    Self.SetOpen(False)  ;Close Container
      EndIf

 
    ElseIf aiButton == 1        ;Position Select
      MenuUi_PositionSelect_Container()

             
    ElseIf aiButton == 2       ;Bury Container
        Bury_Container() 



    ElseIf aiButton == 3     ;Pickup Container
    self.Disable(True)
        game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()
        
      EndIf
      EndFunction

;--------------------------------------------------------------------------Main Menu Positioner -------------------------------------

Function MenuUi_PositionSelect_Container(Int aiButton = 0)      ;Position Menu
      aiButton = MenuUi_PositionSelect_Container.show()

    If aiButton == 1
        Z_Menu()
    ElseIf aiButton == 2
        Y_Menu()
    ElseIf aiButton == 3
        X_Menu()
    ElseIf aiButton == 4  
        Rotate_Menu()
    
     ElseIf aiButton == 5                                     ;Level Object Angle
     Auto_Level_Button()
           

      ElseIf aiButton == 6                                    ; Pick Up Container
      self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        Delete()
     
     ElseIf aiButton == 7   ; Options
      MenuUi_Options()


    ElseIf aiButton == 8
      MenuUi_Make_Container_Permanent_SKSE() 


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

;---------------------------------------------------------------------------------------------------------------------------------------------------------------------



;--------------------------------------------Z_Menu---------------------------------------

Function Z_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)   ;Height
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Z_Ui.show()
     If aiButton == 0
     abMenu = False
     MenuUi_PositionSelect_Container()
   ElseIf aiButton == 1
       SetPosition(X , Y, Z *1 - 50)
       Enable()
   ElseIf aiButton == 2
       SetPosition(X , Y, Z*1 - 30 )
       Enable()
    ElseIf aiButton == 3
      SetPosition(X , Y, Z*1 - 10)
      Enable()
    ElseIf aiButton == 4
      SetPosition(X , Y, Z*1 - 1)
      Enable()
    ElseIf aiButton == 5
      SetPosition(X , Y, Z*1 + 1)
      Enable()
    ElseIf aiButton == 6
      SetPosition(X , Y, Z*1 + 10)
      Enable()
    ElseIf aiButton == 7
      SetPosition(X , Y, Z*1 + 30)
      Enable()
     ElseIf aiButton == 8
      SetPosition(X , Y, Z*1 + 50)
      Enable()
    EndIf
    EndIf
    EndWhile
EndFunction

;---------------------------------------------------Y_Menu----------------------------------

Function Y_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Y_Ui.show()
     If aiButton == 0
     abMenu = False
     MenuUi_PositionSelect_Container()
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

;-----------------------------------------------------------X_Menu---------------------------

Function X_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  X_Ui.show()
       If aiButton == 0
     abMenu = False
     MenuUi_PositionSelect_Container()
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

 ;-----------------------------------------------------Rotate_Menu--------------------------------

Function Rotate_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False) ;Rotation
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Rotate_Ui.show()
      If aiButton == 0
     abMenu = False
     MenuUi_PositionSelect_Container()

     ElseIf aiButton == 1
           SetAngle(0.0, 0.0, self.GetAngleZ() - 50.0)
           Enable()    
     
     ElseIf aiButton == 2
           SetAngle(0.0, 0.0, self.GetAngleZ() - 30.0)
           Enable()   
     
        ElseIf aiButton == 3
           SetAngle(0.0, 0.0, self.GetAngleZ() - 10.0)
           Enable()    
               
             ElseIf aiButton == 4
           SetAngle(0.0, 0.0, self.GetAngleZ() - 1.0)
           Enable()    
 
    ElseIf aiButton == 5
           SetAngle(0.0, 0.0, self.GetAngleZ() + 1.0)
           Enable()   
 
    ElseIf aiButton == 6
           SetAngle(0.0, 0.0, self.GetAngleZ() + 10.0)
           Enable()    
     
     ElseIf aiButton == 7
           SetAngle(0.0, 0.0, self.GetAngleZ() + 30.0)
           Enable()   

        
     ElseIf aiButton == 8
           SetAngle(0.0, 0.0, self.GetAngleZ() + 50.0)
           Enable()   


          
    EndIf
    EndIf
    EndWhile
EndFunction


;-----------------------------------------------------Bury Container---------------------------

Function Bury_Container(Int aiButton = 0) 
   aiButton = MenuUi_Make_BuryContainer_Static.show() ;Burry Container

   If aiButton == 0
     Menu()

    ElseIf aiButton == 1    ; Bury Container
    
If (Game.GetPlayer().GetItemCount(Shovel01) >= 1) || (Game.GetPlayer().GetItemCount(Shovel02) >= 1)

   Game.FadeOutGame(True, True, 2.0, 3.0)            
   SSB_NPCHumanShovel.Play(Game.GetPlayer())
   Utility.Wait(1.0) 
   SSB_NPCHumanShovel.Play(Game.GetPlayer())
   Utility.Wait(1.0)  
   SSB_NPCHumanShovel.Play(Game.GetPlayer())
   Utility.Wait(1.0)
   SSB_NPCHumanShovelDump.Play(Game.GetPlayer())
   Game.FadeOutGame(False, True, 5.0, 3.0)
   DisableNoWait(True)
   Disable(True)
   SSB_A_DeleteAll.AddForm(PlaceatMe(Activator_Dirt_Pile))   
   DeleteWhenAble()
   Delete()
  
ElseIf debug.messagebox("You need a shovel to bury this Container.")
EndIf
EndIf 
EndFunction




;-----------------------------------------------------------------------------------------Mani Menu SKSE----------------------------------


Function MenuUi_SKSE(Int aiButton = 0)
      aiButton = MenuUi_Container_Placement.show()
                Utility.Wait(0.1)
    
If aiButton == 0            ;Open Container
     Self.SetOpen()
     Utility.Wait(0.5)
     Activate_Object.Activate(Game.Getplayer())
      Registerforsingleupdate(1.0)
      OnUpdate()
      If ( ! Game.IsLookingControlsEnabled() )
      RegisterForSingleUpdate(0.5)
      return
      else
      Utility.Wait(0.5) 
      Self.SetOpen(False)  ;Close Container
      EndIf

 
      ElseIf aiButton == 1        ;Position Select
      MenuUi_PositionSelect_Container_SKSE()

             
    ElseIf aiButton == 2 
    Bury_Container() 



      ElseIf aiButton == 3     ;Pickup Container
        Disable(True)
        Game.GetPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()
        
      EndIf
      EndFunction








;-------------------------------------------------------------------------------------------SKSE Main Menu Positioner -----------------------------------------------------------------------





Function MenuUi_PositionSelect_Container_SKSE(Bool abFadeIn = False)
   Int aiButton =  MenuUi_SKSE.show()       
      

       ;Debug.Notification("SKSE Positioner Active")       
      

       Debug.Trace("[LVX-SSS] SKSE Positioner Active")
    If aiButton == 1
        Z_Menu_SKSE()
    ElseIf aiButton == 2
        Y_Menu_SKSE()
    ElseIf aiButton == 3
        X_Menu_SKSE()
    
      ElseIf aiButton == 4
    Rotate_Menu_SKSE()
    ;Debug.Notification("Object is facing "+ GetAngleZ()+" Degrees")
    Debug.Trace("[LVX-SSS] Object is facing "+ GetAngleZ()
    Utility.wait(0.1)
 
     
        ElseIf aiButton == 5                                     ;Level Object Angle
    Auto_Level_Button()
  
    
      ElseIf aiButton == 6
       self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        Delete()
     
     ElseIf aiButton == 7                                       ; Options
      MenuUi_Options_SKSE()


    ElseIf aiButton == 8
      MenuUi_Make_Container_Permanent_SKSE() 
 
       
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
    Disable()
    ObjectReference PositionObject = PlaceAtMe(StaticDummy, 1)
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
SSB_SKSE_Positioner_Toggle.cast(PlayerRef)

   ElseIf aiButton == 2
   SSB_Auto_Level_Object_Global_Toggle_Spell.cast(PlayerRef)

EndIf
EndIf

EndFunction





;-----------------------------------------------------------------------------------------------------------------Options_SKSE------------------------------------------------------------------------------

Function MenuUi_Options_SKSE(Int aiButton = 0, Bool abFadeOut = False)
   
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  MenuUi_Options_SKSE.show()
      If aiButton == 0
     

   
   ElseIf aiButton==1
   MenuUi_Options_PositionerMenu_SKSE()

   ElseIf aiButton == 2
   SSB_Auto_Level_Object_Global_Toggle_Spell.cast(PlayerRef)
   
EndIf
EndIf
EndFunction


Function MenuUi_Options_PositionerMenu_SKSE(Int aiButton = 0, Bool abFadeOut = False) ; Show Option Menu
  
    If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)
aiButton= MenuUi_Options_PositionerMenu_SKSE.Show()
  If aibutton == 0
   

   ElseIf aiButton==1
SSB_SKSE_Positioner_Toggle.cast(PlayerRef)
EndIf
EndIf
EndFunction


;-------------------------------------------------Make Container Permanent SKSE--------------------------

;Places Activator Chest Permanently
Function MenuUi_Make_Container_Permanent_SKSE(Int aiButton = 0) ;Make Container Permanent
      aiButton = MenuUi_Make_Container_Permanent.show()

   
     If aiButton == 0
    MenuUi_PositionSelect_Container()


    ElseIf aiButton == 1              ;Make Container Permanent Static
    DisableNoWait(True)
    Disable(True)
    SSB_A_DeleteAll.AddForm(PlaceatMe(Permanent_ContainerAct)) ;Adds to List
    DeleteWhenAble()
    Delete()
    
   
   ElseIf aiButton == 2
   Disable(True)
   SSB_A_DeleteAll.AddForm(PlaceatMe(DummyActivator)) ;Adds to List
   DeleteWhenAble()
   Delete()
   
   
EndIf
EndFunction 


 