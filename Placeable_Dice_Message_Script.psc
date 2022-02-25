Scriptname SSB_Dice_Message_Script extends ObjectReference

Message[] Property OutputMessages  Auto

Event OnEquipped(Actor akActionRef)
    If (akActionRef != Game.GetPlayer())
        return ;Not the player
    EndIf
    
    Int iRoll = Utility.RandomInt(0,5)
    OutputMessages[iRoll].Show(iRoll)

EndEvent