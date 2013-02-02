package net.interush.print
{
	import flash.display.Sprite;
	
	public class HandlePoint extends Sprite
	{	
		public function HandlePoint(_x:Number=0, _y:Number=0)
		{
			this.buttonMode = true;
			this.graphics.clear();
			
			this.graphics.beginFill(0xFF00FF, .2);
			this.graphics.lineStyle(1,0x000000);
			this.graphics.drawCircle(0,0,4);
			
			this.graphics.endFill();
			this.x = _x;
			this.y = _y;
		}
		
	}
}