package gameStateClasses;

import escapeChandler.Bird;
import flixel.FlxG;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class BirdController extends FlxSpriteGroup
{
	public static var totalBirds:Int = 0;
	public static final maxBirds:Int = 3;
	public static var birds:FlxSpriteGroup;

	public static var createBirdTimerValue:Float = 8;

	override public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);

		new FlxTimer().start(FlxG.random.float(createBirdTimerValue - 2, createBirdTimerValue + 2), createBird);
	}

	public function createBird(_)
	{
		if (totalBirds >= maxBirds)
		{
			new FlxTimer().start(FlxG.random.float(createBirdTimerValue - 2, createBirdTimerValue + 2), createBird);
			return;
		}

		var x = FlxG.random.int(10, 310);
		var y = -16;

		var bird = new Bird(x, y);
		birds.add(bird);

		new FlxTimer().start(FlxG.random.float(createBirdTimerValue - 2, createBirdTimerValue + 2), createBird);
	}
}
