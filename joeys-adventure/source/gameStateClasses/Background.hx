package gameStateClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxTimer;

class Background extends FlxTypedGroup<FlxSprite>
{
	private var backgroundColor:FlxSprite;

	private var ground:FlxSprite;
	private var detailCreator:FlxTimer;

	private var sun:FlxSprite;

	override public function new()
	{
		super();

		backgroundColor = new FlxSprite();
		backgroundColor.loadGraphic(AssetPaths.background__png, false, 320, 180);
		add(backgroundColor);

		detailCreator = new FlxTimer().start(1, createGroundDetail);

		ground = new FlxSprite(0, FlxG.height - GameState.groundHeight);
		ground.loadGraphic(AssetPaths.ground__png, false, 320, 2);
		add(ground);

		sun = new FlxSprite(FlxG.width / 2, 32);
		sun.loadGraphic(AssetPaths.sun__png, false, 48, 31);
		add(sun);
	}

	private function createGroundDetail(_)
	{
		trace("created");
		var detailType:Int = FlxG.random.int(1, 3);
		var detail = new FlxSprite(320, FlxG.height - GameState.groundHeight + 1);
		switch (detailType)
		{
			case 1:
				detail.loadGraphic(AssetPaths.ground_1__png, false, 5, 7);
			case 2:
				detail.loadGraphic(AssetPaths.ground_2__png, false, 3, 5);
			case 3:
				detail.loadGraphic(AssetPaths.ground_3__png, false, 1, 2);
		}

		detail.velocity.x = -GameState.groundSpeed;
		add(detail);

		detailCreator = new FlxTimer().start(FlxG.random.int(1, GameState.groundDetailSpread), createGroundDetail);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
