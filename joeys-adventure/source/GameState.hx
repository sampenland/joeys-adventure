package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import gameStateClasses.Background;
import gameStateClasses.Player;

class GameState extends FlxState
{
	// -----------------------------------
	//  -- Game Play
	public static var paused:Bool = false;
	public static var cutScene:Bool = false;
	public static var sceneTransitioning:Bool = false;

	public static final groundSpeed:Int = 24;
	public static final gravity:Float = 9.8;
	public static final groundDetailSpread:Int = 7;
	public static final bkgMountainSpread:Int = 34;
	public static final mountainSpread:Int = 20;
	public static final waterSpread:Int = 21;
	public static final groundHeight:Int = 24;

	// Static
	public static var player:Player;

	// -----------------------------------
	private static var background:Background;

	override public function create()
	{
		super.create();

		setupBackgroundCollisionGroups();

		background = new Background();
		add(background);

		player = new Player(20, FlxG.height - GameState.groundHeight - 12);
		add(player);

		addBackgroundCollisionGroups();
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

		if (paused)
		{
			pausedKeyboardListen();
			return;
		}

		if (cutScene)
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

		cutScene = false;
		player.setPosition(20, FlxG.height - GameState.groundHeight - 12);
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
