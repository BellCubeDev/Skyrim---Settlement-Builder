Scriptname Placeable_ItemAdjustmentScript extends ObjectReference

;/ BellCube's Changes & Notes

Formatted the whole thing! INDENTING FOR EVERYONE!!!

Used ASCII art as section header comments
(generate 'em at https://patorjk.com/software/taag/#p=display&h=0&v=0&f=Big%20Money-nw&t=%48%65%6c%6c%6f%20%66%72%6f%6d%20%42%65%6c%6c%43%75%62%65%21)

Removed the unused "abFade" and "abFadeOut" variables strewn throughout the code

/;

Bool Property __IsActivateable  Auto
{IMPORTANT!!! This bool will determine if special care should be taken for objects the player can otherwise activate!}




;BELL: I saw you called Game.GetPayer() when picking up the item. Normaly I would've changed that to "Actor PlayerREF"
;      However, If you think about it logically, your Game.GetPlayer() is only called once per instance,
;      meaning that filling the PlayerREF variable OnInit() would take unnecessary processing time.


; Auto-Leveling System
Spell Placeable_Auto_Level_Object_Global_Toggle_Spell
GlobalVariable Placeable_AutoLevel_Disabled

Event OnInit()

    ;/ Auto-Level Toggle Spell /; Placeable_Auto_Level_Object_Global_Toggle_Spell = Game.GetFormFromFile(0x00DE456D, "LvxMagick - Skyrim - Settlement Builder.Esm") as Spell

    ;/   Delete All  Fomlist   /; Placeable_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist

    ;/   Auto-Level Objects?   /; Placeable_AutoLevel_Disabled = Game.GetFormFromFile(0x00DD0161, "LvxMagick - Skyrim - Settlement Builder.Esm") as GlobalVariable
    ;debug.Notification(Placeable_AutoLevel_Disabled+": "+Placeable_AutoLevel_Disabled.GetValue())    Debug.Trace("[LVX-SSS] " + Placeable_AutoLevel_Disabled+": "+Placeable_AutoLevel_Disabled.GetValue()

    ;======================================================================================================================

    Placeable__API.AutoLevel(self, !Placeable_AutoLevel_Disabled.GetValueInt())

    If __IsActivateable
        GoToState("")
    EndIf
EndEvent


Event OnActivate(ObjectReference akActionRef)

    ; BELL: Using an AND compareop (comparison operator) gives you nice, simple-to-understand IFs.
    If SKSE.GetVersion() > 0 && (Placeable_Positioner_SKSE_Global.GetValue() == 0.0)
        MenuUi_SKSE() ;use SKSE menu
        return
    else
        Menu() ;use regular menu
    EndIf
Endevent

; BELL: I like to use ASCII art because it's easy to see from a mile away.
;       Plus, when using VSCode (including GitHub.dev), it's readable on the minimap.
