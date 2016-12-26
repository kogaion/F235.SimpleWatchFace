using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;
using Toybox.WatchUi as Ui;

class StepsGoal extends Updatable
{
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
        var steps = me.getStepsGoal();
        return (me.stepsGoal != steps);
    }

    hidden function drawUpdate(dc)
    {
        var steps = me.getStepsGoal();
        me.stepsGoal = steps;

        var stepsColor = null;
        if (me.stepsGoal >= 4) {
            stepsColor = Gfx.COLOR_GREEN;
        } else if (me.stepsGoal == 3) {
            stepsColor = Gfx.COLOR_BLUE;
        } else if (me.stepsGoal == 2) {
            stepsColor = Gfx.COLOR_ORANGE;
        } else if (me.stepsGoal == 1) {
            stepsColor = Gfx.COLOR_RED;
        } else {
            stepsColor = Gfx.COLOR_DK_GRAY;
        }

        var bgColor = Gfx.COLOR_BLACK;

        dc.setColor(stepsColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 + me.settings["offsetCenter"],
            me.settings["screenHeight"] - me.settings["offsetTop"],
            me.getStepsFont(),
            "0",
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }

    hidden function getStepsGoal()
    {
        var info = Act.getInfo();
        var stepsGoal = info.stepGoal;
        var steps = info.steps;

        var ratio = 100.0 * steps / stepsGoal;
        return (ratio.toLong() % 25);
    }

    hidden function getStepsFont()
    {
        if (me.stepsFont == null) {
            me.stepsFont = Ui.loadResource(Rez.Fonts.heart);
        }

        return me.stepsFont;
    }
}