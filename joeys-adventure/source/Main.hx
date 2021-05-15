package;

import flixel.FlxG;
import flixel.FlxGame;
import flixel.system.FlxAssets.FlxShader;
import openfl.display.Sprite;
import openfl.display.StageQuality;
import openfl.filters.ShaderFilter;

class Main extends Sprite
{
	public static var paused:Bool = false;
	public static var cutScene:Bool = false;

	public static final groundDetailSpread:Int = 7;
	public static final bkgMountainSpread:Int = 34;
	public static final mountainSpread:Int = 20;
	public static final waterSpread:Int = 21;

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
