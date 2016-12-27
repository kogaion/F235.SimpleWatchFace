using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Lang as Lang;
using Toybox.Application as App;

class F235SimpleWatchFaceView extends Ui.WatchFace
{
    hidden var drawables;

    function initialize()
    {
        WatchFace.initialize();
    }

    // The entry point for the View is onLayout(). This is called before the
    // View is shown to load resources and set up the layout of the View.
    // @param [Graphics.Dc] dc The drawing context
    // @return [Boolean] true if handled, false otherwise
    function onLayout(dc)
    {
        setLayout(Rez.Layouts.SimpleWatchFace(dc));
        me.drawables = [
            "Background",
            "Battery", "ClockTime", "CalendarDate",
            "StepsGoal", "Bluetooth", "Notifications"
        ];
    }

    // When the View is brought into the foreground, onShow() is called.
    // @return [Boolean] true if handled, false otherwise
    function onShow()
    {
        for (var i = 0; i < me.drawables.size(); i ++) {
            WatchFace.findDrawableById(me.drawables[i]).onReset();
        }
    }

    // When a View is active, onUpdate() is used to update dynamic content.
    // This function is called when the View is brought to the foreground.
    // For widgets and watch-apps it is also called when WatchUi.requestUpdate()
    // is called. For watchfaces it is called once a minute and for datafields
    // it is called once a second. If a class that extends View does not
    // implement this function then any Drawables contained in the View will
    // automatically be drawn.
    // @param [Graphics.Dc] dc The drawing context
    // @return [Boolean] true if handled, false otherwise
    function onUpdate(dc)
    {
        for (var i = 0; i < me.drawables.size(); i ++) {
            WatchFace.findDrawableById(me.drawables[i]).draw(dc);
        }
    }

    // Before the View is removed from the foreground, onHide() is called.
    function onHide()
    {
    }

    // The user has just looked at their watch. Timers and animations may be started here.
    function onExitSleep()
    {
    }

    // Terminate any active timers and prepare for slow updates.
    function onEnterSleep()
    {
    }

}
