package escapeChandler;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Bird extends FlxSprite
{
	private final moveDelta:Int = 35;
	private final moveSpeed:Int = 3;
	private final alterCourseSpeedMin:Int = 4;
	private final alterCourseSpeedMax:Int = 8;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.bird__png, true, 8, 8);
		animation.add("fly", [0, 1, 2, 3, 4, 5], 12, true);
		animation.add("attack", [6, 7, 8, 9, 10, 11], 12, true);
		animation.add("die", [12, 13, 14, 15], 8, false);

		animation.play("fly");

		new FlxTimer().start(0.5, move);
	}

	private function move(_)
	{
		var currentX = Std.int(x);
		var currentY = Std.int(y);

		var newX:Float = FlxG.random.int(currentX, FlxG.random.int(-moveDelta, moveDelta));
		var newY:Float = FlxG.random.int(currentY, FlxG.random.int(-moveDelta, moveDelta));

		newX = FlxMath.bound(newX, 10, FlxG.width - 10);
		newY = FlxMath.bound(newY, 10, FlxG.height - GameState2EscapeChandler.groundHeight - 1);

		FlxTween.tween(this, {x: newX, y: newY}, moveSpeed, {onComplete: finishedMove});
	}

	private function finishedMove(_)
	{
		new FlxTimer().start(FlxG.random.int(alterCourseSpeedMin, alterCourseSpeedMax), move);
	}
}
