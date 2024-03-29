package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;

class StartState extends FlxState
{
	public static var sceneTransitioning:Bool = false;

	var sound:FlxSprite;
	var noSound:FlxSprite;

	override public function create()
	{
		super.create();

		var backgroundColor = new FlxSprite();
		backgroundColor.loadGraphic(AssetPaths.background__png, false, 320, 180);
		add(backgroundColor);

		sound = new FlxSprite();
		sound.loadGraphic(AssetPaths.sound__png, false, 32, 32);
		sound.screenCenter();
		sound.x += 50;

		var sText = new FlxText(0, 0, 0, "Space", 14);
		sText.screenCenter();
		sText.x += 50;
		sText.y += 25;
		sText.setFormat(null, 14, Colors.DarkYellow);
		sText.alignment = CENTER;

		noSound = new FlxSprite();
		noSound.loadGraphic(AssetPaths.noSound__png, false, 32, 32);
		noSound.screenCenter();
		noSound.x -= 50;

		var nsText = new FlxText(0, 0, 0, "M", 14);
		nsText.screenCenter();
		nsText.x -= 50;
		nsText.y += 25;
		nsText.setFormat(null, 14, Colors.DarkYellow);
		nsText.alignment = CENTER;

		add(sound);
		add(noSound);

		add(nsText);
		add(sText);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		keyboardListen();
	}

	private function keyboardListen()
	{
		if (FlxG.keys.anyJustPressed([ESCAPE]))
		{
			Sys.exit(0);
		}

		if (FlxG.keys.anyJustPressed([SPACE]))
		{
			FlxG.sound.playMusic(AssetPaths.music1__ogg, 0.5, false);
			gotoMenu();
		}

		if (FlxG.keys.anyJustPressed([M]))
		{
			FlxG.sound.muted = true;
			gotoMenu();
		}
	}

	private function gotoMenu()
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
