package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;

class MenuState extends FlxState
{
	private var arrowPositions:Array<FlxPoint>;
	private var arrow:FlxSprite;
	private var arrowIdx:Int = 0;
	private var menuPadding:Int = 20;

	private static final groundSpeed:Int = 24;
	public static final gravity:Float = 9.8;
	private static final groundHeight:Int = 24;

	override public function create()
	{
		super.create();

		arrowPositions = new Array<FlxPoint>();

		Background.waterObjects = new FlxSpriteGroup();

		var background = new Background(groundHeight, groundSpeed);
		add(background);

		add(Background.waterObjects);

		var ngText = new FlxText(0, 0, 0, "New Game", 14);
		ngText.screenCenter();
		ngText.y -= 25 - menuPadding;
		ngText.setFormat(null, 14, Colors.DarkYellow);
		ngText.alignment = CENTER;
		arrowPositions.push(new FlxPoint(ngText.x - 20, ngText.y));
		add(ngText);

		var lgText = new FlxText(0, 0, 0, "Load Game", 14);
		lgText.screenCenter();
		lgText.y += menuPadding;
		lgText.setFormat(null, 14, Colors.DarkYellow);
		lgText.alignment = CENTER;
		arrowPositions.push(new FlxPoint(lgText.x - 20, lgText.y));
		add(lgText);

		var qgText = new FlxText(0, 0, 0, "Quit", 14);
		qgText.screenCenter();
		qgText.y += menuPadding + 25;
		qgText.setFormat(null, 14, Colors.DarkYellow);
		qgText.alignment = CENTER;
		arrowPositions.push(new FlxPoint(qgText.x - 20, qgText.y));
		add(qgText);

		arrow = new FlxSprite();
		arrow.loadGraphic(AssetPaths.arrow__png, false, 18, 18);
		arrow.screenCenter();
		arrow.x = arrowPositions[arrowIdx].x;
		arrow.y = arrowPositions[arrowIdx].y;
		add(arrow);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(AssetPaths.music2_looped__ogg, 0.8, true);

		keyboardListen();
	}

	private function newGame()
	{
		FlxG.camera.fade(Colors.TanGray, 0.33, false, function()
		{
			FlxG.switchState(new StoryState());
		});
	}

	private function loadGame() {}

	private function keyboardListen()
	{
		if (FlxG.keys.anyJustPressed([ESCAPE]))
		{
			Sys.exit(0);
		}

		if (FlxG.keys.anyJustPressed([SPACE, ENTER]))
		{
			switch (arrowIdx)
			{
				case 0:
					newGame();
				case 1:
					loadGame();
				default:
					Sys.exit(0);
			}
		}

		if (FlxG.keys.anyJustPressed([W, UP]))
		{
			arrowIdx--;

			if (arrowIdx < 0)
				arrowIdx = arrowPositions.length - 1;

			arrow.x = arrowPositions[arrowIdx].x;
			arrow.y = arrowPositions[arrowIdx].y;
		}

		if (FlxG.keys.anyJustPressed([S, DOWN]))
		{
			arrowIdx++;

			if (arrowIdx > arrowPositions.length - 1)
				arrowIdx = 0;

			arrow.x = arrowPositions[arrowIdx].x;
			arrow.y = arrowPositions[arrowIdx].y;
		}
	}
}
