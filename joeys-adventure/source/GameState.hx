package;

import flixel.FlxG;
import flixel.FlxState;
import gameStateClasses.Background;

class GameState extends FlxState
{
	// -----------------------------------
	//  -- Game Play
	public static final groundSpeed:Int = 24;
	public static final groundDetailSpread:Int = 7;

	// -----------------------------------
	private var background:Background;

	override public function create()
	{
		super.create();

		background = new Background();
		add(background);
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
