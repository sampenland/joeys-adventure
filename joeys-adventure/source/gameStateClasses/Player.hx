package gameStateClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;

class Player extends FlxSprite
{
	private final moveSpeed:Int = 2500;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.player__png, true, 16, 12);
		animation.add("idle", [0, 1, 2, 3, 4], 12, true);
		animation.add("right", [0, 1, 2, 3, 4], 18, true);
		animation.add("left", [5, 6, 7, 8, 9], 14, true);
		animation.play("idle");
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		keyboardControls(elapsed);
		bounds();
	}

	private function bounds()
	{
		x = FlxMath.bound(x, 0, FlxG.width - width);
		y = FlxMath.bound(y, 0, FlxG.height - GameState.groundHeight - height);
	}

	private function keyboardControls(elapsed:Float)
	{
		var up = FlxG.keys.anyPressed([W, UP]);
		var down = FlxG.keys.anyPressed([S, DOWN]);
		var right = FlxG.keys.anyPressed([D, RIGHT]);
		var left = FlxG.keys.anyPressed([A, LEFT]);

		velocity.x = 0;

		if (right)
		{
			animation.play("right");
			velocity.x = moveSpeed * elapsed;
		}
		else if (left)
		{
			animation.play("left");
			velocity.x = -moveSpeed * elapsed;
		}
		else
		{
			animation.play("idle");
		}
	}
}
