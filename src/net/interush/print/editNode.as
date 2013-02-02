package net.interush.print
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.interush.print.AnchorPoint;
	import net.interush.print.HandlePoint;
	
	public class editNode extends Sprite
	{
		private var anchor:AnchorPoint;
		private var handle1Pt:HandlePoint;
		private var handle2Pt:HandlePoint;
		public var anchorXY:Point;
		public var handle1XY:Point;
		public var handle2XY:Point;
		private var handleLine:Sprite;
		private var selectedPoint:Sprite;
		private var selected:String;
		private var anchorOffset:Point;
		
		public function editNode(anchorX:Number,anchorY:Number,cx1:Number,cy1:Number)
		{
			anchorXY = new Point(anchorX,anchorY);
			handle1XY = new Point(cx1,cy1);
			handle2XY = Point.interpolate(new Point(cx1,cy1),new Point(anchorX,anchorY),-1);
			
			anchor = new AnchorPoint(anchorX,anchorY);
			anchor.name = 'anchor';
			
			handle1Pt = new HandlePoint(cx1,cy1);
			handle1Pt.name = 'handle1';
			
			handle2Pt = new HandlePoint(handle2XY.x,handle2XY.y);
			handle2Pt.name = 'handle2';		
			
			handleLine = new Sprite;
			
			addChild(handleLine);
			addChild(anchor);
			addChild(handle1Pt);
			addChild(handle2Pt);

			anchor.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			handle1Pt.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			handle2Pt.addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			drawHandle();
		}
		
		public function onDown(e:MouseEvent)
		{
			selected = e.target.name;
			selectedPoint = e.target as Sprite;
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onUp);
		}
		
		private function onMove(e:MouseEvent)
		{
			selectedPoint.startDrag();
			
			if(selected == 'anchor')
			{
				var newPosition:Point = new Point(selectedPoint.x, selectedPoint.y);
				anchorOffset = anchorXY.subtract(newPosition);
				anchorXY.x = selectedPoint.x;
				anchorXY.y = selectedPoint.y;
			} 
			else if(selected == 'handle1') 
			{
				handle1XY.x = selectedPoint.x;
				handle1XY.y = selectedPoint.y;
			} 
			else if(selected == 'handle2') 
			{
				handle2XY.x = selectedPoint.x;
				handle2XY.y = selectedPoint.y;
			}
			drawHandle();
		}
		private function onUp(e:MouseEvent)
		{
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, onMove);
			stage.removeEventListener(MouseEvent.MOUSE_UP, onUp);
			selectedPoint.stopDrag();
		}
		
		private function drawHandle()
		{
			if(selected == 'handle1') 
			{
				handle2XY = Point.interpolate(handle1XY,anchorXY,-1);
				handle2Pt.x = handle2XY.x;
				handle2Pt.y = handle2XY.y;
			} 
			else if(selected == 'handle2') 
			{
				handle1XY = Point.interpolate(handle2XY,anchorXY,-1);
				handle1Pt.x = handle1XY.x;
				handle1Pt.y = handle1XY.y;
			}
			else if(selected == 'anchor')
			{
				handle1XY = handle1XY.subtract(anchorOffset);
				handle2XY = Point.interpolate(handle1XY,anchorXY,-1);
				handle1Pt.x = handle1XY.x;
				handle1Pt.y = handle1XY.y;
				handle2Pt.x = handle2XY.x;
				handle2Pt.y = handle2XY.y;
			}
			
			handleLine.graphics.clear();
			handleLine.graphics.lineStyle(1,0x666666);
			handleLine.graphics.moveTo(anchorXY.x,anchorXY.y);
			handleLine.graphics.lineTo(handle1XY.x,handle1XY.y);
			handleLine.graphics.moveTo(anchorXY.x,anchorXY.y);
			handleLine.graphics.lineTo(handle2XY.x,handle2XY.y);
			
			dispatchEvent(new Event("anchorMove"));
		}
		
		
		
		
	}
}