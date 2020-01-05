using Toybox.Background;
using Toybox.System;
using Toybox.Position;
using Toybox.Time;
using Toybox.Communications;
using Toybox.Math;

(:background)
class CriticalMapsSenderWeb extends Toybox.System.ServiceDelegate {	

    function initialize() {
        System.ServiceDelegate.initialize();
    }

    function onTemporalEvent() {
        sendPositionData();
    }

    function sendPositionData() {	
        var callback = method(:callbackCM);
        return CriticalMapsAPI.sendPositionData(callback);
    }

    function callbackCM(responseCode, data) {
        var result = CriticalMapsAPI.callbackCM(responseCode, data);
        Background.exit(result);
    }
}

