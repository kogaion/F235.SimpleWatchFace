using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.ActivityMonitor as Act;
using Toybox.WatchUi as Ui;
using Toybox.Time as Time;

class HeartRate extends Updatable
{
    hidden var heartRate;
    hidden var hrFont;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.heartRate = null;
    }

    hidden function needsUpdate()
    {
        return (me.heartRate != me.getHeartRate());
    }

    hidden function drawUpdate(dc)
    {
        me.heartRate = me.getHeartRate();

        var hrColor = null;
        if (me.heartRate >= 165) {
            hrColor = Gfx.COLOR_RED;
        } else if (me.heartRate >= 145) {
            hrColor = Gfx.COLOR_ORANGE;
        } else if (me.heartRate >= 130) {
            hrColor = Gfx.COLOR_GREEN;
        } else if (me.heartRate >= 110) {
            hrColor = Gfx.COLOR_BLUE;
        } else {
            hrColor = Gfx.COLOR_DK_GRAY;
        }

        var bgColor = me.settings["bgColor"];
        var hrFont = me.getHeartRateFont();

        dc.setColor(hrColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2,
            me.settings["offsetTop"],
            hrFont,
            "0",
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }

    hidden function getHeartRate()
    {
        var iterator = Act.getHeartRateHistory(10, true);
        while (true) {
            var sample = iterator.next();
            if (sample.heartRate == Act.INVALID_HR_SAMPLE) {
                continue;
            }
            var age = Time.now().subtract(sample.when).value();
            if (age > 60) {
                break;
            }

            return sample.heartRate;
        }
        return 0;
    }

    hidden function getHeartRateFont()
    {
        if (me.hrFont == null) {
            me.hrFont = Ui.loadResource(Rez.Fonts.heart);
        }
        return me.hrFont;
    }
}