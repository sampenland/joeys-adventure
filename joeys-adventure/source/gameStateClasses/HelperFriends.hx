package gameStateClasses;

import flixel.FlxG;
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
	private var pizzasThrown:Int = 0;
	private var rachel:FlxSprite;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		canSpawnMonica = true;
		canSpawnRachel = true;
		canSpawnPhoebe = true;

		spawnMountain = new FlxSprite();
		spawnMountain.loadGraphic(AssetPaths.spawnMountain__png, false, 91, 19);
		spawnMountain.visible = false;
		add(spawnMountain);

		monica = new FlxSprite(340, spawnMountain.y);
		monica.loadGraphic(AssetPaths.monica__png, true, 16, 12);
		monica.animation.add("walk", [0, 1, 2, 3, 4], 12, true);
		monica.animation.add("throwFood", [5, 6, 7, 8, 9, 10, 11, 12], 12, true);
		add(monica);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (monica.x < 0)
		{
			monica.x = 340;
			monica.visible = false;
			monica.velocity.x = 0;
		}

		if (spawnMountain.x < 0)
		{
			spawnMountain.x = 340;
			spawnMountain.visible = false;
			spawnMountain.velocity.x = 0;
		}
	}

	public function trySpawnMonica(rossFight:Bool)
	{
		if (!canSpawnMonica)
			return;

		canSpawnMonica = false;

		spawnMountain.x = 320;
		spawnMountain.y = FlxG.height - GameState2EscapeChandler.groundHeight - spawnMountain.height;
		spawnMountain.visible = true;
		spawnMountain.velocity.x = -GameState2EscapeChandler.groundSpeed * 0.6;

		if (!rossFight)
		{
			new FlxTimer().start(1, spawnMonica);
		}
		else
		{
			spawnMonicaRossFight();
		}
	}

	private function spawnMonica(_)
	{
		monica.setPosition(340, spawnMountain.y - monica.height);
		monica.flipX = true;
		monica.velocity.x = -GameState2EscapeChandler.groundSpeed * 0.75;
		monica.animation.play("walk");
		monica.visible = true;

		new FlxTimer().start(3.5, stopMonica);
	}

	private function stopMonica(_)
	{
		monica.velocity.x = -GameState2EscapeChandler.groundSpeed * 0.6;
		monica.flipX = false;
		monica.animation.play("throwFood");

		pizzasThrown = 0;
		new FlxTimer().start(1, throwPizza);
	}

	private function throwPizza(_)
	{
		if (pizzasThrown > 9)
			return;

		pizzasThrown++;
		new FlxTimer().start(FlxG.random.float(1, 3), GameState2EscapeChandler.createPizza.bind(monica.x, monica.y - 2));
		new FlxTimer().start(FlxG.random.float(1, 4), throwPizza);
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

	private function hideMonica(_) {}

	private function spawnMonicaRossFight() {}

	private function hideMonicaRossFight(_) {}

	private function spawnRachel() {}

	private function hideRachel(_) {}
}
