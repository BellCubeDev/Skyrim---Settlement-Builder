Scriptname SSB_XBOX_Position_SKSE_SUb extends ObjectReference  







Actor Property PlayerRef  Auto 
Static Property Gargoyle  Auto 

GlobalVariable Property PositionType  Auto
Message Property MainPositionMessage  Auto
Message Property PositionMove  Auto 
Message Property PositionRotate  Auto 
Message Property PositionScale  Auto 

ObjectReference PositionObject
Bool Position 
Float StartScale

Event OnActivate(ObjectReference akActionRef)
    ;PositionObject.Delete() ;Deletes previous position object
    StartScale = Self.GetScale()
    PositionObject = Self.PlaceAtMe(Gargoyle, 1)
    Self.Disable()
    PositionObject.SetScale(StartScale)
    Debug.ToggleAi()
    Utility.Wait(0.5)
    MainPositionMenu()
EndEvent 


Function MainPositionMenu()
    Int Button = MainPositionMessage.Show() 
   
    If Button == 0
        ;done positioning
        Debug.ToggleAi()
       
        Self.SetPosition(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ())
        Self.SetAngle(PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ())
        Self.SetScale(PositionObject.GetScale())
        PositionObject.Disable()
        PositionObject.Delete()
        Self.Enable()
        
    ElseIf Button == 1 
        MoveMenu()
           
    Elseif Button == 2 
        RotateMenu()
       
    Elseif Button == 3 
        ScaleMenu()
        
    Elseif Button == 4
        Debug.ToggleAi()
        PositionObject = none 
        Self.Delete()
    EndIf
            
EndFunction
    
Function MoveMenu()
    PlayerRef.DrawWeapon()
    Utility.Wait(0.3)
    Int Button = PositionMove.Show() 
    
    If Button == 0
        MainPositionMenu()
        
    Elseif Button == 1 ;z up 
        While PlayerRef.IsWeaponDrawn()   ;moves object up until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), (PositionObject.GetPositionZ() + 2), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.1)
        Utility.Wait(0.2)
        MoveMenu()
        
    Elseif Button == 2 ;z down
        While PlayerRef.IsWeaponDrawn()   ;moves object up until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), (PositionObject.GetPositionZ() - 2), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
       
        Utility.Wait(0.2)
        MoveMenu()
        
    Elseif Button == 3 ;x up
         While PlayerRef.IsWeaponDrawn()   ;moves object until the player Sheaths Hands
            
            PositionObject.TranslateTo((PositionObject.GetPositionX() + 2), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
       
        Utility.Wait(0.2)
        MoveMenu()
        
    Elseif Button == 4 ;x down
         While PlayerRef.IsWeaponDrawn()   ;moves object until the player Sheaths Hands
            
            PositionObject.TranslateTo((PositionObject.GetPositionX() - 2), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        MoveMenu() 
        
    Elseif Button == 5 ;y up
        While PlayerRef.IsWeaponDrawn()   ;moves object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), (PositionObject.GetPositionY() + 2), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        MoveMenu() 
        
    Elseif Button == 6 ;y down
        While PlayerRef.IsWeaponDrawn()   ;moves object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), (PositionObject.GetPositionY() - 2), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        MoveMenu() 
    EndIf
EndFunction

Function RotateMenu()
    PlayerRef.DrawWeapon()
    Utility.Wait(0.3)
    Int Button = PositionRotate.Show() 
    
    If Button == 0
        MainPositionMenu()
        
    Elseif Button == 1 ;z up 
        While PlayerRef.IsWeaponDrawn()   ;angles object until the player Sheaths Hands
            
           PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), (PositionObject.GetAngleZ() + 2), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        RotateMenu()
        
    Elseif Button == 2 ;z down
        While PlayerRef.IsWeaponDrawn()   ;angles object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), PositionObject.GetAngleY(), (PositionObject.GetAngleZ() - 2), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        RotateMenu()
        
    Elseif Button == 3 ;x up
        While PlayerRef.IsWeaponDrawn()   ;angles object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), (PositionObject.GetAngleX() + 2), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        RotateMenu()
        
    Elseif Button == 4 ;x down
        While PlayerRef.IsWeaponDrawn()   ;angles object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), (PositionObject.GetAngleX() - 2), PositionObject.GetAngleY(), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile
      
        Utility.Wait(0.2)
        RotateMenu()
        
    Elseif Button == 5 ;y up
        While PlayerRef.IsWeaponDrawn()   ;angles object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), (PositionObject.GetAngleY() + 2), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        RotateMenu()
        
    Elseif Button == 6 ;y down
        While PlayerRef.IsWeaponDrawn()   ;angles object until the player Sheaths Hands
            
            PositionObject.TranslateTo(PositionObject.GetPositionX(), PositionObject.GetPositionY(), PositionObject.GetPositionZ(), PositionObject.GetAngleX(), (PositionObject.GetAngleY() - 2), PositionObject.GetAngleZ(), 500, 0)    
        EndWhile

        Utility.Wait(0.2)
        RotateMenu()
        
    Elseif Button == 7 
        PositionObject.SetAngle(0, 0, 0)
        Utility.Wait(0.2)
        RotateMenu()
    EndIf
EndFunction

Function ScaleMenu() 
    PlayerRef.DrawWeapon()
    Utility.Wait(0.3)
    Int Button = PositionScale.Show() 
    
    If Button == 0
        MainPositionMenu()
        
    Elseif Button == 1
        While PlayerRef.IsWeaponDrawn() 
            PositionObject.SetScale(PositionObject.GetScale() + 0.01) 
        EndWhile 
       
        Utility.Wait(0.2)
        ScaleMenu() 
        
    Elseif Button == 2
        While PlayerRef.IsWeaponDrawn() 
            PositionObject.SetScale(PositionObject.GetScale() - 0.01) 
        EndWhile 
        
        Utility.Wait(0.2)
        ScaleMenu() 
        
    Elseif Button == 3
        PositionObject.SetScale(StartScale)
        Utility.Wait(0.2)
        ScaleMenu() 
    Elseif Button == 4
        PositionObject.SetScale(1.0)
        Utility.Wait(0.2)
        ScaleMenu() 
    EndIf
EndFunction