using Toybox.WatchUi;

class PauseTimerView extends WatchUi.SimpleDataField {
	
	hidden var accPauseTime = 0;
	hidden var isPaused = false;
	hidden var pauseTime = 0; 
	
    function initialize() {
        SimpleDataField.initialize();
        label = WatchUi.loadResource(Rez.Strings.field_label);
        
        accPauseTime = 0;
        isPaused = false;
        pauseTime = 0;
    }

    function compute(info) {
    	// info.timerState
    	// 0 - Not running (OFF)
    	// 1 - Stop (STOPPED)
    	// 2 - Pause (PAUSED)
    	// 3 - Running (ON)
    	
    	// Don't count if timer not running
    	if (info.timerState == info.TIMER_STATE_OFF) {
    		accPauseTime = 0;
    	}
        
        // save TS if pause begins
        if (info.timerState == info.TIMER_STATE_PAUSED && !isPaused) {
        	System.println("Pause: " + info.elapsedTime);
        	pauseTime = info.elapsedTime;
        	isPaused = true;
        }
        
        // calc diff between TS if pause ends
        if (isPaused && info.timerState != info.TIMER_STATE_PAUSED) {
        	System.println("Resume: " + info.elapsedTime);
        	accPauseTime += info.elapsedTime - pauseTime;
        	isPaused = false;
        }
        
		// calc pause if stand
		var currentPause = accPauseTime;
		if (isPaused) {
			currentPause += info.elapsedTime - pauseTime;
		}
        
        // calc min and sec
        var seconds = (currentPause / 1000) % 60;
        var minutes = currentPause / 1000 / 60;
        
        // format output
        return Lang.format("$1$:$2$",
    		[minutes.format("%02d"), seconds.format("%02d")]
		);
    }

}