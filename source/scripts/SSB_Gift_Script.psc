Scriptname SSB_Gift_Script extends ObjectReference  

Armor Property Boots  Auto
Book Property Gift_Card  Auto

Event OnRead()

game.getPlayer().addItem(Boots)
Game.GetPlayer().RemoveItem(Gift_Card)

EndEvent

