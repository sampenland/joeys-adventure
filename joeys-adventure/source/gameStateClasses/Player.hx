package gameStateClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxMath;
import flixel.util.FlxTimer;

class Player extends FlxSprite
{
	private final moveSpeed:Int = 2500;
	private final jumpForce:Int = 150;
	private var canJump:Bool = true;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.player__png, true, 16, 12);
		animation.add("idle", [0, 1, 2, 3, 4], 12, true);
		animation.add("right", [0, 1, 2, 3, 4], 18, true);
		animation.add("left", [5, 6, 7, 8, 9], 14, true);
		animation.add("waterDie", [10, 11, 12], 6, false);
		animation.play("idle");
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		keyboardControls(elapsed);
		applyGravity(elapsed);
		bounds();
	}

	private function applyGravity(elapsed:Float)
	{
		if (GameState.cutScene)
			return;

		velocity.y += GameState.gravity;
	}

	private function bounds()
	{
		x = FlxMath.bound(x, 0, FlxG.width - width);
		y = FlxMath.bound(y, 0, FlxG.height - height);
	}

	private function keyboardControls(elapsed:Float)
	{
		if (GameState.cutScene)
			return;

		var jump = FlxG.keys.anyJustPressed([W, UP, SPACE]);
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
		if (jump && canJump)
		{
			velocity.y = -jumpForce;
			new FlxTimer().start(0.1, function(_)
			{
				canJump = false;
			});
		}
	}

	public function collisionWithWater()
	{
		animation.play("waterDie");
		animation.finishCallback = GameState.respawnPlayer;
		GameState.cutScene = true;
	}

	public function collisionWithGround()
	{
		canJump = true;
	}
}
