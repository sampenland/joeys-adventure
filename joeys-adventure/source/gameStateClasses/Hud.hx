package gameStateClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;

class Hud extends FlxSpriteGroup
{
	private var hungerBar:FlxSprite;

	private var life1:FlxSprite;
	private var life2:FlxSprite;
	private var life3:FlxSprite;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		hungerBar = new FlxSprite();
		add(hungerBar);

		life1 = new FlxSprite(4, 8);
		life2 = new FlxSprite(4 + 6 + 4, 8);
		life3 = new FlxSprite(4 + 6 + 4 + 6 + 4, 8);

		life1.loadGraphic(AssetPaths.life__png, false, 6, 10);
		life2.loadGraphic(AssetPaths.life__png, false, 6, 10);
		life3.loadGraphic(AssetPaths.life__png, false, 6, 10);

		add(life1);
		add(life2);
		add(life3);

		updateValues(100, 3);
	}

	public function updateValues(hunger:Int, lives:Int)
	{
		if (hunger <= 0)
		{
			hungerBar.makeGraphic(FlxG.width, 6, Colors.TRANSPARENT);
		}
		else
		{
			hungerBar.makeGraphic(Std.int((hunger / 100) * FlxG.width), 6, Colors.LightGreen);
		}

		switch (lives)
		{
			case 1:
				life1.visible = true;
				life2.visible = false;
				life3.visible = false;

			case 2:
				life1.visible = true;
				life2.visible = true;
				life3.visible = false;

			case 3:
				life1.visible = true;
				life2.visible = true;
				life3.visible = true;
		}
	}
}
