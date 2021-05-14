package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.FlxAssets.FlxShader;
import openfl.display.Sprite;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

class Main extends Sprite
{
	public function new()
	{
		super();
		addChild(new FlxGame(0, 0, StartState, 1, 60, 60, true));
		FlxG.mouse.visible = false;
		FlxG.game.setFilters([new ShaderFilter(new FlxShader())]);
		FlxG.game.stage.quality = StageQuality.LOW;
		FlxG.fullscreen = true;
	}
}
