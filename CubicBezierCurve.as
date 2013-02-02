package {
//	import flash.display.Shape;
	import fl.motion.BezierSegment;
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	import net.interush.print.editNode;

	public class CubicBezierCurve extends Sprite
	{
//		private var line:Sprite;
//		private var bezierLine:CubicBezier;
//		private var pencilPoint:PencilPoint;
//		private var button:Sprite;
		
		private var line:Shape;
		private var segments:Number = 100;
		private var color:uint 		= 0x000000; 
		private var thikness:Number = 1;
		
		public var nodes:Vector.<editNode>;
		public var nodes2:Vector.<editNode>;
		public function CubicBezierCurve()
		{
			line = new Shape();
			
			addChild(line);
			nodes = new <editNode>[];
			nodes2 = new <editNode>[];
			
			var p:Array = [223,109,114,219,4,109,114,0,223,109];
			var c:Array = [223,169, 54,219,4, 49,174,0];
			var p2:Array = [122,61,63,119,122,178,180,119,122,61];
			var c2:Array = [90,61,63,151,154,178,180,87];

			for(var i:int=0 ; i<p.length ; i += 2)
			{
				addEditNode(p[i],p[i+1],c[i],c[i+1]);
			}
			for(var j:int=0 ; j<p2.length ; j += 2)
			{
				addEditNode2(p2[j],p2[j+1],c2[j],c2[j+1]);
			}
			
		}
		
		private function anchorMove(e:Event)
		{
			drawLine();
			drawLine2();
		}
		/**
		 * Add a new editNode
		 */
		private function addEditNode(ax:Number,ay:Number,cx:Number,cy:Number):void
		{
			var en:editNode = new editNode(ax,ay,cx,cy);
				en.addEventListener('anchorMove', anchorMove);
				
			if(nodes.length > 0 && nodes[0].anchorXY.x == ax && nodes[0].anchorXY.y == ay) return;

			nodes.push(en);
			addChild(en);
			
			drawLine();
		}
		
		private function addEditNode2(ax:Number,ay:Number,cx:Number,cy:Number):void
		{
			var en:editNode = new editNode(ax,ay,cx,cy);
			en.addEventListener('anchorMove', anchorMove);
			
			if(nodes2.length > 0 && nodes2[0].anchorXY.x == ax && nodes2[0].anchorXY.y == ay) return;
			
			nodes2.push(en);
			addChild(en);
			
			drawLine2();
		}
	
		/**
		 * Draw a bezierCurved line
		 */
		private function drawLine():void
		{
			var step:Number = 1/segments;
			
			line.graphics.clear();
			line.graphics.beginFill(0xFF0000,1);
			line.graphics.lineStyle(thikness,color);
			
			var count:int = 0;
			var anchor1:Point;
			var anchor2:Point;
			var control1:Point;
			var control2:Point;
			
			line.graphics.moveTo(nodes[0].anchorXY.x,nodes[0].anchorXY.y);
			for each(var n:editNode in nodes) 
			{
				if(count < nodes.length)
				{
					anchor1 = n.anchorXY;
					control1 = n.handle1XY;
					
					if(count == nodes.length-1)
					{
						anchor2 = nodes[0].anchorXY;
						control2 = nodes[0].handle2XY;
					}
					else
					{
						anchor2 = nodes[count+1].anchorXY;
						control2 = nodes[count+1].handle2XY;
					}
					drawCurve(anchor1,control1,control2,anchor2);

					count++;
				}
			}
			//line.graphics.endFill();
		}
		
		private function drawLine2():void
		{
			var step:Number = 1/segments;
			
//			line.graphics.clear();
//			line.graphics.beginFill(0xFF0000,1);
//			line.graphics.lineStyle(thikness,color);
			
			var count:int = 0;
			var anchor1:Point;
			var anchor2:Point;
			var control1:Point;
			var control2:Point;
			
			line.graphics.moveTo(nodes2[0].anchorXY.x,nodes2[0].anchorXY.y);
			for each(var n:editNode in nodes2) 
			{
				if(count < nodes2.length)
				{
					anchor1 = n.anchorXY;
					control1 = n.handle1XY;
					
					if(count == nodes2.length-1)
					{
						anchor2 = nodes2[0].anchorXY;
						control2 = nodes2[0].handle2XY;
					}
					else
					{
						anchor2 = nodes2[count+1].anchorXY;
						control2 = nodes2[count+1].handle2XY;
					}
					drawCurve(anchor1,control1,control2,anchor2);
					
					count++;
				}
			}
			line.graphics.endFill();
		}
		
	
		
		public function drawCurve(p1:Point, p2:Point, p3:Point, p4:Point):void
		{
			var bezier = new BezierSegment(p1,p2,p3,p4);	
//			line.graphics.lineTo(p1.x,p1.y);

			// Construct the curve out of 100 segments (adjust number for less/more detail)
			for (var t=.01;t<1.01;t+=.01){
				var val = bezier.getValue(t);	// x,y on the curve for a given t
				line.graphics.lineTo(val.x,val.y);
			}
			
		}

		
	}
}