Scriptname SSB_Collision_Off_Script extends activemagiceffect  

Event OnEffectStart(Actor akTarget, Actor akCaster)
    Utility.SetINIBool("bDisablePlayerCollision:Havok", True)
EndEvent
Event OnEffectFinish(Actor akTarget, Actor akCaster)
    Utility.SetINIBool("bDisablePlayerCollision:Havok", False)
EndEvent