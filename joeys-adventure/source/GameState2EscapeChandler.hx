package;

import Main.Levels;
import escapeChandler.Chandler;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import gameStateClasses.Hud;
import gameStateClasses.Player;

class GameState2EscapeChandler extends FlxState
{
	// -----------------------------------
	//  -- Game Play
	public static var sceneTransitioning:Bool = false;

	private static final groundSpeed:Int = 32;
	public static final gravity:Float = 8;
	private static final groundHeight:Int = 24;

	public static final playerStartXPos:Int = 75;

	// Static
	public static var player:Player;
	public static var chandler:Chandler;

	// -----------------------------------
	private static var background:Background;

	public static var hud:Hud;

	override public function create()
	{
		Main.currentLevel = Levels.EscapeChandler;
		super.create();

		setupBackgroundCollisionGroups();

		background = new Background(groundHeight, groundSpeed);
		add(background);

		chandler = new Chandler(20, FlxG.height - groundHeight - 12);
		add(chandler);

		player = new Player(playerStartXPos, FlxG.height - groundHeight - 12);
		add(player);

		addBackgroundCollisionGroups();

		hud = new Hud(0, 0);
		add(hud);
	}

	private function setupBackgroundCollisionGroups()
	{
		Background.waterObjects = new FlxSpriteGroup();
	}

	private function addBackgroundCollisionGroups()
	{
		add(Background.waterObjects);
	}

	override public function update(elapsed:Float)
	{
		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(AssetPaths.music2_looped__ogg, 0.5, true);

		if (Main.paused)
		{
			pausedKeyboardListen();
			return;
		}

		if (Main.cutScene)
		{
			player.update(elapsed);
			keyboardListen();
			return;
		}

		super.update(elapsed);
		keyboardListen();
		collisions(elapsed);
	}

	private function collisions(elapsed:Float)
	{
		FlxG.overlap(player.player, Background.waterObjects, playerCollidesWater);
		FlxG.collide(player.player, Background.ground, playerCollidesGround);
		FlxG.overlap(Player.jumpWarning, Background.waterObjects, playerSeesWater);

		FlxG.collide(chandler.chandler, Background.ground, chandlerCollidesGround);
		FlxG.overlap(Chandler.jumpWarning, Background.waterObjects, chandlerSeesWater);
	}

	private function chandlerSeesWater(collisionSprite:FlxSprite, water:FlxSprite)
	{
		chandler.jump();
	}

	private function chandlerCollidesGround(chandlerSprite:FlxSprite, ground:FlxSprite)
	{
		chandler.collisionWithGround();
	}

	private function playerSeesWater(collisionSprite:FlxSprite, water:FlxSprite)
	{
		player.showJumpWarning();
	}

	private function playerCollidesGround(playerSprite:FlxSprite, ground:FlxSprite)
	{
		player.collisionWithGround();
	}

	private function playerCollidesWater(playerSprite:FlxSprite, water:FlxSprite)
	{
		player.collisionWithWater();
	}

	private function keyboardListen()
	{
		if (FlxG.keys.anyJustPressed([ESCAPE]))
		{
			Sys.exit(0);
		}
	}

	public static function respawnPlayer(_)
	{
		background.reset();
		player.levelReset();

		Main.cutScene = false;
		chandler.setPosition(20, FlxG.height - GameState2EscapeChandler.groundHeight - 12);
	}

	private function pausedKeyboardListen()
	{
		if (FlxG.keys.anyJustPressed([ESCAPE]) && !sceneTransitioning)
		{
			sceneTransitioning = true;
			FlxG.camera.fade(Colors.TanGray, 0.33, false, function()
			{
				FlxG.switchState(new MenuState());
			});
		}
	}

	public static function endGame()
	{
		if (sceneTransitioning)
			return;

		sceneTransitioning = true;
		FlxG.camera.fade(Colors.TanGray, 0.33, false, function()
		{
			FlxG.switchState(new MenuState());
		});
	}
}
