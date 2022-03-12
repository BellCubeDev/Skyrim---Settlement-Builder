Scriptname SSB_FastMerchant_Script extends activemagiceffect  

Message Property MyMessage  Auto
Actor Property Merchant  Auto



Event OnEffectStart(Actor akTarget, Actor akCaster)

  MyMessage.show()
  Merchant.ShowBarterMenu()

EndEvent

