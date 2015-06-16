package oc.com.interfaces
{
	public interface IBilling
	{
		 function init(pOnReady:Function):void
		
		/** Do a test purchase.  This will work without charging you real money */
		 function testPurchase():void
		
		
		/** Simulate trying to buy an invalid item */
		 function testUnavailable():void
		
		/** Simulate buying an item that will be rejected by Google */
		 function testCancel():void
		

		/** Refresh the player's inventory from the server.  */
		function reloadInventory(pOnInventory:Function):void
		
		/** Get details, such as price, title, description, etc.- for the given tiems */
		function loadItemDetails(pOnGetItemDetails:Function,items:Vector.<String>):void
		
		/** Update Inventory Message */
		 function updateInventoryMessage():void
			 
		 function get purchasesInventory():Array;
		 
		 function purchaseItem(pItem:String,pOnResponse:Function):void
		 function consumeItem(pItem:String):void
	}

}


