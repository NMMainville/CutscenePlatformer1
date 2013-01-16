package
{
	import org.flixel.*;
 
	public class Particle extends FlxSprite
	{	
		//------------------------------------------DECLARATIONS---------------------------------------------
		[Embed(source = "../data/particles.png")] public var particleSprites:Class; //particle sprites
		//----------------------------------------CREATE FUNCTION--------------------------------------------
		public function Particle(X: int, Y: int):void //X and Y define spawnpoint of the particle
		{
			super(X, Y); //x and y position of the particle
			//Create particle
			loadGraphic(particleSprites, false, true, 8);
			
			//Adjust size
			//offset.x = 0;
			//offset.y = 0;
			//width = 8;
			//height = 8;
			
			maxVelocity.x = 120; //maximum speed in the x direction
			maxVelocity.y = 260; //maximum speed in the y direction
			acceleration.y = 100; //particle gravity
			drag.x = maxVelocity.x * 4; //slows the particle down when it isn't affected by a force
			drag.y = 20;
			
			velocity.y = -50;
			exists = false;
			//exists = false;
			//Animations
			//addAnimation("nothing", [0]);
			//addAnimation("smoke", [1]);
		}
		
		override public function update():void //update function
		{
			//------------------------------------------ANIMATIONS-----------------------------------------------
			//play("smoke");
			//-------------------------------------------MOVEMENT------------------------------------------------
			if (velocity.y > 0)
			{
				exists = false;
				velocity.y = -50;
				alpha = 1;
			}
			alpha = Math.abs(velocity.y / 50);
			super.update();
		}
	}
}