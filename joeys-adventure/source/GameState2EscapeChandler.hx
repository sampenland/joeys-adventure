package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.system.FlxSound;
import gameStateClasses.Background;
import gameStateClasses.Player;

class GameState2EscapeChandler extends FlxState
{
	// -----------------------------------
	//  -- Game Play
	public static var sceneTransitioning:Bool = false;

	private static final groundSpeed:Int = 24;
	public static final gravity:Float = 9.8;
	private static final groundHeight:Int = 24;

	// Sounds
	private static var frustration:FlxSound;

	// Static
	public static var player:Player;

	// -----------------------------------
	private static var background:Background;

	override public function create()
	{
		super.create();

		loadSounds();

		setupBackgroundCollisionGroups();

		background = new Background(groundHeight, groundSpeed);
		add(background);

		player = new Player(20, FlxG.height - GameState2EscapeChandler.groundHeight - 12);
		add(player);

		addBackgroundCollisionGroups();
	}

	private function loadSounds()
	{
		frustration = FlxG.sound.load(AssetPaths.frustration__ogg, 0.6, false);
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
		FlxG.overlap(player, Background.waterObjects, playerCollidesWater);
		FlxG.collide(player, Background.ground, playerCollidesGround);
	}

	private function playerCollidesGround(player:Player, ground:FlxSprite)
	{
		player.collisionWithGround();
	}

	private function playerCollidesWater(player:Player, water:FlxSprite)
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
		frustration.play();

		Main.cutScene = false;
		player.setPosition(20, FlxG.height - GameState2EscapeChandler.groundHeight - 12);
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
}
