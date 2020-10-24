using Toybox.Background;
using Toybox.System;
using Toybox.Position;
using Toybox.Time;
using Toybox.Communications;
using Toybox.Math;

using CriticalMapsAPIBarrel as CM;
using TraccarAPIBarrel as TC;

(:background)
class CriticalMapsSenderWeb extends Toybox.System.ServiceDelegate {	

    function initialize() {
        System.ServiceDelegate.initialize();
    }

    function onTemporalEvent() {
        sendPositionData();
    }

    function sendPositionData() {
        CM.sendPositionData(null);
        TC.sendPositionData(null);
    }
}
