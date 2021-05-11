package gameStateClasses;

import flixel.FlxSprite;

class Player extends FlxSprite
{
	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadGraphic(AssetPaths.player__png, true, 16, 12);
		animation.add("run", [0, 1, 2, 3, 4], 14, true);
		animation.play("run");
	}
}
