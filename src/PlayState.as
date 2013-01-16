package
{
	import org.flixel.*;
 
	public class PlayState extends FlxState
	{	
		//---------------------------------------CURRENT OBJECTIVES------------------------------------------
		//------------------------------------------DECLARATIONS---------------------------------------------
		public var level:Level; //level oblect
		public var player:Player; //player object extended from player class
		public var helicopter:Helicopter; //helicopter object
		public var levelNumber:int = 1; //what level to load
		public var words:Text; //displays text
		public var runOnce:int = 0;
		[Embed(source= "../data/choppertheme.mp3")] private var bossMusic:Class; //jump sound
		//----------------------------------------CREATE FUNCTION--------------------------------------------
		override public function create():void
		{
			bgColor = 0xffccccff; //change bgcolour
			
			level = new Level(levelNumber); //initiate level as a Level (the class)
			
			player = new Player(5*16-8, level.height-11*16 + 3);//initiate player as a Player (the class)
			
			helicopter = new Helicopter(player.x - 8*16, player.y - 8*16)
			
			words = new Text(1*16, 12*16);
			words.scrollFactor = new FlxPoint(0, 0);
			words.actualWords.scrollFactor = new FlxPoint(0, 0);
			
			add(helicopter);
			add(level); //adds the tilemap
			add(player.particles);
			add(player); //adds the player
			
			add(words);
			add(words.convoBox);
			add(words.actualWords);
			
			helicopter.revealPlayer(player.x - 3 * 16, player.y - 3 * 16);
			helicopter.alpha = 0;
			
			//set up camera
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
			level.follow();	//Set the followBounds to the map dimensions
		}
		
		override public function update():void //update function
		{
			super.update();
			
			if (player.x > level.width) //code to change level
			{
				nextLevel();
			}
			if (player.x < -16)
			{
				prevLevel();
			}
			
			if (player.x > level.width/2 && runOnce == 0 && levelNumber == 2) //rough code to initiate conversations
			{
				runOnce = 1;
				words.displayLines(1);
			}
			if (player.x > level.width/2 && runOnce == 1 && levelNumber == 6)
			{
				runOnce = 2;
				words.displayLines(3);
				helicopter.x = 0;
				helicopter.y = 0;
				helicopter.alpha = 1;
				helicopter.acceleration.y = 0;
			}
			if (runOnce == 2 && words.convoBox.alpha == 0)
			{
				runOnce = 3;
				words.displayLines(4);
				FlxG.playMusic(bossMusic);
				player.facingBack = true;
			}
			if (runOnce == 3 && words.convoBox.alpha == 0)
			{
				runOnce = 4;
				words.displayLines(5);
			}
			if (runOnce == 4 && words.convoBox.alpha == 0)
			{
				runOnce = 5;
				words.displayLines(6);
			}
			if (runOnce == 5 && words.convoBox.alpha == 0)
			{
				runOnce = 6;
				FlxG.music.fadeOut(2);
				FlxG.fade.start(0xff000000, 2, onFade, false);
			}
			
			helicopter.revealPlayer(player.x - 14 * 16, player.y - 8 * 16);
			
			FlxU.collide(level, player);
			
			//if (FlxG.keys.justPressed("B")) FlxG.showBounds = !FlxG.showBounds; //bounding box debug
		}
		
		public function nextLevel():void
		{			
			levelNumber++;
			//FlxG.log("Level "+levelNumber);
			
			player.y = level.newLevel(levelNumber, 1) + 2;
			
			player.x = 0;
			//player.y = player.y - 1;
			
			level.follow();	//Set the followBounds to the map dimensions
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5, 0.0);
		}
		public function prevLevel():void
		{
			levelNumber--;
			//FlxG.log("Level "+levelNumber);
			player.y = level.newLevel(levelNumber, 0) + 2;
			
			player.x = level.width - 20;
			//player.y = player.y - 1;
			
			level.follow();	//Set the followBounds to the map dimensions
			FlxG.follow(player,2.5);
			FlxG.followAdjust(0.5,0.0);
		}
			private function onFade():void
		{
			FlxG.state = new MenuState();
		}
	}
}