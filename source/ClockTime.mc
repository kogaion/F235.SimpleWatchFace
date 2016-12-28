using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;

class ClockTime extends Updatable
{
    hidden var clockHour;
    hidden var clockMin;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.clockHour = null;
        me.clockMin = null;
    }

    hidden function needsUpdate()
    {
        var clockTime = getTime();
        return ((me.clockHour != clockTime.hour) || (me.clockMin != clockTime.min));
    }

    hidden function drawUpdate(dc)
    {
        var clockTime = getTime();
        me.clockHour = clockTime.hour;
        me.clockMin = clockTime.min;

        var hourColor = Gfx.COLOR_BLUE; // me.params.get(:hourColor); //App.getApp().getProperty("HourColor");
        var hourFont = Gfx.FONT_NUMBER_THAI_HOT; // me.params.get(:hourFont);
        var minColor = Gfx.COLOR_ORANGE; // me.params.get(:minColor);
        var minFont = Gfx.FONT_NUMBER_THAI_HOT; // me.params.get(:minFont);
        var bgColor = me.settings["bgColor"];

        dc.setColor(hourColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2,
            me.settings["screenHeight"] / 2,
            hourFont,
            me.clockHour.format("%02d"),
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER
        );

        dc.setColor(minColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2,
            me.settings["screenHeight"] / 2,
            minFont,
            me.clockMin.format("%02d"),
            Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }

    hidden function getTime()
    {
        return Sys.getClockTime();
    }
}