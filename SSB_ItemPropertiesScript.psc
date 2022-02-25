Scriptname SSB_PlacedObjectPropertiesScript extends ObjectReference
{Script to hold properties for access by other scripts. This script doesn't hold any events or functions.}

MiscObject Property Inventory_MiscItem  Auto
{Inventory item for this placed object}

Static Property Dummy_Static  Auto
{Dummy/permanent static for this placed object}
Activator Property Dummy_Activator  Auto
{Dummy/permanent activator for this placed object}

Bool Property __IsActivateable  Auto
{IMPORTANT!!!
This bool will determine if special accomidations will be made for objects that can be normaly activated}
