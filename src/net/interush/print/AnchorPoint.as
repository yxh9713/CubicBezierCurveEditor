package net.interush.print
{
	import flash.display.Sprite;
	
	public class AnchorPoint extends Sprite
	{	
		public function AnchorPoint(_x:Number=0, _y:Number=0)
		{
			this.buttonMode = true;
			this.graphics.clear();
			this.graphics.beginFill(0x00cc33, .5);
			this.graphics.lineStyle(1,0x000000);
			this.graphics.drawRect(-4,-4,8,8);
			
			this.graphics.endFill();
			this.x = _x;
			this.y = _y;
		}
		
	}
}