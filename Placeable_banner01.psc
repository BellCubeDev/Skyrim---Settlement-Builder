Scriptname SSB_Banner01_Script extends ObjectReference  



 

;====================================================================================


;Activator Property PlaceableObject_Ind  Auto
Activator Property Banner_Act  Auto
MiscObject Property Misc_ObjectKit  Auto

Message Property MenuUi_Misc_Adjust_MSG  Auto


       




Actor Property PlayerRef  Auto

Event OnLoad()
    Utility.Wait(2.0)
    Posmenu()

EndEvent

;Event OnEquipped(Actor akActor)
    ;If !Loaded
        ;If IsOptionState
        ;    GoToState(" IsOptionState")
        ;Else
        ;    GoToState("PlaceItem")
        ;EndIf
    ;EndIf
;EndEvent

;====================================================================================




 Function Posmenu(Bool abMenu = False, Int aiButton = 0, Bool abFadeOut = False)
   ;While abMenu
       If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)
    Int  aiButton = MenuUi_Misc_Adjust_MSG.show()
     
    Float PosX = Self.GetPositionX()
    Float PosY = Self.GetPositionY()
    
        
        If aiButton == 0
            ;abMenu = False                        ;Move Up
            Self.SetPosition(PosX, PosY, Self.GetPositionZ() + 20.0)
            Self.Disable()
            Self.Enable()
            
            
        ElseIf aiButton == 1                    ;Move Down
            Self.SetPosition(PosX, PosY, Self.GetPositionZ() - 20.0)
            Self.Disable()
            Self.Enable()
            
        ElseIf aiButton == 2                    ;Turn Left
            Self.SetAngle(0.0, 0.0, Self.GetAngleZ() + 15.0)
            Self.Disable()
            Self.Enable()
            
        ElseIf aiButton == 3                    ;Turn Right
            Self.SetAngle(0.0, 0.0, Self.GetAngleZ() - 15.0)
            Self.Disable()
            Self.Enable()
            
        ElseIf aiButton == 4                    ;Start Over
            Self.Disable()
            Self.Delete()
            PlayerRef.AddItem(Misc_ObjectKit)
            
            
        ElseIf aiButton == 5                    ;Finalize
            
            End_Function()

            Self.Disable()
            Self.Delete()
            Self.PlaceatMe(Banner_Act)       
            Self.DeleteWhenAble()
                      Delete()
                    
    
    
   EndIf
   EndIf
  ; EndWhile
EndFunction

Function End_Function()
;Dead Function
;Exit Menu
EndFunction


;====================================================================================

;State PlaceItem

    ;Event OnBeginState()
        ;Useable_Obj_Act = PlayerRef.PlaceAtMe(PlaceableObject_Ind)
        ;Useable_Obj_Act.MoveTo(PlayerRef, 250.0 * Math.Sin(PlayerRef.GetAngleZ()), 250.0 * Math.Cos(PlayerRef.GetAngleZ()), 170.0)
        ;Useable_Obj_Act.SetAngle(0.0, 0.0, Useable_Obj_Act.GetAngleZ() - 90)
        ;If Loaded
            ;Self.Disable()
            ;Self.Delete()
        ;Else
            ;PlayerRef.RemoveItem(Misc_ObjectKit, 1, True)
        ;EndIf
        ;SoundFX.Play(Useable_Obj_Act)
        ;PosMenu(Useable_Obj_Act)
    ;EndEvent

;EndState

;====================================================================================

;State Dead
;EndState