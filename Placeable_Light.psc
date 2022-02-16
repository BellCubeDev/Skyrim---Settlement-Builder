Scriptname Placeable_Light extends ObjectReference  



GlobalVariable Property IO_01  Auto
Activator property Candelabra_ON  Auto
Activator Property Candelabra_OFF  Auto
Light Property Candle_Light_Default  Auto


Event OnInit()
    RegisterForSingleUpdate(1.0)
EndEvent

Event OnUpdate()
    If (IO_01.GetValue() as Bool)
        Enable()
 DisableNoWait(True)
    Self.Disable(True)
   Self.PlaceatMe(Candelabra_ON)
   ObjectReference tempLight = Self.PlaceAtMe(Candle_Light_Default)
   Self.PlaceAtMe(Candle_Light_Default)       
   Self.DeleteWhenAble()
     Delete()
  
       Else
        Disable()
 DisableNoWait(True)
    Self.Disable(True)
   Self.PlaceatMe(Candelabra_Off)       
      
  Self.DeleteWhenAble()
     Delete()
    EndIf

    RegisterForSingleUpdate(1.0)
EndEvent


