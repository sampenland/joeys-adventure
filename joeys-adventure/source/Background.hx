package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;

class Background extends FlxTypedGroup<FlxSprite>
{
	private var backgroundColor:FlxSprite;
	private var groundHeight:Int;
	private var groundSpeed:Float;

	public static var ground:FlxSprite;

	private var detailCreator:FlxTimer;

	private var sun:FlxSprite;

	private var createdWater:Bool = false;
	private var createWaterTimer:FlxTimer;

	private var bkgMountainTimer:FlxTimer;
	private var mountainTimer:FlxTimer;

	private var bkgMountains:FlxSpriteGroup;
	private var mountains:FlxSpriteGroup;
	private var windGusts:FlxSpriteGroup;

	// Static objects
	public static var waterObjects:FlxSpriteGroup;
	public static var details:FlxSpriteGroup;

	override public function new(groundHeightR:Int, groundSpeedR:Float, ?staticBackground:Bool)
	{
		super();

		groundHeight = groundHeightR;
		groundSpeed = groundSpeedR;

		backgroundColor = new FlxSprite();
		backgroundColor.loadGraphic(AssetPaths.background__png, false, 320, 180);
		add(backgroundColor);

		windGusts = new FlxSpriteGroup();
		add(windGusts);

		sun = new FlxSprite(FlxG.width / 2 - 24, 20);
		sun.loadGraphic(AssetPaths.sun__png, false, 48, 31);
		add(sun);

		bkgMountains = new FlxSpriteGroup();
		mountains = new FlxSpriteGroup();
		details = new FlxSpriteGroup();
		add(bkgMountains);
		add(mountains);

		if (staticBackground)
		{
			ground = new FlxSprite(0, FlxG.height - groundHeight);
			ground.immovable = true;
			ground.loadGraphic(AssetPaths.ground__png, false, 320, 2);
			add(ground);

			generateStaticBackground();

			new FlxTimer().start(FlxG.random.float(4, 10), createWindGust);

			return;
		}

		detailCreator = new FlxTimer().start(1, createGroundDetail);
		createWaterTimer = new FlxTimer().start(1, createWater);
		bkgMountainTimer = new FlxTimer().start(FlxG.random.int(1, 8), createBkgMountain);
		mountainTimer = new FlxTimer().start(FlxG.random.int(1, 4), createMountain);

		ground = new FlxSprite(0, FlxG.height - groundHeight);
		ground.immovable = true;
		ground.loadGraphic(AssetPaths.ground__png, false, 320, 2);
		add(ground);

		new FlxTimer().start(FlxG.random.float(4, 10), createWindGust);
	}

	private function createWindGust(_)
	{
		var gust = new FlxSprite(325, FlxG.random.int(5, Std.int(FlxG.height / 2)));
		gust.loadGraphic(AssetPaths.windGust__png, false, 10, 6);
		gust.velocity.x = -FlxG.random.float(10, 25);
		windGusts.add(gust);

		new FlxTimer().start(FlxG.random.float(4, 10), createWindGust);
	}

	private function generateStaticBackground()
	{
		sun.setPosition(FlxG.width - 60, sun.y);

		var mountain1 = new FlxSprite(40, FlxG.height - groundHeight);
		mountain1.loadGraphic(AssetPaths.bkgMountain1__png, false, 56, 95);
		var mountain2 = new FlxSprite(190, FlxG.height - groundHeight);
		mountain2.loadGraphic(AssetPaths.bkgMountain2__png, false, 238, 104);

		mountain1.y -= mountain1.height;
		mountain2.y -= mountain2.height;

		bkgMountains.add(mountain1);
		bkgMountains.add(mountain2);

		var tree1 = new FlxSprite(4, FlxG.height - groundHeight + 6);
		tree1.loadGraphic(AssetPaths.tree1__png, false, 16, 34);
		tree1.y -= tree1.height;
		details.add(tree1);

		var tree2 = new FlxSprite(FlxG.width - 10, FlxG.height - groundHeight + 5);
		tree2.loadGraphic(AssetPaths.tree2__png, false, 16, 34);
		tree2.y -= tree2.height;
		details.add(tree2);
	}

	private function createBkgMountain(_)
	{
		var mountainType:Int = FlxG.random.int(1, 2);
		var mountain = new FlxSprite(320, FlxG.height - groundHeight);

		switch (mountainType)
		{
			case 1:
				mountain.loadGraphic(AssetPaths.bkgMountain1__png, false, 56, 95);
			case 2:
				mountain.loadGraphic(AssetPaths.bkgMountain2__png, false, 238, 104);
		}

		mountain.y -= mountain.height;
		mountain.velocity.x = -groundSpeed * 0.2;
		bkgMountains.add(mountain);

		bkgMountainTimer = new FlxTimer().start(Math.ceil(mountain.width / groundSpeed * 0.6) + FlxG.random.float(2, Main.bkgMountainSpread),
			createBkgMountain);
	}

	private function createMountain(_)
	{
		var mountainType:Int = FlxG.random.int(1, 2);
		var mountain = new FlxSprite(320, FlxG.height - groundHeight);

		switch (mountainType)
		{
			case 1:
				mountain.loadGraphic(AssetPaths.mountain1__png, false, 147, 68);
			case 2:
				mountain.loadGraphic(AssetPaths.mountain2__png, false, 125, 68);
		}

		mountain.y -= mountain.height;
		mountain.velocity.x = -groundSpeed * 0.55;
		mountains.add(mountain);

		mountainTimer = new FlxTimer().start(Math.ceil(mountain.width / groundSpeed * 0.85) + FlxG.random.float(2, Main.mountainSpread), createMountain);
	}

	private function createWater(_)
	{
		if (createdWater)
		{
			createWaterTimer.start(3, createWater);
			return;
		}

		var waterType:Int = FlxG.random.int(1, 2);
		var water = new FlxSprite(320, FlxG.height - groundHeight);

		switch (waterType)
		{
			case 1:
				water.loadGraphic(AssetPaths.water1__png, false, 20, 4);
			case 2:
				water.loadGraphic(AssetPaths.water2__png, false, 32, 5);
		}

		water.offset.x = water.width * 0.125;
		water.width = water.width * 0.75;

		water.velocity.x = -groundSpeed;
		waterObjects.add(water);

		createdWater = true;
		createWaterTimer = new FlxTimer().start(Math.ceil(water.width / groundSpeed) + 1, function(_)
		{
			createdWater = false;
			createWaterTimer = new FlxTimer().start(FlxG.random.int(1, Main.waterSpread), createWater);
		});
	}

	private function createGroundDetail(_)
	{
		if (createdWater)
		{
			detailCreator = new FlxTimer().start(FlxG.random.int(1, Main.groundDetailSpread), createGroundDetail);
			return;
		}

		var detailType:Int = FlxG.random.int(1, 11);
		var detail = new FlxSprite(320, FlxG.height - groundHeight);
		switch (detailType)
		{
			case 1:
				detail.loadGraphic(AssetPaths.ground_1__png, false, 5, 7);
			case 2:
				detail.loadGraphic(AssetPaths.ground_2__png, false, 3, 5);
			case 3:
				detail.loadGraphic(AssetPaths.ground_3__png, false, 1, 2);
			case 4:
				detail.loadGraphic(AssetPaths.rock1__png, false, 3, 2);
				detail.y -= detail.height;
			case 5:
				detail.loadGraphic(AssetPaths.rock2__png, false, 2, 2);
				detail.y -= detail.height;
			case 6:
				detail.loadGraphic(AssetPaths.shrub1__png, false, 1, 5);
				detail.y -= detail.height;
			case 7:
				detail.loadGraphic(AssetPaths.shrub2__png, false, 1, 3);
				detail.y -= detail.height;
			case 8:
				detail.loadGraphic(AssetPaths.shrub3__png, false, 1, 2);
				detail.y -= detail.height;
			case 9:
				detail.loadGraphic(AssetPaths.shrub4__png, false, 1, 7);
				detail.y -= detail.height;
			case 10:
				detail.loadGraphic(AssetPaths.tree1__png, false, 16, 34);
				detail.y -= detail.height - 6;
			case 11:
				detail.loadGraphic(AssetPaths.tree2__png, false, 19, 43);
				detail.y -= detail.height - 5;
		}

		detail.velocity.x = -groundSpeed;
		details.add(detail);

		detailCreator = new FlxTimer().start(FlxG.random.int(1, Main.groundDetailSpread), createGroundDetail);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// remove if off screen
		details.forEachAlive(function(obj)
		{
			if (obj.x < -obj.width)
			{
				obj.kill();
			}
		});

		windGusts.forEachAlive(function(obj)
		{
			if (obj.x < -obj.width)
			{
				obj.kill();
			}
		});

		bkgMountains.forEachAlive(function(obj)
		{
			if (obj.x < -obj.width)
			{
				obj.kill();
			}
		});

		mountains.forEachAlive(function(obj)
		{
			if (obj.x < -obj.width)
			{
				obj.kill();
			}
		});

		waterObjects.forEachAlive(function(obj)
		{
			if (obj.x < -obj.width)
			{
				obj.kill();
			}
		});
	}

	public function reset()
	{
		details.forEachAlive(function(obj)
		{
			obj.kill();
		});

		bkgMountains.forEachAlive(function(obj)
		{
			obj.kill();
		});

		mountains.forEachAlive(function(obj)
		{
			obj.kill();
		});

		waterObjects.forEachAlive(function(obj)
		{
			obj.kill();
		});
	}
}
