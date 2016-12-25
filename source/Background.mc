using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class Background extends Updatable
{
    hidden var drawBg = 0;

    function initialize(params)
    {
        Updatable.initialize(params);
    }

    function onReset()
    {
        me.drawBg = 1;
    }

    hidden function drawUpdate(dc)
    {
        me.drawBg = 0;

        // Set the background color then call to clear the screen
        dc.setColor(Gfx.COLOR_TRANSPARENT, Gfx.COLOR_BLACK);
        dc.clear();
    }
}