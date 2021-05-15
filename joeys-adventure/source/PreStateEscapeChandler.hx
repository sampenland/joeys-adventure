package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.util.FlxTimer;

class PreStateEscapeChandler extends FlxState
{
	private var transitioning:Bool = false;

	override function create()
	{
		super.create();

		FlxG.sound.playMusic(AssetPaths.music2_looped__ogg, 0.5, false);

		var backgroundColor = new FlxSprite();
		backgroundColor.loadGraphic(AssetPaths.background__png, false, 320, 180);
		add(backgroundColor);

		var note1 = new FlxText(0, 0, 0, "Joey the Stable Boy", 16);
		note1.setFormat(null, 16, Colors.DarkRed);
		note1.screenCenter();
		note1.y -= 48;
		add(note1);

		var note1 = new FlxText(0, 0, 0, "begins his quest", 15);
		note1.setFormat(null, 15, Colors.DarkRed);
		note1.screenCenter();
		add(note1);

		var instructions = new FlxText(0, 0, 0, "with Chandler on his heels!", 15);
		instructions.setFormat(null, 15, Colors.DarkRed);
		instructions.screenCenter();
		instructions.y += 48;
		add(instructions);

		new FlxTimer().start(6, startNextState);
	}

	private function startNextState(_)
	{
		if (transitioning)
			return;

		transitioning = true;
		FlxG.camera.fade(Colors.TanGray, 0.33, false, function()
		{
			FlxG.switchState(new GameState2EscapeChandler());
		});
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		if (FlxG.keys.anyJustPressed([SPACE, ENTER, ESCAPE]))
		{
			startNextState(null);
		}
	}
}
