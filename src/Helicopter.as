package
{
	import org.flixel.*;
 
	public class Helicopter extends FlxSprite
	{	
		//------------------------------------------DECLARATIONS---------------------------------------------
		[Embed(source = "../data/chopper.png")] public var chopperSprites:Class; //Credit to Fuade for the sprite!
		[Embed(source= "../data/chopper1.mp3")] private var chopperSound:Class; //chopper sound
		public var playerX:int = 5;
		public var playerY:int = 5;
		private var soundTimer:int = 6;

		//----------------------------------------CREATE FUNCTION--------------------------------------------
		public function Helicopter(X: int, Y: int):void
		{
			super(X, Y);
			
			//Create helicopter
			loadGraphic(chopperSprites, true, true, 180, 146);
			
			//Adjust size
			//offset.x = 11;
			//offset.y = 7;
			//width = 20;
			//height = 45;
			
			maxVelocity.x = 260; //maximum speed in the x direction
			maxVelocity.y = 60; //maximum speed in the y direction
			drag.x = maxVelocity.x * 4; //slows the player down when they're not moving left or right
			drag.y = maxVelocity.y * 4; //slows the player down when they're not moving left or right
			
			//Animations
			addAnimation("idle", [0, 1], 24);
		}
		
		override public function update():void //update function
		{
			//------------------------------------------ANIMATIONS-----------------------------------------------
			play("idle");
			//-------------------------------------------MOVEMENT------------------------------------------------
			if (x < playerX)
			{
				velocity.x = playerX - x;
			}
			else
			{
				velocity.x = playerX - x;
			}
			
			if (y < playerY)
			{
				acceleration.y  = 50;
			}
			else
			{
				acceleration.y = -50;
			}
			
			angle = velocity.x / 25;
			
			if (alpha == 1)
			{
				soundTimer--
				if (soundTimer < 0)
				{
				soundTimer = 6;
				if (x <= playerX)
				{
					FlxG.play(chopperSound, x / playerX, false);
				}
				else
				{
					FlxG.play(chopperSound, 1, false);
				}
				}
			}
			
			super.update();
		}
		
		public function revealPlayer(X:int, Y:int):void
		{
			playerX = X;
			playerY = Y;
		}
	}
}