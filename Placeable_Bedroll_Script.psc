Scriptname Placeable_Bedroll_Script extends ObjectReference  


Message Property Bedroll_Ui  Auto
furniture Property Bedroll01  Auto 
MiscObject Property MiscObj  Auto


Event OnActivate(ObjectReference akActionRef)
Menu()
EndEvent

Function Menu(Int aiButton = 0)
      aiButton = Bedroll_Ui.Show()

    If aiButton == 1         ; Unroll Bedolll  
     PlaceAtMe(Bedroll01)
     self.Disable(True)
        DeleteWhenAble()
        Delete()


 ElseIf aiButton == 2  ; Pickup
       
       ElseIf aiButton == 5
       self.Disable(True)
       game.getPlayer().addItem(MiscObj)
        DeleteWhenAble()
        Delete()


EndIf
EndFunction






