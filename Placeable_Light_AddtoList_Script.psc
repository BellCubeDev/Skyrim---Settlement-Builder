Scriptname SSB_Light_AddtoList_Script extends ObjectReference 





Formlist SSB_A_DeleteAll

Function Oninit() 
;===========================================Delete All Fomlist Property================================================
SSB_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist;  | 
;======================================================================================================================

EndFunction

Event Onload()
SSB_A_DeleteAll.AddForm(Self)
EndEvent
