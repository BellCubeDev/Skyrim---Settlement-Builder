Scriptname SSB_VampireKattle_Script extends ObjectReference  

 
ActorBase Property Thral  Auto
FormList SSB_A_DeleteAll

Event OnInIt()
;============================================Delete All Fomlist========================================================
    SSB_A_DeleteAll = Game.GetFormFromFile(0x00E26327, "LvxMagick - Skyrim - Settlement Builder.Esp") as Formlist;|
;======================================================================================================================
EndEvent

Event OnActivate(ObjectReference akActionRef)

    SSB_A_DeleteAll.AddForm(PlaceatMe(Thral))

    Disable(True)
    
    ;BELL: DeleteWhenAble() waits on repeat, constantly checking whether the Player is in the same cell.
    ;      The goal is to delete an object gracefully, but since you're disabling the object first, this function is not needed.
    
    Delete()
EndEvent
