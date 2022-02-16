Scriptname BTDBuryActor extends activemagiceffect  

Import Math

Activator Property TombStone  Auto
ObjectReference theTomb
BTDVars Property BTDQuest  Auto

Event OnEffectFinish(Actor akTarget, Actor akCaster)
    If (akCaster == Game.GetPlayer() && akTarget.IsDead() == 1)
        akTarget.Disable()
        String NPCName = akTarget.GetBaseObject().GetName()
        BTDQuest.actorName = NPCName
        BTDQuest.DateOfDeath = Utility.GameTimeToString(Ceiling(Utility.GetCurrentGameTime())+1)
        BTDQuest.TheDeceased = akTarget
        theTomb = akTarget.PlaceAtMe(TombStone)
        theTomb.SetPosition(theTomb.GetPositionX(), theTomb.GetPositionY(), theTomb.GetPositionZ())
        theTomb.SetAngle(Utility.RandomInt(-5, 5), Utility.RandomInt(-5, 5), theTomb.GetAngleZ() )
    EndIf
EndEvent