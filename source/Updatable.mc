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

        var systemSettings = Sys.getDeviceSettings();
        me.settings = {
            "screenWidth"   => systemSettings.screenWidth,
            "screenHeight"  => systemSettings.screenHeight,
            "offsetTop"     => 28,
            "offsetCenter"  => 67
        };
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