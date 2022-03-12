Scriptname SSB_ItemAdj_SKSE_Test extends ObjectReference  
 
 
Message Property MenuUi  Auto
Message Property MenuUi_MakeStatic  Auto
Message Property Z_Ui  Auto
Message Property Z_Ui_SKSE  Auto
Message Property Y_Ui  Auto
Message Property Y_Ui_SKSE  Auto
Message Property X_Ui  Auto
Message Property X_Ui_SKSE  Auto
Message Property Rotate_Ui  Auto
Message Property Rotate_Ui_SKSE  Auto
MiscObject property MiscObj  Auto
Static Property StaticDummy  Auto
 
 
 
Event OnActivate(ObjectReference akActionRef)
Game.DisablePlayerControls(False, False, False, False, False, True) ; Ensure MessageBox is not on top of other menus & prevent book from opening normally.
Game.EnablePlayerControls(False, False, False, False, False, True)
 
Menu()
EndEvent
 
 
 
 
 
 
 
Function Menu(Int aiButton = 0)
 
    
      
   aiButton = MenuUi.show()
       
   
 
 
  If aiButton == 1
       Z_Menu_SKSE()
       
 
      ElseIf aiButton == 2
        Y_Menu_SKSE()
      
      ElseIf aiButton == 3
        X_Menu_SKSE()
       
      ElseIf aiButton == 4
      Rotate_Menu_SKSE()
     
      ElseIf aiButton == 5
     self.Disable(True)
     game.getPlayer().addItem(MiscObj)
     DeleteWhenAble()
     Delete()
    ; ElseIf aiButton == 6
     ;MenuUi_MakeStatic() 
       
  
      
     EndIf
 
    EndFunction
 
 
;-------------------------------------------------------------------------------------------SKSE -----------------------------------------------------------------------
 
 
 
Function Z_Menu_SKSE (Int aiButton = 0, Bool abFadeIn = False)
 
 
 
 
 aiButton =  Z_Ui_SKSE.show()
 
 
    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(MiscObj, 1)
    PositionObject.SetMotionType(4) ;static
 
 
   
    Utility.Wait(0.1)
    Self.Disable()
    If aiButton == 0
    Menu()
  
   Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        PositionObject.Delete()
           
   
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
    EndIf
   EndFunction
 
;---------------------------------------------------------------------------------Function_Y_SKSE-------------------------------------
 
Function Y_Menu_SKSE( Int aiButton = 0, Bool abFadeIn = False)
 
 
 aiButton =  Y_Ui_SKSE.show()
   
    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(MiscObj, 1)
    PositionObject.SetMotionType(4) ;static
 
 
 
    Utility.Wait(0.1)
    Self.Disable()
    
  If aiButton == 0
     Menu()
  
   Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
           
   
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
    EndIf
    EndFunction
 
    
;----------------------------------------------------------------------------------Funtion_X_SKSE-----------------------------------------------------------
 
 
 
Function X_Menu_SKSE( Int aiButton = 0, Bool abFadeIn = False)

 
 aiButton =  X_Ui_SKSE.show()
   
    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(MiscObj, 1)
    PositionObject.SetMotionType(4) ;static
 
 
  If aiButton == 0
      Menu()
  
   Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        Self.Enable()
        PositionObject.Delete()
           
   
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
    
EndIf
EndFunction
 
;--------------------------------------------------------------------------------Rotate_SKSE------------------------------------------------------------------
 
Function Rotate_Menu_SKSE( Int aiButton = 0, Bool abFadeOut = False)






    aiButton =  Rotate_Ui_SKSE.show()
   
    Utility.Wait(0.1)
    Self.Disable()
    ObjectReference PositionObject = Self.PlaceAtMe(MiscObj, 1)
    PositionObject.SetMotionType(4) ;static




   
    Utility.Wait(0.1)
    Self.Disable()
    If aiButton == 0
        Menu()
  
        Utility.Wait(0.1)
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())  ;Make sure the MISC object Disapears 
        PositionObject.Disable()
        PositionObject.Delete()
           
   
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
    EndIf
EndFunction



;-----------------------------------------------------------------------------------------------------------------Make Static--------------------------------------------------------------------------


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

