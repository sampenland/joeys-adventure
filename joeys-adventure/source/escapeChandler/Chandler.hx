package escapeChandler;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Chandler extends FlxSpriteGroup
{
	private var chandler:FlxSprite;
	private var label:FlxSprite;

	override public function new(xR:Float, yR:Float)
	{
		super();

		x = xR;
		y = yR;

		chandler = new FlxSprite();
		chandler.loadGraphic(AssetPaths.chandler__png, true, 16, 12);
		chandler.animation.add("forward", [0, 1, 2, 3, 4], 14, true);
		chandler.animation.add("back", [5, 6, 7, 8, 9], 14, true);
		chandler.animation.play("forward");
		add(chandler);

		label = new FlxSprite(-8, -12);
		label.alpha = 0.5;
		label.loadGraphic(AssetPaths.chandlerLabel__png, false, 32, 12);
		add(label);
	}
}
