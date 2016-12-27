using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Battery extends Updatable
{
    const MAX_BATTERY_PERCENT = 99;
    const MAX_BATTERY_ICON = "9";

    hidden var batteryPercent;
    hidden var batteryIconFont;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.batteryPercent = null;
    }

    hidden function needsUpdate()
    {
        return (me.batteryPercent != me.getBatteryPercent());
    }

    hidden function drawUpdate(dc)
    {
        me.batteryPercent = me.getBatteryPercent();

        var batteryPercentText = " " + me.batteryPercent.toNumber().format("%2d") + "%";
        var batteryPercentColor = Gfx.COLOR_WHITE;
        var batteryPercentFont = Gfx.FONT_XTINY;

        var batteryIconText = me.getBatteryIconText();
        var batteryIconColor = (me.batteryPercent <= 10) ? Gfx.COLOR_RED : Gfx.COLOR_WHITE;
        me.batteryIconFont = me.getBatteryIconFont();

        var bgColor = Gfx.COLOR_BLACK;

        // clear the area
        var textDimensions = dc.getTextDimensions(" " + me.MAX_BATTERY_PERCENT.toNumber().format("%02d") + "%", batteryPercentFont);
        var iconDimensions = dc.getTextDimensions(me.MAX_BATTERY_ICON, batteryIconFont);
        var areaWidth = textDimensions[0] + iconDimensions[0];
        var areaHeight = textDimensions[1] > iconDimensions[1] ? textDimensions[1] : iconDimensions[1];
        dc.setColor(bgColor, bgColor);
        dc.fillRectangle(
            me.settings["screenWidth"] / 2 + me.settings["offsetCenter"] - areaWidth - 1,
            me.settings["offsetTop"] - areaHeight / 2 - 1,
            areaWidth + 2,
            areaHeight + 2
        );

        // draw the percent text
        dc.setColor(batteryPercentColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 + me.settings["offsetCenter"],
            me.settings["offsetTop"],
            batteryPercentFont,
            batteryPercentText,
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER
        );

        // draw the battery icon
        var batteryPercentTextWidth = dc.getTextWidthInPixels(batteryPercentText, batteryPercentFont);
        dc.setColor(batteryIconColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 + me.settings["offsetCenter"] - batteryPercentTextWidth,
            me.settings["offsetTop"],
            me.batteryIconFont,
            batteryIconText,
            Gfx.TEXT_JUSTIFY_RIGHT | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }

    hidden function getBatteryPercent()
    {
        var stats = Sys.getSystemStats();
        var batteryPercent = stats.battery;

         // show max MAX_BATTERY_PERCENT
        batteryPercent = (batteryPercent > me.MAX_BATTERY_PERCENT) ? me.MAX_BATTERY_PERCENT : batteryPercent;

        return batteryPercent;
    }

    hidden function getBatteryIconFont()
    {
        if (me.batteryIconFont == null) {
            me.batteryIconFont = Ui.loadResource(Rez.Fonts.battery);
        }
        return me.batteryIconFont;
    }

    hidden function getBatteryIconText()
    {
        var batteryPercent = me.getBatteryPercent();

        if (batteryPercent <= 10) {
            return "0";
        } else if (batteryPercent <= 30) {
            return "1";
        } else if (batteryPercent <= 50) {
            return "3";
        } else if (batteryPercent <= 70) {
            return "5";
        } else if (batteryPercent <= 90) {
            return "7";
        } else {
            return me.MAX_BATTERY_ICON;
        }
    }

}