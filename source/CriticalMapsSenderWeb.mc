using Toybox.Background;
using Toybox.System;
using Toybox.Position;
using Toybox.Time;
using Toybox.Communications;
using Toybox.Math;

using CriticalMapsAPIBarrel as CM;

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
        return CM.sendPositionData(callback);
    }

    function callbackCM(responseCode, data) {
        var result = CM.callbackCM(responseCode, data);
        Background.exit(result);
    }
}

