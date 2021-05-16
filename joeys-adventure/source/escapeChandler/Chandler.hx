package escapeChandler;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxSpriteGroup;
import flixel.math.FlxMath;

class Chandler extends FlxSpriteGroup
{
	public var chandler:FlxSprite;

	private var label:FlxSprite;

	// Collision boxes
	public static var jumpWarning:FlxSprite;

	private final jumpWarningX:Int = 20;
	private final jumpForce:Int = 150;
	private final jumpXForce:Int = 26;
	private final xDrag:Int = 14;

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

		jumpWarning = new FlxSprite();
		jumpWarning.makeGraphic(4, Std.int(chandler.height * 1.5), Colors.TRANSPARENT);
		add(jumpWarning);
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		applyGravity(elapsed);
		updateAllSprites();
		bounds();
	}

	private function applyGravity(elapsed:Float)
	{
		chandler.velocity.y += GameState2EscapeChandler.gravity;
	}

	private function updateAllSprites()
	{
		label.setPosition(chandler.x - 8, chandler.y - 12);
		jumpWarning.setPosition(chandler.x + jumpWarningX, chandler.y);
	}

	public function jump()
	{
		chandler.velocity.y = -jumpForce;
		chandler.velocity.x = jumpXForce;
	}

	private function bounds()
	{
		chandler.x = FlxMath.bound(chandler.x, 20, FlxG.width - width);
		chandler.y = FlxMath.bound(chandler.y, 0, FlxG.height - height);
	}

	public function collisionWithGround()
	{
		chandler.velocity.x = -xDrag;
	}
}
