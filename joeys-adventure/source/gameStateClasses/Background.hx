package gameStateClasses;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.group.FlxSpriteGroup;
import flixel.util.FlxTimer;

class Background extends FlxTypedGroup<FlxSprite>
{
	private var backgroundColor:FlxSprite;

	private var ground:FlxSprite;
	private var detailCreator:FlxTimer;

	private var sun:FlxSprite;

	private var createdWater:Bool = false;
	private var createWaterTimer:FlxTimer;

	private var bkgMountainTimer:FlxTimer;
	private var mountainTimer:FlxTimer;

	private var bkgMountains:FlxSpriteGroup;
	private var mountains:FlxSpriteGroup;

	override public function new()
	{
		super();

		backgroundColor = new FlxSprite();
		backgroundColor.loadGraphic(AssetPaths.background__png, false, 320, 180);
		add(backgroundColor);

		bkgMountains = new FlxSpriteGroup();
		mountains = new FlxSpriteGroup();
		add(bkgMountains);
		add(mountains);

		detailCreator = new FlxTimer().start(1, createGroundDetail);
		createWaterTimer = new FlxTimer().start(1, createWater);
		bkgMountainTimer = new FlxTimer().start(FlxG.random.int(1, 8), createBkgMountain);
		mountainTimer = new FlxTimer().start(FlxG.random.int(1, 4), createMountain);

		ground = new FlxSprite(0, FlxG.height - GameState.groundHeight);
		ground.loadGraphic(AssetPaths.ground__png, false, 320, 2);
		add(ground);

		sun = new FlxSprite(FlxG.width / 2, 32);
		sun.loadGraphic(AssetPaths.sun__png, false, 48, 31);
		add(sun);
	}

	private function createBkgMountain(_)
	{
		var mountainType:Int = FlxG.random.int(1, 2);
		var mountain = new FlxSprite(320, FlxG.height - GameState.groundHeight);

		switch (mountainType)
		{
			case 1:
				mountain.loadGraphic(AssetPaths.bkgMountain1__png, false, 56, 95);
			case 2:
				mountain.loadGraphic(AssetPaths.bkgMountain2__png, false, 238, 104);
		}

		mountain.y -= mountain.height;
		mountain.velocity.x = -GameState.groundSpeed * 0.6;
		bkgMountains.add(mountain);

		bkgMountainTimer = new FlxTimer().start(Math.ceil(mountain.width / GameState.groundSpeed * 0.6) + FlxG.random.float(2, GameState.bkgMountainSpread),
			createBkgMountain);
	}

	private function createMountain(_)
	{
		var mountainType:Int = FlxG.random.int(1, 2);
		var mountain = new FlxSprite(320, FlxG.height - GameState.groundHeight);

		switch (mountainType)
		{
			case 1:
				mountain.loadGraphic(AssetPaths.mountain1__png, false, 147, 68);
			case 2:
				mountain.loadGraphic(AssetPaths.mountain2__png, false, 125, 68);
		}

		mountain.y -= mountain.height;
		mountain.velocity.x = -GameState.groundSpeed * 0.85;
		mountains.add(mountain);

		mountainTimer = new FlxTimer().start(Math.ceil(mountain.width / GameState.groundSpeed * 0.85) + FlxG.random.float(2, GameState.mountainSpread),
			createMountain);
	}

	private function createWater(_)
	{
		if (createdWater)
		{
			createWaterTimer.start(3, createWater);
			return;
		}

		var waterType:Int = FlxG.random.int(1, 2);
		var water = new FlxSprite(320, FlxG.height - GameState.groundHeight);

		switch (waterType)
		{
			case 1:
				water.loadGraphic(AssetPaths.water1__png, false, 20, 4);
			case 2:
				water.loadGraphic(AssetPaths.water2__png, false, 32, 5);
		}

		water.velocity.x = -GameState.groundSpeed;
		add(water);

		createdWater = true;
		createWaterTimer = new FlxTimer().start(Math.ceil(water.width / GameState.groundSpeed) + 1, function(_)
		{
			createdWater = false;
			createWaterTimer = new FlxTimer().start(FlxG.random.int(1, GameState.waterSpread), createWater);
		});
	}

	private function createGroundDetail(_)
	{
		if (createdWater)
		{
			detailCreator = new FlxTimer().start(FlxG.random.int(1, GameState.groundDetailSpread), createGroundDetail);
			return;
		}

		var detailType:Int = FlxG.random.int(1, 9);
		var detail = new FlxSprite(320, FlxG.height - GameState.groundHeight);
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
		}

		detail.velocity.x = -GameState.groundSpeed;
		add(detail);

		detailCreator = new FlxTimer().start(FlxG.random.int(1, GameState.groundDetailSpread), createGroundDetail);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		// remove if off screen
		forEachAlive(function(obj)
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
	}
}
