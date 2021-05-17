package gameStateClasses;

import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;

class HelperFriends extends FlxSpriteGroup
{
	public static var canSpawnMonica:Bool = true;
	public static var canSpawnRachel:Bool = true;
	public static var canSpawnPhoebe:Bool = true;

	private var spawnMountain:FlxSprite;
	private var monica:FlxSprite;
	private var rachel:FlxSprite;

	override public function new(x:Float, y:Float)
	{
		super(x, y);
		canSpawnMonica = true;
		canSpawnRachel = true;
		canSpawnPhoebe = true;
	}

	public function spawnMonicaForNSeconds(seconds:Int, rossFight:Bool)
	{
		if (!canSpawnMonica)
			return;

		canSpawnMonica = false;

		if (!rossFight)
		{
			spawnMonica();
			new FlxTimer().start(seconds, hideMonica);
		}
		else
		{
			spawnMonicaRossFight();
			new FlxTimer().start(seconds, hideMonicaRossFight);
		}
	}

	public function spawnRachelForNSeconds(seconds:Int)
	{
		if (!canSpawnRachel)
			return;

		canSpawnRachel = false;
		spawnRachel();
		new FlxTimer().start(seconds, hideRachel);
	}

	public function spawnPhoebe()
	{
		if (!canSpawnPhoebe)
			return;

		canSpawnPhoebe = false;

		showPhoebe();
	}

	private function showPhoebe() {}

	private function hidePhoebe() {}

	private function spawnMonica() {}

	private function hideMonica(_) {}

	private function spawnMonicaRossFight() {}

	private function hideMonicaRossFight(_) {}

	private function spawnRachel() {}

	private function hideRachel(_) {}
}
