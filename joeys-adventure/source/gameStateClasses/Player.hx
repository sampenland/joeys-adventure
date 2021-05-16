package gameStateClasses;

import Main.Levels;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class Player extends FlxSpriteGroup
{
	private final moveSpeed:Int = 2500;
	private final jumpForce:Int = 150;

	// Sounds
	private static var frustrationSound:FlxSound;
	private static var jumpSound:FlxSound;

	// Stats
	private var hunger:Int = 100;
	private var lives:Int = 3;

	// Sprites
	public var player:FlxSprite;

	private var jumpText:FlxSprite;

	// Collision boxes
	public static var jumpWarning:FlxSprite;

	private final jumpWarningX:Int = 20;

	override public function new(x:Float, y:Float)
	{
		super(x, y);

		loadSounds();

		player = new FlxSprite();
		add(player);

		player.loadGraphic(AssetPaths.player__png, true, 16, 12);
		player.animation.add("idle", [0, 1, 2, 3, 4], 12, true);
		player.animation.add("right", [0, 1, 2, 3, 4], 18, true);
		player.animation.add("left", [5, 6, 7, 8, 9], 14, true);
		player.animation.add("waterDie", [10, 11, 12, 13], 6, false);
		player.animation.add("jump", [14, 15, 16], 12, false);
		player.animation.play("idle");

		player.offset.x = player.width / 3;
		player.width = player.width / 4;

		jumpText = new FlxSprite(-8, -12);
		jumpText.loadGraphic(AssetPaths.jumpLabel__png, false, 26, 12);
		jumpText.alpha = 0;
		add(jumpText);

		jumpWarning = new FlxSprite();
		jumpWarning.makeGraphic(4, Std.int(player.height * 1.5), Colors.TRANSPARENT);
		add(jumpWarning);
	}

	public function showJumpWarning()
	{
		jumpText.alpha = 1;
		FlxTween.tween(jumpText, {alpha: 0}, 2);
	}

	private function loadSounds()
	{
		frustrationSound = FlxG.sound.load(AssetPaths.frustration__ogg, 0.6, false);
		jumpSound = FlxG.sound.load(AssetPaths.jump__ogg, 0.5, false);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		updateAllSprites();

		keyboardControls(elapsed);
		applyGravity(elapsed);
		bounds();
		checkHunger();
		checkLives();
	}

	private function updateAllSprites()
	{
		jumpWarning.setPosition(player.x + jumpWarningX, player.y);
		jumpText.setPosition(player.x - 8, player.y - 12);
	}

	private function checkLives()
	{
		if (lives <= 0)
		{
			switch (Main.currentLevel)
			{
				case Levels.EscapeChandler:
					GameState2EscapeChandler.endGame();
			}
		}
	}

	private function checkHunger()
	{
		if (hunger <= 0)
		{
			switch (Main.currentLevel)
			{
				case Levels.EscapeChandler:
					GameState2EscapeChandler.respawnPlayer(null);
			}

			changeHunger(100, true);
		}
	}

	private function applyGravity(elapsed:Float)
	{
		if (Main.cutScene)
			return;

		switch (Main.currentLevel)
		{
			case Levels.EscapeChandler:
				player.velocity.y += GameState2EscapeChandler.gravity;
		}
	}

	private function bounds()
	{
		player.x = FlxMath.bound(player.x, 0, FlxG.width - width);
		player.y = FlxMath.bound(player.y, 0, FlxG.height - height);
	}

	private function keyboardControls(elapsed:Float)
	{
		if (Main.cutScene)
			return;

		var jump = FlxG.keys.anyPressed([W, UP, SPACE]);
		var down = FlxG.keys.anyPressed([S, DOWN]);
		var right = FlxG.keys.anyPressed([D, RIGHT]);
		var left = FlxG.keys.anyPressed([A, LEFT]);

		player.velocity.x = 0;

		if (right)
		{
			if (velocity.y == 0)
				player.animation.play("right");

			player.velocity.x = moveSpeed * elapsed;
		}
		else if (left)
		{
			if (player.velocity.y == 0)
				player.animation.play("left");

			player.velocity.x = -moveSpeed * elapsed;
		}
		else if (player.velocity.y == 0)
		{
			player.animation.play("idle");
		}

		if (jump && player.velocity.y == 0)
		{
			player.animation.play("jump");
			player.velocity.y = -jumpForce;
			jumpSound.play(true);

			changeHunger(-10);
		}
	}

	private function changeHunger(val:Int, ?set:Bool)
	{
		hunger += val;

		if (set != null)
			hunger = val;

		switch (Main.currentLevel)
		{
			case Levels.EscapeChandler:
				GameState2EscapeChandler.hud.updateValues(hunger, lives);
		}
	}

	public function collisionWithWater()
	{
		switch (Main.currentLevel)
		{
			case Levels.EscapeChandler:
				player.animation.play("waterDie");
				player.animation.finishCallback = GameState2EscapeChandler.respawnPlayer;
				Main.cutScene = true;
		}
	}

	public function levelReset()
	{
		player.animation.finishCallback = null;
		lives -= 1;
		hunger = 100;

		if (lives >= 1)
			frustrationSound.play();

		switch (Main.currentLevel)
		{
			case Levels.EscapeChandler:
				jumpText.alpha = 0;
				player.x = GameState2EscapeChandler.playerStartXPos;
				GameState2EscapeChandler.hud.updateValues(hunger, lives);
		}
	}

	public function collisionWithGround() {}
}
