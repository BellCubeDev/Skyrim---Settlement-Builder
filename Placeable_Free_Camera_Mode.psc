Scriptname SSB_Free_Camera_Mode extends activemagiceffect  


Actor Property PlayerRef  Auto



Event OnEffectStart(Actor akTarget, Actor akCaster)


ConsoleUtil.ExecuteCommand("tcl")
Playerref.disable()
Game.EnablePlayerControls()


EndEvent

