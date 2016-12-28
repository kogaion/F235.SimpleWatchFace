using Toybox.System as Sys;
using Toybox.Graphics as Gfx;
using Toybox.Application as App;
using Toybox.WatchUi as Ui;

class Notifications extends Updatable
{
    const MAX_NOTIF_COUNT = 99;

    hidden var notifCount;
    hidden var notifIconFont;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.notifCount = null;
    }

    hidden function needsUpdate()
    {
        return (me.notifCount != me.getNotifCount());
    }

    hidden function drawUpdate(dc)
    {
        me.notifCount = me.getNotifCount();

        var notifColor = (me.notifCount) ? Gfx.COLOR_ORANGE : Gfx.COLOR_DK_GRAY;
        var notifCountFont = Gfx.FONT_XTINY;

        var bgColor = me.settings["bgColor"];

        var notifIconFont = me.getNotifIconFont();
        var notifIconText = "0";

        // clear the area
        var textDimensions = dc.getTextDimensions(" " + me.MAX_NOTIF_COUNT, notifCountFont);
        var iconDimensions = dc.getTextDimensions(notifIconText, notifIconFont);
        var areaWidth = textDimensions[0] + iconDimensions[0];
        var areaHeight = textDimensions[1] > iconDimensions[1] ? textDimensions[1] : iconDimensions[1];
        dc.setColor(bgColor, bgColor);
        dc.fillRectangle(
            me.settings["screenWidth"] / 2 - me.settings["offsetCenter"],
            me.settings["offsetTop"] - areaHeight / 2 - 1,
            areaWidth + 2,
            areaHeight + 2
        );

        // draw the icon
        dc.setColor(notifColor, bgColor);
        dc.drawText(
            me.settings["screenWidth"] / 2 - me.settings["offsetCenter"],
            me.settings["offsetTop"],
            notifIconFont,
            notifIconText,
            Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER
        );

        // draw the notifications count
        if (me.notifCount) {
            var notifWidth = dc.getTextWidthInPixels(notifIconText, me.notifIconFont);

            dc.drawText(
                me.settings["screenWidth"] / 2 - me.settings["offsetCenter"] + notifWidth,
                me.settings["offsetTop"],
                notifCountFont,
                " " + notifCount,
                Gfx.TEXT_JUSTIFY_LEFT | Gfx.TEXT_JUSTIFY_VCENTER
            );
        }
    }

    hidden function getNotifCount()
    {
        var settings = Sys.getDeviceSettings();
        var notifCount = settings.notificationCount;

        // show max MAX_NOTIF_COUNT
        notifCount = (notifCount > me.MAX_NOTIF_COUNT) ? me.MAX_NOTIF_COUNT : notifCount;

        return notifCount;
    }

    hidden function getNotifIconFont()
    {
        if (me.notifIconFont == null) {
            me.notifIconFont = Ui.loadResource(Rez.Fonts.briefcase);
        }
        return me.notifIconFont;
    }
}