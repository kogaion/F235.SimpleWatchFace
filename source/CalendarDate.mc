using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Time.Gregorian as Greg;

class CalendarDate extends Updatable
{
    hidden var day, month, year;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.day = null;
        me.month = null;
        me.year = null;
    }

    hidden function needsUpdate()
    {
        var date = me.getDate();
        return ((date.year != me.year) || (date.month != me.month) || (date.day != me.day));
    }

    hidden function drawUpdate(dc)
    {
        var date = me.getDate();
        me.year = date.year;
        me.month = date.month;
        me.day = date.day;

        var fgColor = Gfx.COLOR_WHITE;
        var bgColor = Gfx.COLOR_BLACK;
        var font = Gfx.FONT_XTINY;

        dc.setColor(fgColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2,
            me.settings["screenHeight"] - me.settings["offsetTop"],
            font,
            date.day_of_week + ", " + date.month + " " + date.day,
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }

    hidden function getDate()
    {
        return Greg.info(Time.now(), Time.FORMAT_MEDIUM);
    }
}