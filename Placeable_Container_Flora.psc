Scriptname Placeable_Container_Flora extends ObjectReference  


ObjectReference Property Activate_Object  Auto 
Message Property Menu_Action  Auto
Message Property  MenuUi_PositionSelect_Container  Auto
Message Property  Z_Ui  Auto
Message Property   Y_Ui  Auto
Message Property  X_Ui  Auto
Message Property Rotate_Ui  Auto
Message Property MenuUi_Make_Container_Static  Auto
Message Property MenuUi_Make_NoneContainer_Static  Auto
Message Property MenuUi_Action_Flora  Auto
Message Property MenuUi_Plant_Flora_Static  Auto
MiscObject property MiscObj  Auto
MiscObject Property Shovel01  Auto
MiscObject Property Shovel02  Auto
Activator Property ContainerAct  Auto
flora Property Plant01  Auto
Static Property StaticDummy  Auto
Sound Property SSB_NPCHumanShovel  Auto
Sound Property SSB_NPCHumanShovelDump  Auto


Formlist Placeable_A_DeleteAll 


Event OnInit() ; This event will run once, when the script is initialized
    
;===========================================Delete All Fomlist Property================================================
Placeable_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist;  | 
;======================================================================================================================
EndEvent


Event OnActivate(ObjectReference akActionRef)
self.BlockActivation()

 Menu()
EndEvent



Function Menu(Int aiButton = 0)
      aiButton = MenuUi_Action_Flora.show()
      self.BlockActivation()


If aiButton == 0
     Activate_Object.Activate(Game.Getplayer())

 
      ElseIf aiButton == 1
     Plant_Flora()
    
       ElseIf aiButton == 2
      MenuUi_PositionSelect_Container()



     ElseIf aiButton == 3
        self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()

       
     EndIf
EndFunction


Function MenuUi_PositionSelect_Container(Int aiButton = 0)
      aiButton = MenuUi_PositionSelect_Container.show()

    If aiButton == 1
        Z_Menu()
    ElseIf aiButton == 2
        Y_Menu()
    ElseIf aiButton == 3
        X_Menu()
    ElseIf aiButton == 4  
        Rotate_Menu()
      ElseIf aiButton == 5
     MenuUi_Make_Container_Static() 


     EndIf

EndFunction


Function Z_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Z_Ui.show()
     If aiButton == 0
     abMenu = False
     MenuUi_PositionSelect_Container()
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

 

Function Rotate_Menu(Bool abMenu = True, Int aiButton = 0, Bool abFadeOut = False)
   While abMenu
   If aiButton != -1 ; Wait for input (this can prevent problems If recycling the aiButton argument in submenus)   
   aiButton =  Rotate_Ui.show()
      If aiButton == 0
     abMenu = False
     MenuUi_PositionSelect_Container()

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


;Places Activator Chest
Function MenuUi_Make_Container_Static(Int aiButton = 0) ;Make Static Container
      aiButton = MenuUi_Make_Container_Static.show()

   
     If aiButton == 0
    MenuUi_PositionSelect_Container()


    ElseIf aiButton == 1
    DisableNoWait(True)
    Self.Disable(True)
   Self.PlaceatMe(ContainerAct)       
    Self.DeleteWhenAble()
     Delete()
    
   
   ElseIf aiButton == 2
  MenuUi_Make_NoneContainer_Static()

EndIf
EndFunction 

Function MenuUi_Make_NoneContainer_Static(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_Make_NoneContainer_Static.show()

   If aiButton == 0
     MenuUi_Make_Container_Static()

    ElseIf aiButton == 1
    DisableNoWait(True)
    Disable(True)
    Placeable_A_DeleteAll.AddForm(PlaceatMe(StaticDummy))       
    DeleteWhenAble()
    Delete()
    
EndIf
EndFunction 



Function Plant_Flora(Int aiButton = 0) ;Make Static
      aiButton = MenuUi_Plant_Flora_Static.show()

   If aiButton == 0
     Menu()

    ElseIf aiButton == 1    ; Plant Crop
    
If (Game.GetPlayer().GetItemCount(Shovel01) >= 1) || (Game.GetPlayer().GetItemCount(Shovel02) >= 1)

          Game.FadeOutGame(True, True, 2.0, 3.0)            
   Placeable_NPCHumanShovel.Play(Game.GetPlayer())
   Utility.Wait(1.0) 
   Placeable_NPCHumanShovel.Play(Game.GetPlayer())
   Utility.Wait(1.0)  
   Placeable_NPCHumanShovel.Play(Game.GetPlayer())
   Utility.Wait(1.0)
   Placeable_NPCHumanShovelDump.Play(Game.GetPlayer())
   Game.FadeOutGame(False, True, 5.0, 3.0)
   DisableNoWait(True)
   Disable(True)
   Placeable_A_DeleteAll.AddForm(PlaceatMe(Plant01)) 
   DeleteWhenAble()
   Delete()
  
ElseIf debug.messagebox("You need a shovel to plant this crop.")

EndIf
EndIf
EndFunction 



