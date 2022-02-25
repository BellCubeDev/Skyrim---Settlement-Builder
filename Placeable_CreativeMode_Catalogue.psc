            Scriptname SSB_CreativeMode_Catalogue extends activemagiceffect  

Message Property SSB_ManualMenu_CreativeMode_Catalogue  Auto
ObjectReference Property CraftingStation01_Catagory  Auto
ObjectReference Property CraftingStation02_Catagory  Auto
ObjectReference Property CraftingStation03_Catagory  Auto
ObjectReference Property CraftingStation04_Catagory  Auto
ObjectReference Property CraftingStation05_Catagory  Auto
ObjectReference Property CraftingStation06_Catagory  Auto
ObjectReference Property CraftingStation07_Catagory  Auto
ObjectReference Property CraftingStation08_Catagory  Auto
ObjectReference Property CraftingStation09_Catagory  Auto




Event OnEffectStart(Actor akTarget, Actor akCaster)

   Menu()

EndEvent

;----------------------------------------------------------------------------------------------
;MAIN MENU
;---------------------------------------------------------------------------------------------


Function Menu(Int aiButton = 0)
     aiButton = SSB_ManualMenu_CreativeMode_Catalogue.show()

    If aiButton == 1
    CraftingStation01_Catagory.Activate(Game.GetPlayer())   ;Containers
    ElseIf aiButton == 2
    CraftingStation02_Catagory.Activate(Game.GetPlayer())  ;Landscape
    ElseIf aiButton == 3
    CraftingStation03_Catagory.Activate(Game.GetPlayer())  
    ElseIf aiButton == 4
    CraftingStation04_Catagory.Activate(Game.GetPlayer())
    ElseIf aiButton == 5
    CraftingStation05_Catagory.Activate(Game.GetPlayer()) 
    ElseIf aiButton == 6
    CraftingStation06_Catagory.Activate(Game.GetPlayer())
    ElseIf aiButton == 7
    CraftingStation07_Catagory.Activate(Game.GetPlayer())
    ElseIf aiButton == 8
    CraftingStation08_Catagory.Activate(Game.GetPlayer())    
    ElseIf aiButton == 9
    CraftingStation09_Catagory.Activate(Game.GetPlayer())
 EndIf
EndFunction

