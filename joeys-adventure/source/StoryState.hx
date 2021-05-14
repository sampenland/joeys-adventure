package;

import flixel.FlxG;
import flixel.FlxState;

class StoryState extends FlxState
{
	override public function create()
	{
		super.create();
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (!FlxG.sound.music.playing)
			FlxG.sound.playMusic(AssetPaths.music2_looped__ogg, 0.8, true);

		keyboardListen();
	}

	private function gotoGame()
	{
		FlxG.camera.fade(Colors.TanGray, 0.33, false, function()
		{
			FlxG.switchState(new GameState());
		});
	}

	private function keyboardListen()
	{
		if (FlxG.keys.anyJustPressed([SPACE]))
		{
			gotoGame();
		}
	}
}
