using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

class Updatable extends Ui.Drawable
{
    hidden var params;
    hidden var settings;

    function initialize(params)
    {
        Drawable.initialize(params);
        me.params = params;
        me.settings = Sys.getDeviceSettings();
    }

    function draw(dc)
    {
        if (me.needsUpdate()) {
            me.drawUpdate(dc);
        }
    }

    function onReset()
    {
    }

    hidden function needsUpdate()
    {
        return false;
    }

    hidden function drawUpdate(dc)
    {
    }
}