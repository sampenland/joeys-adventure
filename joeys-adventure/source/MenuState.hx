package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxPoint;
import flixel.system.FlxSound;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class MenuState extends FlxState
{
	private var arrowPositions:Array<FlxPoint>;
	private var arrow:FlxSprite;
	private var arrowIdx:Int = 0;
	private var menuPadding:Int = 0;

	private static final groundSpeed:Int = 24;
	public static final gravity:Float = 9.8;
	private static final groundHeight:Int = 24;

	// friends
	private var monica:FlxSprite;
	private var rachel:FlxSprite;
	private var phoebe:FlxSprite;
	private var joey:FlxSprite;
	private var chandler:FlxSprite;
	private var ross:FlxSprite;

	private var selection:FlxSound;

	override public function create()
	{
		super.create();

		selection = FlxG.sound.load(AssetPaths.jump__ogg, 0.5, false);

		arrowPositions = new Array<FlxPoint>();

		Background.waterObjects = new FlxSpriteGroup();

		var background = new Background(groundHeight, groundSpeed, true);
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

		// Friends
		var danceSpeed:Int = 8;

		monica = new FlxSprite(30, FlxG.height - groundHeight - 12 + 1);
		monica.loadGraphic(AssetPaths.monicaDance__png, true, 8, 12);
		monica.animation.add("dance", [0, 1], danceSpeed, true);
		add(monica);

		var monicaLabel = new FlxSprite(monica.x - 10, monica.y - 12);
		monicaLabel.loadGraphic(AssetPaths.monicaLabel__png, false, 28, 12);
		monicaLabel.alpha = 0.5;
		add(monicaLabel);

		// rachel
		rachel = new FlxSprite(80, FlxG.height - groundHeight - 12 + 1);
		rachel.loadGraphic(AssetPaths.rachelDance__png, true, 8, 12);
		rachel.animation.add("dance", [0, 1], danceSpeed, true);
		add(rachel);

		var rachelLabel = new FlxSprite(rachel.x - 8, rachel.y - 12);
		rachelLabel.loadGraphic(AssetPaths.rachelLabel__png, false, 28, 12);
		rachelLabel.alpha = 0.5;
		add(rachelLabel);
		// ---------

		// phoebe
		phoebe = new FlxSprite(130, FlxG.height - groundHeight - 12 + 1);
		phoebe.loadGraphic(AssetPaths.phoebeDance__png, true, 10, 12);
		phoebe.animation.add("dance", [0, 1, 2, 3], danceSpeed, true);
		add(phoebe);

		var phoebeLabel = new FlxSprite(phoebe.x - 8, phoebe.y - 12);
		phoebeLabel.loadGraphic(AssetPaths.phoebeLabel__png, false, 32, 12);
		phoebeLabel.alpha = 0.5;
		add(phoebeLabel);
		// --------

		// ross
		ross = new FlxSprite(FlxG.width - 30, FlxG.height - groundHeight - 12 + 1);
		ross.loadGraphic(AssetPaths.rossDance__png, true, 8, 12);
		ross.animation.add("dance", [0, 1], danceSpeed, true);
		add(ross);

		var rossLabel = new FlxSprite(ross.x - 6, ross.y - 12);
		rossLabel.loadGraphic(AssetPaths.rossLabel__png, false, 32, 12);
		rossLabel.alpha = 0.5;
		add(rossLabel);
		// -------------

		// Chandler
		chandler = new FlxSprite(FlxG.width - 80, FlxG.height - groundHeight - 12 + 1);
		chandler.loadGraphic(AssetPaths.chandleDance__png, true, 8, 12);
		chandler.animation.add("dance", [0, 1], danceSpeed, true);
		add(chandler);

		var chandlerLabel = new FlxSprite(chandler.x - 12, chandler.y - 12);
		chandlerLabel.loadGraphic(AssetPaths.chandlerLabel__png, false, 32, 12);
		chandlerLabel.alpha = 0.5;
		add(chandlerLabel);
		// --------------

		// joey
		joey = new FlxSprite(FlxG.width - 130, FlxG.height - groundHeight - 12 + 1);
		joey.loadGraphic(AssetPaths.joeyDance__png, true, 8, 12);
		joey.animation.add("dance", [0, 1], danceSpeed, true);
		add(joey);

		var joeyLabel = new FlxSprite(joey.x - 6, joey.y - 11);
		joeyLabel.loadGraphic(AssetPaths.joeyLabel__png, false, 32, 12);
		joeyLabel.alpha = 0.5;
		add(joeyLabel);
		// -------------

		var title = new FlxText(0, 0, 0, "Joey's Adventure", 18);
		title.setFormat(null, 18, Colors.DarkRed);
		title.screenCenter();
		title.y = 10;
		add(title);

		new FlxTimer().start(2.5, startDancing);
	}

	private function startDancing(_)
	{
		monica.animation.play("dance");
		ross.animation.play("dance");
		rachel.animation.play("dance");
		chandler.animation.play("dance");
		joey.animation.play("dance");
		phoebe.animation.play("dance");
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.sound.music != null && !FlxG.sound.music.playing)
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
			selection.play(true);

			arrowIdx--;

			if (arrowIdx < 0)
				arrowIdx = arrowPositions.length - 1;

			arrow.x = arrowPositions[arrowIdx].x;
			arrow.y = arrowPositions[arrowIdx].y;
		}

		if (FlxG.keys.anyJustPressed([S, DOWN]))
		{
			selection.play(true);

			arrowIdx++;

			if (arrowIdx > arrowPositions.length - 1)
				arrowIdx = 0;

			arrow.x = arrowPositions[arrowIdx].x;
			arrow.y = arrowPositions[arrowIdx].y;
		}
	}
}
