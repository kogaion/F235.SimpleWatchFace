using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Bluetooth extends Updatable
{
    hidden var bthStatus;
    hidden var bthFont;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.bthStatus = null;
    }

    hidden function getBthStatus()
    {
        var settings = Sys.getDeviceSettings();
        return settings.phoneConnected;
    }

    hidden function getBthFont()
    {
        if (me.bthFont == null) {
            me.bthFont = Ui.loadResource(Rez.Fonts.bluetooth);
        }
        return me.bthFont;
    }

    hidden function needsUpdate()
    {
        return (me.bthStatus != me.getBthStatus());
    }

    hidden function drawUpdate(dc)
    {
        me.bthStatus = me.getBthStatus();

        var bthColor = (me.bthStatus) ? Gfx.COLOR_ORANGE : Gfx.COLOR_DK_GRAY;
        var bgColor = Gfx.COLOR_BLACK;

        var bthFont = me.getBthFont();

        dc.setColor(bthColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 - me.settings["offsetCenter"],
            me.settings["screenHeight"] - me.settings["offsetTop"],
            bthFont,
            "0",
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
        );
    }
}