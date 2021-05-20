package escapeChandler;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import gameStateClasses.BirdController;

class Bird extends FlxSpriteGroup
{
	private final moveDelta:Int = 65;
	private final moveSpeedMax:Int = 5;
	private final alterCourseSpeedMin:Int = 2;
	private final alterCourseSpeedMax:Int = 4;

	private var attacking:Bool = false;
	private var dying:Bool = false;

	public var display:FlxSprite;
	public var collider:FlxSprite;

	private final colliderSize:Int = 100;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		BirdController.totalBirds++;

		display = new FlxSprite();

		display.loadGraphic(AssetPaths.bird__png, true, 8, 8);
		display.animation.add("fly", [0, 1, 2, 3, 4, 5], 12, true);
		display.animation.add("attack", [6, 7, 8, 9, 10, 11], 12, true);
		display.animation.add("die", [12, 13, 14, 15], 15, false);

		display.animation.play("fly");
		add(display);

		new FlxTimer().start(0.5, move);

		collider = new FlxSprite(-colliderSize / 2 + display.width, -colliderSize / 2 + display.height);
		collider.makeGraphic(colliderSize, colliderSize, Colors.TRANSPARENT);
		collider.debugBoundingBoxColor = Colors.DarkPurple;
		add(collider);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}

	private function move(_)
	{
		var currentX = Std.int(x);
		var currentY = Std.int(y);

		var newX:Float = currentX + FlxG.random.int(-moveDelta, moveDelta);
		var newY:Float = currentY + FlxG.random.int(-moveDelta, moveDelta);

		newX = FlxMath.bound(newX, 10, FlxG.width - 10);
		newY = FlxMath.bound(newY, 40, FlxG.height - GameState2EscapeChandler.groundHeight - display.height - 1);

		FlxTween.tween(this, {x: newX, y: newY}, FlxG.random.float(2, moveSpeedMax), {onComplete: finishedMove});
	}

	private function moveTowardsPlayer(_)
	{
		var currentX = Std.int(x);
		var currentY = Std.int(y);

		var newX:Float = 0;
		var newY:Float = 0;

		if (GameState2EscapeChandler.player.x < display.x)
		{
			newX = currentX - FlxG.random.float(moveDelta / 2, moveDelta);
		}
		else
		{
			newX = currentX + FlxG.random.float(moveDelta / 2, moveDelta);
		}

		if (GameState2EscapeChandler.player.y < display.y)
		{
			newY = currentY - FlxG.random.float(moveDelta / 2, moveDelta);
		}
		else
		{
			newY = currentY + FlxG.random.float(moveDelta / 2, moveDelta);
		}

		newX = FlxMath.bound(newX, 10, FlxG.width - 10);
		newY = FlxMath.bound(newY, 40, FlxG.height - GameState2EscapeChandler.groundHeight - display.height - 1);

		FlxTween.tween(this, {x: newX, y: newY}, FlxG.random.float(1, moveSpeedMax - 2), {onComplete: finishedMoveTowardsPlayer});
	}

	private function finishedMoveTowardsPlayer(_)
	{
		new FlxTimer().start(FlxG.random.int(alterCourseSpeedMin, alterCourseSpeedMax), moveTowardsPlayer);
	}

	private function finishedMove(_)
	{
		if (attacking)
		{
			new FlxTimer().start(FlxG.random.int(alterCourseSpeedMin, alterCourseSpeedMax), moveTowardsPlayer);
			return;
		}

		new FlxTimer().start(FlxG.random.int(alterCourseSpeedMin, alterCourseSpeedMax), move);
	}

	public function attack()
	{
		display.animation.play("attack");
		attacking = true;
	}

	public function die()
	{
		if (dying)
			return;

		dying = true;
		display.animation.play("die");
		display.animation.finishCallback = function(_)
		{
			BirdController.totalBirds--;
			kill();
		};
	}
}
