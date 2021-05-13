package;

import flixel.FlxG;
import flixel.FlxState;
import gameStateClasses.Background;
import gameStateClasses.Player;

class GameState extends FlxState
{
	// -----------------------------------
	//  -- Game Play
	public static final groundSpeed:Int = 24;
	public static final groundDetailSpread:Int = 7;
	public static final bkgMountainSpread:Int = 34;
	public static final mountainSpread:Int = 20;
	public static final waterSpread:Int = 21;
	public static final groundHeight:Int = 24;

	// Static
	public static var player:Player;

	// -----------------------------------
	private var background:Background;

	override public function create()
	{
		super.create();

		background = new Background();
		add(background);

		player = new Player(20, FlxG.height - GameState.groundHeight - 12);
		add(player);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		keyboardListen();
	}

	private function keyboardListen()
	{
		if (FlxG.keys.anyJustPressed([ESCAPE]))
		{
			Sys.exit(0);
		}
	}
}
