using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;
using Toybox.WatchUi as Ui;
using Toybox.Math as Math;

class StepsGoal extends Updatable
{
    const MAX_STEPS_GOAL = 4;

    hidden var stepsGoal;
    hidden var stepsFont;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.stepsGoal = null;
    }

    hidden function needsUpdate()
    {
        return (me.stepsGoal != me.getStepsGoal());
    }

    hidden function drawUpdate(dc)
    {
        me.stepsGoal = me.getStepsGoal();

        var stepsColor = null;
        if (me.stepsGoal >= me.MAX_STEPS_GOAL) {
            stepsColor = Gfx.COLOR_GREEN;
        } else if (me.stepsGoal >= 3) {
            stepsColor = Gfx.COLOR_BLUE;
        } else if (me.stepsGoal >= 2) {
            stepsColor = Gfx.COLOR_ORANGE;
        } else if (me.stepsGoal >= 1) {
            stepsColor = Gfx.COLOR_RED;
        } else {
            stepsColor = Gfx.COLOR_DK_GRAY;
        }

        var bgColor = me.settings["bgColor"];

        var stepsFont = me.getStepsFont();

        dc.setColor(stepsColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 + me.settings["offsetCenter"],
            me.settings["screenHeight"] - me.settings["offsetTop"],
            stepsFont,
            "0",
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }

    hidden function getStepsGoal()
    {
        var info = Act.getInfo();
        var goal = info.stepGoal;
        var steps = info.steps;

        if (goal == 0 || steps == 0) {
            return 0;
        }

        if (steps >= goal) {
            return me.MAX_STEPS_GOAL;
        }

        var ratio = 100.0 * steps / goal;
        if (ratio == 0) {
            return 0;
        }

        return (Math.floor(ratio / 25)).toLong();
    }

    hidden function getStepsFont()
    {
        if (me.stepsFont == null) {
            me.stepsFont = Ui.loadResource(Rez.Fonts.heart);
        }

        return me.stepsFont;
    }
}