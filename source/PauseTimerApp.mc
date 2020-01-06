using Toybox.Application;
using Toybox.Background;
using Toybox.System;

using CriticalMapsAPIBarrel as CM;

class PauseTimerApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    // onStart() is called on application start up
    function onStart(state) {
    }

    // onStop() is called when your application is exiting
    function onStop(state) {
    }

    // Return the initial view of your application here
    function getInitialView() {
        CM.getDeviceId(); // Need to be intial set DeviceId with app+device uuid, not possible in background
        if(Toybox.System has :ServiceDelegate) {
            Background.registerForTemporalEvent(new Time.Duration(5 * 60));
        } else {
            System.println("****background not available on this device****");
        }
        return [ new PauseTimerView() ];
    }
    
    function getServiceDelegate(){
        var now=System.getClockTime();
        var ts=now.hour+":"+now.min.format("%02d");    
        System.println("getServiceDelegate: "+ts);
        return [new CriticalMapsSenderWeb()];
    }
}