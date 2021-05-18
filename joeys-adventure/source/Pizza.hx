package;

import flixel.FlxSprite;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Pizza extends FlxSprite
{
	public var pickedUp:Bool = false;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.pizza__png, false, 12, 12);
		velocity.y = -120;
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		velocity.y += GameState2EscapeChandler.gravity;
		velocity.x = -GameState2EscapeChandler.groundSpeed;
	}

	public function pickup()
	{
		if (pickedUp)
			return;

		pickedUp = true;

		velocity.y = -200;
		FlxTween.tween(this, {alpha: 0}, 0.75);

		new FlxTimer().start(0.75, function(_)
		{
			kill();
		});
	}
}
