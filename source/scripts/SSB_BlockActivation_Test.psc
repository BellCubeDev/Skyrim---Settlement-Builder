Scriptname SSB_BlockActivation_Test extends ObjectReference  


Function Initialize()
    self.BlockActivation()
    parent.Initialize()
EndFunction

Function UseObject(ObjectReference akActionRef)
    SetSelectedObjectConjured(self)

EndFunction