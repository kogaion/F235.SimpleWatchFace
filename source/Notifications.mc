using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Notifications extends Updatable
{
    hidden var notifCount;
    hidden var notifFont;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.notifCount = null;
    }

    hidden function getNotifCount()
    {
        var settings = Sys.getDeviceSettings();
        return settings.notificationCount;
    }

    hidden function getNotifFont()
    {
        if (me.notifFont == null) {
            me.notifFont = Ui.loadResource(Rez.Fonts.briefcase);
        }
        return me.notifFont;
    }

    hidden function needsUpdate()
    {
        return (me.notifCount != me.getNotifCount());
    }

    hidden function drawUpdate(dc)
    {
        me.notifCount = me.getNotifCount();

        var notifColor = (me.notifCount) ? Gfx.COLOR_ORANGE : Gfx.COLOR_DK_GRAY;
        var bgColor = Gfx.COLOR_BLACK;

        var notifFont = me.getNotifFont();
        var notifText = "0";

        dc.setColor(notifColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 - me.settings["offsetCenter"],
            me.settings["offsetTop"],
            notifFont,
            notifText,
            Gfx.TEXT_JUSTIFY_CENTER | Gfx.TEXT_JUSTIFY_VCENTER
        );

        if (me.notifCount) {
            var notifWidth = dc.getTextWidthInPixels(notifText, me.notifFont);
            var notifCountFont = Gfx.FONT_XTINY;
            dc.drawText(
                me.settings["screenWidth"] / 2 - me.settings["offsetCenter"] + notifWidth,
                me.settings["offsetTop"],
                notifCountFont,
                "" + notifCount,
                Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER
            );
        }
    }
}