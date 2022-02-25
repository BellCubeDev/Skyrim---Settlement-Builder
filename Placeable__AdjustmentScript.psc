Scriptname SSB_ItemAdjustmentScript extends ObjectReference
{Script hooking to the SSB API that blocks activation, instead showing a menu}

Event OnInit()
    self.BlockActivation()
Endevent

Event OnActivate(ObjectReference akActionRef)

Endevent
