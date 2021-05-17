package;

import WiggleEffect.WiggleEffectType;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.system.FlxSound;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import openfl.display.StageQuality;

class StoryState extends FlxState
{
	private var canvas:FlxSprite;

	private var currentStoryPart:Int = 0;

	private var introToNanny:FlxSound;
	private var offLimits:FlxSound;
	private var rossAskForHelp:FlxSound;
	private var chandlerStop:FlxSound;

	private var started:Bool = false;

	private var introToNannyIdx:Int = 0;
	private var offLimitsIdx:Int = 0;
	private var chandlerStopIdx:Int = 0;

	private var transitioning:Bool = false;
	private var waveEffect:WiggleEffect;

	override public function create()
	{
		super.create();

		FlxG.game.stage.quality = StageQuality.BEST;
		FlxG.resizeGame(1920, 1080);

		loadSounds();

		if (FlxG.sound.music != null)
		{
			FlxTween.tween(FlxG.sound.music, {volume: 0}, 1, {onComplete: playStoryPart});
		}
		else
		{
			gotoGame(null);
		}
	}

	private function loadSounds()
	{
		introToNanny = FlxG.sound.load(AssetPaths.introToNanny__ogg, 0.8, false);
		offLimits = FlxG.sound.load(AssetPaths.offLimits__ogg, 0.8, false);
		rossAskForHelp = FlxG.sound.load(AssetPaths.rossAskChandlerForHelp__ogg, 0.8, false);
		chandlerStop = FlxG.sound.load(AssetPaths.chandlerAttemptsToStop__ogg, 0.8, false);
	}

	private function playStoryPart(_)
	{
		switch (currentStoryPart)
		{
			case 0:
				canvas = new FlxSprite();
				canvas.loadGraphic(AssetPaths.introToNanny__jpg, false, 1920, 1080);
				canvas.scale.set(0.25, 0.25);
				canvas.screenCenter();
				add(canvas);
				introToNanny.play();
				started = true;
				new FlxTimer().start(5, introToNannyNext);

			case 1:
				canvas.loadGraphic(AssetPaths.offLimits1__jpg, false, 1920, 1080);
				offLimits.play();
				new FlxTimer().start(5, offLimitsNext);

			case 2:
				canvas.loadGraphic(AssetPaths.rossAskChandlerForHelp__jpg, false, 1920, 1080);
				rossAskForHelp.play();
			case 3:
				canvas.loadGraphic(AssetPaths.stableBoy__jpg, false, 1920, 1080);
				chandlerStop.play();
				new FlxTimer().start(38, chandlerStopNext);
			case 4:
				transition();
		}
	}

	private function chandlerStopNext(_)
	{
		chandlerStopIdx++;
		switch (chandlerStopIdx)
		{
			case 1:
				canvas.loadGraphic(AssetPaths.stableBoy1__jpg, false, 1920, 1080);
				new FlxTimer().start(6, chandlerStopNext);
			case 2:
				canvas.loadGraphic(AssetPaths.stableBoy__jpg, false, 1920, 1080);
				new FlxTimer().start(7.5, chandlerStopNext);
			case 3:
				canvas.loadGraphic(AssetPaths.stableBoy1__jpg, false, 1920, 1080);
		}
	}

	private function offLimitsNext(_)
	{
		offLimitsIdx++;
		switch (offLimitsIdx)
		{
			case 1:
				canvas.loadGraphic(AssetPaths.offLimits2__jpg, false, 1920, 1080);
				new FlxTimer().start(1, offLimitsNext);
			case 2:
				canvas.loadGraphic(AssetPaths.offLimits1__jpg, false, 1920, 1080);
				new FlxTimer().start(6, offLimitsNext);
			case 3:
				canvas.loadGraphic(AssetPaths.offLimits2__jpg, false, 1920, 1080);
				new FlxTimer().start(10, offLimitsNext);
			case 4:
				canvas.loadGraphic(AssetPaths.offLimits1__jpg, false, 1920, 1080);
				new FlxTimer().start(6.2, offLimitsNext);
			case 5:
				canvas.loadGraphic(AssetPaths.offLimits3__jpg, false, 1920, 1080);
				new FlxTimer().start(10, offLimitsNext);
		}
	}

	private function introToNannyNext(_)
	{
		introToNannyIdx++;
		switch (introToNannyIdx)
		{
			case 1:
				canvas.loadGraphic(AssetPaths.introToNanny2__jpg, false, 1920, 1080);
				new FlxTimer().start(3, introToNannyNext);
			case 2:
				canvas.loadGraphic(AssetPaths.introToNanny3__jpg, false, 1920, 1080);
				new FlxTimer().start(3, introToNannyNext);
			case 3:
				canvas.loadGraphic(AssetPaths.introToNanny4__jpg, false, 1920, 1080);
				new FlxTimer().start(6, introToNannyNext);
			case 4:
				canvas.loadGraphic(AssetPaths.introToNanny5__jpg, false, 1920, 1080);
				new FlxTimer().start(4, introToNannyNext);
			case 5:
				canvas.loadGraphic(AssetPaths.introToNanny5a__jpg, false, 1920, 1080);
				new FlxTimer().start(3, introToNannyNext);
			case 6:
				canvas.loadGraphic(AssetPaths.introToNanny6__jpg, false, 1920, 1080);
				new FlxTimer().start(3.5, introToNannyNext);
			case 7:
				canvas.loadGraphic(AssetPaths.introToNanny6a__jpg, false, 1920, 1080);
				new FlxTimer().start(2.5, introToNannyNext);
			case 8:
				canvas.loadGraphic(AssetPaths.introToNanny7__jpg, false, 1920, 1080);
				new FlxTimer().start(15, introToNannyNext);
			case 9:
				canvas.loadGraphic(AssetPaths.introToNanny8__jpg, false, 1920, 1080);
				new FlxTimer().start(14, introToNannyNext);
			case 10:
				canvas.loadGraphic(AssetPaths.introToNanny9__jpg, false, 1920, 1080);
				new FlxTimer().start(4, introToNannyNext);
		}
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (waveEffect != null)
			waveEffect.update(elapsed);

		keyboardListen();

		continueStory();
	}

	private function continueStory()
	{
		if (!started)
			return;

		if ((currentStoryPart == 0 && !introToNanny.playing)
			|| (currentStoryPart == 1 && !offLimits.playing)
			|| (currentStoryPart == 2 && !rossAskForHelp.playing || (currentStoryPart == 3 && !chandlerStop.playing)))
		{
			currentStoryPart++;
			playStoryPart(null);
		}
	}

	private function gotoGame(_)
	{
		FlxG.camera.fade(Colors.TanGray, 0.33, false, function()
		{
			FlxG.game.stage.quality = StageQuality.LOW;
			FlxG.resizeGame(320, 180);
			FlxG.switchState(new PreStateEscapeChandler());
		});
	}

	private function transition()
	{
		if (transitioning)
			return;

		transitioning = true;

		canvas.loadGraphic(AssetPaths.stableBoy1__jpg, false, 1920, 1080);

		waveEffect = new WiggleEffect();
		waveEffect.effectType = WiggleEffectType.DREAMY;
		waveEffect.waveAmplitude = 0.1;
		waveEffect.waveFrequency = 3;
		waveEffect.waveSpeed = 4;
		canvas.shader = waveEffect.shader;

		new FlxTimer().start(1, gotoGame);
	}

	private function keyboardListen()
	{
		if (FlxG.keys.anyJustPressed([SPACE, ENTER, ESCAPE]))
		{
			transition();
		}
	}
}
