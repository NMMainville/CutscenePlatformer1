package
{
	import org.flixel.*;
 
	public class Player extends FlxSprite
	{	
		//------------------------------------------DECLARATIONS---------------------------------------------
		[Embed(source = "../data/player.png")] public var playerSprites:Class; //player sprites
		[Embed(source= "../data/jump1.mp3")] private var jumpSound:Class; //jump sound
		[Embed(source= "../data/walk1.mp3")] private var walkSound:Class; //walk sound
		//[Embed(source = "../data/particles.png")] public var particleSprites:Class; //particle sprites
		private const ACCEL:int = 5; //Slick's X acceleration
		
		//public var smokeEmitter:FlxEmitter; //Particle emitter
		public var particleChoke:Boolean = false; //smokeEmitter choke variable, prevents repetition
		public var particles:FlxGroup; //Holds particles for the player
		private var particleScroll:int = 0; //Determines which particle to use
		private var particleTimer:int = 12;
		private var zHeld:Boolean = false;
		public var facingBack:Boolean = false;

		//----------------------------------------CREATE FUNCTION--------------------------------------------
		public function Player(X: int, Y: int):void //X and Y define starting position of the player
		{
			super(X, Y); //x and y position of the player
			//Create player
			loadGraphic(playerSprites, false, true, 42);
			
			//smokeEmitter = new FlxEmitter(x, y);
			//smokeEmitter.setSize(1,1);
			//smokeEmitter.setYSpeed(-75, -100);
			//smokeEmitter.setXSpeed(-2, 2);
			//smokeEmitter.setRotation(-720,720);
			//smokeEmitter.gravity = 300; //Shouldn't need these if we're using the particle class
			//smokeEmitter.createSprites(particleSprites, 100, 32);
			
			particles = new FlxGroup;
			for (var i:int=0; i<25;i++){ 
				particles.add(new Particle(x, y));
			}
			
			//Adjust size
			offset.x = 11;
			offset.y = 7;
			width = 20;
			height = 45;
			
			origin.x = 10;
			origin.y = 45;
			
			maxVelocity.x = 120; //maximum speed in the x direction
			maxVelocity.y = 260; //maximum speed in the y direction
			acceleration.y = 500; //player gravity
			drag.x = maxVelocity.x * 4; //slows the player down when they're not moving left or right
			
			//Animations
			addAnimation("idle", [0]);
			addAnimation("walking", [1, 2, 3, 2], 12);
			addAnimation("jump", [1]);
			addAnimation("idleback", [4]);
			addAnimation("walkingback", [5, 6, 7, 6], 12);
			addAnimation("jumpback", [5]);
			play("idle");
		}
		
		override public function update():void //update function
		{
			//------------------------------------------ANIMATIONS-----------------------------------------------
			if (!facingBack)
			{
			if (velocity.x != 0 && velocity.y == 0 && onFloor)
				play("walking");
				else if (!onFloor)
				play("jump");
				else
				play("idle");
			}
			else
			{
			if (velocity.x != 0 && velocity.y == 0 && onFloor)
				play("walkingback");
				else if (!onFloor)
				play("jumpback");
				else
				play("idleback");
			}
			//-------------------------------------------MOVEMENT------------------------------------------------
			acceleration.x = 0; //set acceleration to 0, update it throughout the update function accordingly
			if (FlxG.keys.LEFT){
				acceleration.x = -maxVelocity.x * ACCEL;
				facing = LEFT;
			}
			if(FlxG.keys.RIGHT){
				acceleration.x = maxVelocity.x * ACCEL;
				facing = RIGHT;
			}
			if (FlxG.keys.Z && onFloor && !zHeld)
			{
				velocity.y = -maxVelocity.y / 1;
				FlxG.play(jumpSound, 1, false);
				zHeld = true;
			}
			if (!FlxG.keys.Z && zHeld)
				zHeld = false;
				
			//---------------------------------------PARTICLE TESTING--------------------------------------------
			if (Math.abs(velocity.x) > 100 && onFloor)
			{
				particleTimer--
				if (particleTimer < 0)
				{
				particles.members[particleScroll].reset(x+5, y+38);
				//particles.members[particleScroll].velocity.y = -200;
				particleScroll++;
				particleTimer = 12;
				FlxG.play(walkSound, 1, false);
				}
			}
			
			if (particleScroll > 24)
				particleScroll = 0;
			
			super.update();
		}
	}
}