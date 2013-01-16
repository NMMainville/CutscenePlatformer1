package
{
	import org.flixel.*;
 
	public class Level extends FlxTilemap
	{	
		//------------------------------------------DECLARATIONS---------------------------------------------
		[Embed(source = "../data/map.txt", mimeType = "application/octet-stream")] private var TxtMap1:Class; //map layout 1
		[Embed(source = "../data/map2.txt", mimeType = "application/octet-stream")] private var TxtMap2:Class; //map layout 2
		[Embed(source = "../data/map3.txt", mimeType = "application/octet-stream")] private var TxtMap3:Class; //map layout 3
		[Embed(source = "../data/map4.txt", mimeType = "application/octet-stream")] private var TxtMap4:Class; //map layout 4
		[Embed(source = "../data/map5.txt", mimeType = "application/octet-stream")] private var TxtMap5:Class; //map layout 5
		[Embed(source = "../data/map6.txt", mimeType = "application/octet-stream")] private var TxtMap6:Class; //map layout 6
		[Embed(source = "../data/bg1.png")] private var BG1:Class; //map graphics 1
		
		private var parsedMap:Array;
		
		private const LVL1:String = new TxtMap1;
		private const LVL2:String = new TxtMap2;
		private const LVL3:String = new TxtMap3;
		private const LVL4:String = new TxtMap4;
		private const LVL5:String = new TxtMap5;
		private const LVL6:String = new TxtMap6;
		//TODO: implement a method for loading different types of tilemaps depending on the level
		//----------------------------------------CREATE FUNCTION--------------------------------------------
		public function Level(levelNumber:int):void //TODO: add in a property that denotes level number
		{
			collideIndex = 69;
			loadMap(LVL1, BG1, 16, 16);
		}
		
		public function newLevel(levelNumber:int, enterDirection:int):int //TODO: add in a property that denotes level number
		{
			collideIndex = 69;
			switch(levelNumber)
			{
				case 1:
					loadMap(LVL1, BG1, 16, 16);
					return(getStartCoords(parseMap(LVL1), enterDirection));
				break;
				
				case 2:
					loadMap(LVL2, BG1, 16, 16);
					return(getStartCoords(parseMap(LVL2), enterDirection));
				break;
				case 3:
					loadMap(LVL3, BG1, 16, 16);
					return(getStartCoords(parseMap(LVL3), enterDirection));
				break;
				case 4:
					loadMap(LVL4, BG1, 16, 16);
					return(getStartCoords(parseMap(LVL4), enterDirection));
				break;
				case 5:
					loadMap(LVL5, BG1, 16, 16);
					return(getStartCoords(parseMap(LVL5), enterDirection));
				break;
				case 6:
					loadMap(LVL6, BG1, 16, 16);
					return(getStartCoords(parseMap(LVL6), enterDirection));
				break;
			}
			return 0;
		}
		
		public function getStartCoords(parsedMap:Array, enterDirection:int):int
		{
			for (var a:int = 0; a < parsedMap.length; a++)
				{
					for (var b:int = 0; b < parsedMap[a].length; b++)
					{
						if (uint(parsedMap[a][b]) == 2 && enterDirection == 1)
						{
							return a*16;
						}
						else if (uint(parsedMap[a][b]) == 3 && enterDirection == 0)
						{
							return a*16;
						}
					}
				}
				return 0;
		}
		
		public function parseMap(tilemap:String):Array //this function takes a tilemap txt file and turns it into an array
		{								 //so that it can be used for other things (ie blocks)
			var tempArray:Array = new Array;
			var widthInTiles:int = 0;
			var heightInTiles:int = 0;
			var cols:Array;
			var rows:Array = tilemap.split("\n");
			heightInTiles = rows.length;
			for (var r:int = 0; r < heightInTiles; r++)
			{
				cols = rows[r].split(",");
				if(cols.length <= 1)
				{
					heightInTiles--;
					continue;
				}
				tempArray.push(new Array());
				if(widthInTiles == 0)
					widthInTiles = cols.length;
				for(var c:int = 0; c < widthInTiles; c++)
				{
					tempArray[r].push(uint(cols[c]));
				}
			}
			
			return tempArray;
		}
		
		/*override public function update():void //update function
		{
			super.update();
		}*/ //TODO: determine if the update function is really needed for the level class
	}
}