package gameStateClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;

class Background extends FlxTypedGroup<FlxSprite>
{
	private var backgroundColor:FlxSprite;

	override public function new()
	{
		super();

		backgroundColor = new FlxSprite();
		backgroundColor.makeGraphic(FlxG.width, FlxG.height, Colors.LightestTan);
		add(backgroundColor);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
