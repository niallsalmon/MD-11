# McDonnell Douglas MD-11 AFS
# Based off IT-AUTOFLIGHT System Controller V4.0.X
# Copyright (c) 2021 Josh Davidson (Octal450)
# This file DOES NOT integrate with Property Tree Setup
# That way, we can update it from generic IT-AUTOFLIGHT easily

# Initialize all used variables and property nodes
# Sim
var Controls = {
	aileron: props.globals.getNode("/controls/flight/aileron", 1), # Not written to, so lets use actual yoke value
	elevator: props.globals.getNode("/controls/flight/elevator", 1), # Not written to, so lets use actual yoke value
	rudder: props.globals.getNode("/controls/flight/rudder", 1),
};

var Engines = {
	reverserNorm: [props.globals.getNode("/engines/engine[0]/reverser-pos-norm", 1), props.globals.getNode("/engines/engine[1]/reverser-pos-norm", 1), props.globals.getNode("/engines/engine[2]/reverser-pos-norm", 1)],
};

var FPLN = {
	active: props.globals.getNode("/autopilot/route-manager/active", 1),
	activeTemp: 0,
	currentCourse: 0,
	currentWp: props.globals.getNode("/autopilot/route-manager/current-wp", 1),
	currentWpTemp: 0,
	deltaAngle: 0,
	deltaAngleRad: 0,
	distCoeff: 0,
	maxBank: 0,
	maxBankLimit: 0,
	nextCourse: 0,
	num: props.globals.getNode("/autopilot/route-manager/route/num", 1),
	numTemp: 0,
	R: 0,
	radius: 0,
	turnDist: 0,
	wp0Dist: props.globals.getNode("/autopilot/route-manager/wp/dist", 1),
	wpFlyFrom: 0,
	wpFlyTo: 0,
};

var Gear = {
	wow0: props.globals.getNode("/gear/gear[0]/wow", 1),
	wow0Timer: props.globals.getNode("/gear/gear[0]/wow-timer", 1),
	wow1: props.globals.getNode("/gear/gear[1]/wow", 1),
	wow1Temp: 1,
	wow2: props.globals.getNode("/gear/gear[2]/wow", 1),
	wow2Temp: 1,
};

var Misc = {
	elapsedSec: props.globals.getNode("/sim/time/elapsed-sec", 1),
	flapDeg: props.globals.getNode("/fdm/jsbsim/fcs/flap-pos-deg", 1),
	pfdHeadingScale: props.globals.getNode("/instrumentation/pfd/heading-scale", 1),
	pfdHeadingScaleTemp: 0,
	rollDeg: props.globals.getNode("/orientation/roll-deg", 1),
	state1: props.globals.getNode("/engines/engine[0]/state", 1),
	state2: props.globals.getNode("/engines/engine[1]/state", 1),
	state3: props.globals.getNode("/engines/engine[2]/state", 1),
};

var Position = {
	gearAglFtTemp: 0,
	gearAglFt: props.globals.getNode("/position/gear-agl-ft", 1),
	indicatedAltitudeFt: props.globals.getNode("/instrumentation/altimeter/indicated-altitude-ft", 1),
	indicatedAltitudeFtTemp: 0,
};

var Radio = {
	gsDefl: [props.globals.getNode("/instrumentation/nav[0]/gs-needle-deflection-norm", 1), props.globals.getNode("/instrumentation/nav[1]/gs-needle-deflection-norm", 1), props.globals.getNode("/instrumentation/nav[2]/gs-needle-deflection-norm", 1)],
	gsDeflTemp: 0,
	inRange: [props.globals.getNode("/instrumentation/nav[0]/in-range", 1), props.globals.getNode("/instrumentation/nav[1]/in-range", 1), props.globals.getNode("/instrumentation/nav[2]/in-range", 1)],
	inRangeTemp: 0,
	locDefl: [props.globals.getNode("/instrumentation/nav[0]/heading-needle-deflection-norm", 1), props.globals.getNode("/instrumentation/nav[1]/heading-needle-deflection-norm", 1), props.globals.getNode("/instrumentation/nav[2]/heading-needle-deflection-norm", 1)],
	locDeflTemp: 0,
	radioSel: 0,
	signalQuality: [props.globals.getNode("/instrumentation/nav[0]/signal-quality-norm", 1), props.globals.getNode("/instrumentation/nav[1]/signal-quality-norm", 1), props.globals.getNode("/instrumentation/nav[2]/signal-quality-norm", 1)],
	signalQualityTemp: 0,
};

var Velocities = {
	athrMax: 365,
	athrMaxMach: 0.87,
	athrMin: 0,
	athrMinMach: 0.5,
	groundspeedKt: props.globals.getNode("/velocities/groundspeed-kt", 1),
	groundspeedMps: 0,
	indicatedAirspeedKt: props.globals.getNode("/instrumentation/airspeed-indicator/indicated-speed-kt", 1),
	indicatedAirspeedKtTemp: 0,
	indicatedAirspeedKt5Sec: props.globals.getNode("/it-autoflight/internal/kts-predicted-5", 1),
	indicatedMach: props.globals.getNode("/instrumentation/airspeed-indicator/indicated-mach", 1),
	indicatedMach5Sec: props.globals.getNode("/it-autoflight/internal/mach-predicted-5", 1),
	vmax: 365,
	vmin: 0,
};

# IT-AUTOFLIGHT
var Fd = {
	pitchBar: props.globals.initNode("/it-autoflight/fd/pitch-bar", 0, "DOUBLE"),
	rollBar: props.globals.initNode("/it-autoflight/fd/roll-bar", 0, "DOUBLE"),
};

var Input = {
	alt: props.globals.initNode("/it-autoflight/input/alt", 10000, "INT"),
	altTemp: 1000,
	ap1: props.globals.initNode("/it-autoflight/input/ap1", 0, "BOOL"),
	ap2: props.globals.initNode("/it-autoflight/input/ap2", 0, "BOOL"),
	athr: props.globals.initNode("/it-autoflight/input/athr", 0, "BOOL"),
	altDiff: 0,
	bankLimitSw: props.globals.initNode("/it-autoflight/input/bank-limit-sw", 0, "INT"),
	bankLimitSwTemp: 0,
	fd1: props.globals.initNode("/it-autoflight/input/fd1", 1, "BOOL"),
	fd2: props.globals.initNode("/it-autoflight/input/fd2", 1, "BOOL"),
	fpa: props.globals.initNode("/it-autoflight/input/fpa", 0, "DOUBLE"),
	fpaAbs: props.globals.initNode("/it-autoflight/input/fpa-abs", 0, "DOUBLE"), # Set by property rule
	hdg: props.globals.initNode("/it-autoflight/input/hdg", 0, "INT"),
	hdgTemp: 0,
	kts: props.globals.initNode("/it-autoflight/input/kts", 250, "INT"),
	ktsTemp: 0,
	ktsMach: props.globals.initNode("/it-autoflight/input/kts-mach", 0, "BOOL"),
	ktsMachTemp: 0,
	lat: props.globals.initNode("/it-autoflight/input/lat", 5, "INT"),
	latTemp: 5,
	ovrd1: props.globals.initNode("/it-autoflight/input/ovrd1", 0, "BOOL"),
	ovrd1Temp: 0,
	ovrd2: props.globals.initNode("/it-autoflight/input/ovrd2", 0, "BOOL"),
	ovrd2Temp: 0,
	mach: props.globals.initNode("/it-autoflight/input/mach", 0.5, "DOUBLE"),
	machTemp: 0,
	toga: props.globals.initNode("/it-autoflight/input/toga", 0, "BOOL"),
	trk: props.globals.initNode("/it-autoflight/input/trk", 0, "BOOL"),
	trkTemp: 0,
	trueCourse: props.globals.initNode("/it-autoflight/input/true-course", 0, "BOOL"),
	radioSel: props.globals.initNode("/it-autoflight/input/radio-sel", 2, "INT"),
	vs: props.globals.initNode("/it-autoflight/input/vs", 0, "INT"),
	vsAbs: props.globals.initNode("/it-autoflight/input/vs-abs", 0, "INT"), # Set by property rule
	vert: props.globals.initNode("/it-autoflight/input/vert", 7, "INT"),
	vertTemp: 7,
};

var Internal = {
	activeFms: props.globals.initNode("/it-autoflight/internal/active-fms", 1, "INT"),
	activeFmsTemp: 1,
	alt: props.globals.initNode("/it-autoflight/internal/alt", 10000, "INT"),
	altAlert: props.globals.initNode("/it-autoflight/internal/alt-alert", 0, "BOOL"),
	altAlertAural: props.globals.initNode("/it-autoflight/internal/alt-alert-aural", 0, "BOOL"),
	altCaptureActive: 0,
	altDiff: 0,
	altTemp: 10000,
	altPredicted: props.globals.initNode("/it-autoflight/internal/altitude-predicted", 0, "DOUBLE"),
	bankLimit: props.globals.initNode("/it-autoflight/internal/bank-limit", 25, "DOUBLE"),
	bankLimitAuto: 0,
	bankLimitCalc: 25,
	bankLimitMax: [25, 5, 10, 15, 20, 25],
	canAutoland: 0,
	captVs: 0,
	driftAngle: props.globals.initNode("/it-autoflight/internal/drift-angle-deg", 0, "DOUBLE"),
	enableAthrOff: 0,
	flchActive: 0,
	fpa: props.globals.initNode("/it-autoflight/internal/fpa", 0, "DOUBLE"),
	hdg: props.globals.initNode("/it-autoflight/internal/hdg", 0, "INT"),
	hdgCalc: 0,
	hdgSet: 0,
	kts: props.globals.initNode("/it-autoflight/internal/kts", 250, "INT"),
	ktsMach: props.globals.initNode("/it-autoflight/internal/kts-mach", 0, "BOOL"),
	ktsTemp: 250,
	hdgPredicted: props.globals.initNode("/it-autoflight/internal/heading-predicted", 0, "DOUBLE"),
	landCondition: 0,
	landModeActive: 0,
	lnavAdvanceNm: props.globals.initNode("/it-autoflight/internal/lnav-advance-nm", 0, "DOUBLE"),
	lnavEngageFt: 100,
	mach: props.globals.initNode("/it-autoflight/internal/mach", 0.5, "DOUBLE"),
	machTemp: 0.5,
	minVs: props.globals.initNode("/it-autoflight/internal/min-vs", -500, "INT"),
	maxVs: props.globals.initNode("/it-autoflight/internal/max-vs", 500, "INT"),
	navCourseTrackErrorDeg: props.globals.initNode("/it-autoflight/internal/nav-course-track-error-deg", 0, "DOUBLE"),
	retardLock: 0,
	selfCheckStatus: 0,
	selfCheckTime: 0,
	spdProtOnPitch: 0,
	syncedAlt: 0,
	syncedHdg: 0,
	syncedSpd: 0,
	targetHdgError: 0,
	targetKts: 0,
	targetKtsError: 0,
	throttleSaturated: props.globals.initNode("/it-autoflight/internal/throttle-saturated", 0, "INT"),
	throttleSaturatedTemp: 0,
	v2Speed: 0,
	v2Toggle: 0,
	vs: props.globals.initNode("/it-autoflight/internal/vert-speed-fpm", 0, "DOUBLE"),
	vsTemp: 0,
};

var Output = {
	ap1: props.globals.initNode("/it-autoflight/output/ap1", 0, "BOOL"),
	ap1Avail: props.globals.initNode("/it-autoflight/output/ap1-available", 0, "BOOL"),
	ap1Temp: 0,
	ap2: props.globals.initNode("/it-autoflight/output/ap2", 0, "BOOL"),
	ap2Avail: props.globals.initNode("/it-autoflight/output/ap2-available", 0, "BOOL"),
	ap2Temp: 0,
	apprArm: props.globals.initNode("/it-autoflight/output/appr-armed", 0, "BOOL"),
	athr: props.globals.initNode("/it-autoflight/output/athr", 0, "BOOL"),
	athrTemp: 0,
	athrAvail: props.globals.initNode("/it-autoflight/output/athr-available", 0, "BOOL"),
	clamp: props.globals.getNode("/it-autoflight/output/clamp"),
	fd1: props.globals.initNode("/it-autoflight/output/fd1", 1, "BOOL"),
	fd1Temp: 0,
	fd2: props.globals.initNode("/it-autoflight/output/fd2", 1, "BOOL"),
	fd2Temp: 0,
	hdgCaptured: 1,
	lat: props.globals.initNode("/it-autoflight/output/lat", 5, "INT"),
	latTemp: 5,
	lnavArm: props.globals.initNode("/it-autoflight/output/lnav-armed", 0, "BOOL"),
	locArm: props.globals.initNode("/it-autoflight/output/loc-armed", 0, "BOOL"),
	showHdg: props.globals.initNode("/it-autoflight/output/show-hdg", 1, "BOOL"),
	spdCaptured: 1,
	spdProt: props.globals.initNode("/it-autoflight/output/spd-prot", 0, "INT"),
	spdProtTemp: 0,
	thrMode: props.globals.initNode("/it-autoflight/output/thr-mode", 2, "INT"),
	vert: props.globals.initNode("/it-autoflight/output/vert", 7, "INT"),
	vertTemp: 7,
	vsFpa: props.globals.initNode("/it-autoflight/output/vs-fpa", 0, "BOOL"),
};

var Settings = {
	reducAglFt: props.globals.initNode("/it-autoflight/settings/reduc-agl-ft", 1000, "INT"), # Will be changable from FMS
};

var Sound = {
	apOff: props.globals.getNode("/it-autoflight/sound/apoff"),
	enableApOff: 0,
};

var Text = {
	land: props.globals.initNode("/it-autoflight/mode/land", "OFF", "STRING"),
	lat: props.globals.initNode("/it-autoflight/mode/lat", "T/O", "STRING"),
	latTemp: "T/O",
	thr: props.globals.initNode("/it-autoflight/mode/thr", "PITCH", "STRING"),
	vert: props.globals.initNode("/it-autoflight/mode/vert", "T/O CLB", "STRING"),
	vertTemp: "T/O CLB",
};

var Warning = {
	ap: props.globals.initNode("/it-autoflight/warning/ap", 0, "BOOL"),
	atsFlash: props.globals.initNode("/it-autoflight/warning/atsflash", 0, "BOOL"),
	ats: props.globals.initNode("/it-autoflight/warning/ats", 0, "BOOL"),
};

var ITAF = {
	init: func(t = 0) { # Not everything should be reset if the reset is type 1
		if (t != 1) {
			Input.alt.setValue(10000);
			Input.bankLimitSw.setValue(0);
			Input.ktsMach.setBoolValue(0);
			Input.kts.setValue(250);
			Input.mach.setValue(0.5);
			Input.hdg.setValue(0);
			Input.trk.setBoolValue(0);
			Input.trueCourse.setBoolValue(0);
			Internal.alt.setValue(10000);
			Internal.hdg.setValue(0);
			Input.ovrd1.setBoolValue(0);
			Input.ovrd2.setBoolValue(0);
			Output.vsFpa.setBoolValue(0);
		}
		Internal.ktsMach.setBoolValue(0);
		Input.ap1.setBoolValue(0);
		Input.ap2.setBoolValue(0);
		Input.athr.setBoolValue(0);
		if (t != 1) {
			Input.fd1.setBoolValue(1);
			Input.fd2.setBoolValue(1);
		}
		Input.vs.setValue(0);
		Input.fpa.setValue(0);
		Input.lat.setValue(5);
		Input.vert.setValue(7);
		Input.toga.setBoolValue(0);
		Input.radioSel.setValue(2);
		Output.ap1.setBoolValue(0);
		Output.ap2.setBoolValue(0);
		Output.athr.setBoolValue(0);
		if (t != 1) {
			Output.fd1.setBoolValue(1);
			Output.fd2.setBoolValue(1);
		}
		Output.lnavArm.setBoolValue(0);
		Output.locArm.setBoolValue(0);
		Output.apprArm.setBoolValue(0);
		Output.thrMode.setValue(2);
		Output.lat.setValue(5);
		Output.vert.setValue(7);
		Output.spdProt.setValue(0);
		Internal.spdProtOnPitch = 0;
		Internal.minVs.setValue(-500);
		Internal.maxVs.setValue(500);
		Internal.altCaptureActive = 0;
		Internal.kts.setValue(fms.Speeds.v2.getValue());
		Internal.mach.setValue(0.5);
		me.updateActiveFms(1);
		Text.thr.setValue("PITCH");
		updateFma.arm();
		me.updateLatText("T/O");
		me.updateVertText("T/O CLB");
		Internal.retardLock = 0;
		Text.land.setValue("OFF");
		Output.spdCaptured = 1;
		Output.hdgCaptured = 1;
		Output.showHdg.setBoolValue(1);
		if (t != 1) {
			Sound.apOff.setBoolValue(0);
			Warning.ap.setBoolValue(0);
			Warning.atsFlash.setBoolValue(0);
			Warning.ats.setBoolValue(0);
			Sound.enableApOff = 0;
			Internal.enableAthrOff = 0;
			apKill.stop();
			atsKill.stop();
		}
		loopTimer.start();
		slowLoopTimer.start();
		clampLoop.start();
	},
	loop: func() {
		Output.latTemp = Output.lat.getValue();
		Output.vertTemp = Output.vert.getValue();
		
		# VOR/ILS Revision
		if (Output.latTemp == 2 or Output.vertTemp == 2 or Output.vertTemp == 6) {
			me.checkRadioRevision(Output.latTemp, Output.vertTemp);
		}
		
		Gear.wow1Temp = Gear.wow1.getBoolValue();
		Gear.wow2Temp = Gear.wow2.getBoolValue();
		Output.ap1Temp = Output.ap1.getBoolValue();
		Output.ap2Temp = Output.ap2.getBoolValue();
		Output.athrTemp = Output.athr.getBoolValue();
		Output.latTemp = Output.lat.getValue();
		Output.vertTemp = Output.vert.getValue();
		Text.vertTemp = Text.vert.getValue();
		Position.gearAglFtTemp = Position.gearAglFt.getValue();
		Internal.vsTemp = Internal.vs.getValue();
		Position.indicatedAltitudeFtTemp = Position.indicatedAltitudeFt.getValue();
		Velocities.indicatedAirspeedKtTemp = Velocities.indicatedAirspeedKt.getValue();
		
		# Kill when power lost
		if (systems.ELEC.Bus.dc1.getValue() < 24 or systems.ELEC.Bus.dc2.getValue() < 24 or systems.ELEC.Bus.dc3.getValue() < 24) {
			if (Output.ap1Temp or Output.ap2Temp) {
				me.killAFSSilent();
			}
			if (Output.athrTemp) {
				me.killATSSilent();
			}
		}
		
		# Kill Autoland if AP is turned off
		if (!Output.ap1Temp and !Output.ap2Temp) {
			if (Output.latTemp == 4) {
				me.activateLoc();
			}
			if (Output.vertTemp == 6) {
				me.activateGs();
			}
		}
		
		# Update LNAV engage altitude
		if (Output.ap1Temp or Output.ap2Temp) {
			Internal.lnavEngageFt = 400;
		} else {
			Internal.lnavEngageFt = 100;
		}
		
		# LNAV Engagement
		if (Output.lnavArm.getBoolValue()) {
			me.checkLnav(1);
		}
		
		# VOR/LOC or ILS/LOC Capture
		if (Output.locArm.getBoolValue()) {
			me.checkLoc(1);
		}
		
		# G/S Capture
		if (Output.apprArm.getBoolValue()) {
			me.checkAppr(1);
		}
		
		# Autoland Logic
		if (Output.latTemp == 2) {
			if (Position.gearAglFtTemp <= 150) {
				if (Output.ap1Temp or Output.ap2Temp) {
					me.setLatMode(4);
				}
			}
		}
		if (Output.vertTemp == 2) {
			if (Position.gearAglFtTemp <= 100 and Position.gearAglFtTemp >= 5) {
				if (Output.ap1Temp or Output.ap2Temp) {
					me.setVertMode(6);
				}
			}
		} else if (Output.vertTemp == 6) {
			if (!Output.ap1Temp and !Output.ap2Temp) {
				me.activateLoc();
				me.activateGs();
			} else {
				if (Position.gearAglFtTemp <= 50 and Position.gearAglFtTemp >= 5 and Text.vert.getValue() != "FLARE") {
					me.updateVertText("FLARE");
				}
				if (Gear.wow1Temp and Gear.wow2Temp and Text.vert.getValue() != "ROLLOUT") {
					me.updateLatText("RLOU");
					me.updateVertText("ROLLOUT");
				}
			}
		}
		
		# FLCH Engagement
		if (Text.vertTemp == "T/O CLB") {
			if (Velocities.indicatedAirspeedKtTemp >= 30) { # Temporary until MCDU handles it
				if (!Gear.wow1Temp and !Gear.wow2Temp and Internal.v2Toggle != 1) {
					Internal.v2Toggle = 1;
					if (pts.Fdm.JSBsim.Libraries.anyEngineOut.getBoolValue()) {
						Internal.kts.setValue(math.clamp(math.round(Velocities.indicatedAirspeedKtTemp), Internal.v2Speed, Internal.v2Speed + 10));
					} else {
						Internal.kts.setValue(Internal.v2Speed + 10);
					}
				}
			} else {
				Internal.v2Toggle = 0;
				Internal.v2Speed = math.round(fms.Speeds.v2.getValue());
				Internal.kts.setValue(Internal.v2Speed);
			}
			
			me.checkFlch(Settings.reducAglFt.getValue());
		}
		
		# Altitude Capture/Sync Logic
		Input.altTemp = Input.alt.getValue();
		if (Output.vertTemp != 0) {
			Internal.alt.setValue(Input.altTemp);
		}
		Internal.altTemp = Internal.alt.getValue();
		Internal.altDiff = Internal.altTemp - Position.indicatedAltitudeFtTemp;
		
		if (Output.vertTemp != 0 and Output.vertTemp != 2 and Output.vertTemp != 6 and Output.spdProt.getValue() == 0) {
			Internal.captVs = math.clamp(math.round(abs(Internal.vs.getValue()) / 5, 100), 50, 2500); # Capture limits
			if (abs(Internal.altDiff) <= Internal.captVs and !Gear.wow1Temp and !Gear.wow2Temp) {
				if (Internal.altTemp >= Position.indicatedAltitudeFtTemp and Internal.vsTemp >= -25) { # Don't capture if we are going the wrong way
					me.setVertMode(3);
				} else if (Internal.altTemp < Position.indicatedAltitudeFtTemp and Internal.vsTemp <= 25) { # Don't capture if we are going the wrong way
					me.setVertMode(3);
				}
			}
		}
		
		# Altitude Hold Min/Max Reset
		if (Internal.altCaptureActive) {
			if (abs(Internal.altDiff) <= 25 and Text.vert.getValue() != "ALT HLD") {
				me.resetClimbRateLim();
				me.updateVertText("ALT HLD");
			}
		}
		
		# Altitude Alert
		Text.vertTemp = Text.vert.getValue();
		if (Output.vertTemp != 2 and Output.vertTemp != 6 and Misc.flapDeg.getValue() < 31.5 and ((Output.vertTemp == 7 and Position.indicatedAltitudeFtTemp >= 400) or (Output.vertTemp != 7 and Position.indicatedAltitudeFtTemp >= 100))) {
			if (abs(Internal.altDiff) >= 150 and Text.vertTemp == "ALT HLD") {
				Internal.altAlert.setBoolValue(1);
			} else if (abs(Internal.altDiff) >= 150 and abs(Internal.altDiff) <= 1000 and Text.vertTemp != "ALT HLD") {
				Internal.altAlert.setBoolValue(1);
			} else {
				Internal.altAlert.setBoolValue(0);
			}
		} else {
			Internal.altAlert.setBoolValue(0);
		}
		
		if (abs(Internal.altDiff) > 1050) {
			Internal.altAlertAural.setBoolValue(1);
		} else if (abs(Internal.altDiff) < 950 and !Internal.altAlert.getBoolValue()) {
			Internal.altAlertAural.setBoolValue(0);
		}
		
		# Thrust Mode Selector
		me.updateThrustMode();
		
		# Bank Limits
		me.bankLimit();
		
		# Speed Capture + ATS Speed Limits
		Velocities.athrMax = fms.Speeds.athrMax.getValue();
		Velocities.athrMaxMach = fms.Speeds.athrMaxMach.getValue();
		Velocities.athrMin = fms.Speeds.athrMin.getValue();
		Velocities.athrMinMach = fms.Speeds.athrMinMach.getValue();
		Input.ktsMachTemp = Input.ktsMach.getBoolValue();
		Input.ktsTemp = Input.kts.getValue();
		Input.machTemp = Input.mach.getValue();
		Internal.ktsTemp = Internal.kts.getValue();
		Internal.machTemp = Internal.mach.getValue();
		
		if (!Output.spdCaptured) {
			if (Input.ktsMachTemp) {
				Internal.mach.setValue(math.clamp(Input.machTemp, Velocities.athrMinMach, Velocities.athrMaxMach));
				Internal.targetKts = Internal.mach.getValue() * (Velocities.indicatedAirspeedKt.getValue() / Velocities.indicatedMach.getValue()); # Convert to Knots
			} else {
				Internal.kts.setValue(math.clamp(Input.ktsTemp, Velocities.athrMin, Velocities.athrMax));
				Internal.targetKts = Internal.kts.getValue();
			}
			Internal.targetKtsError = Internal.targetKts - Velocities.indicatedAirspeedKt5Sec.getValue();
			if (abs(Internal.targetKtsError) <= 2.5) {
				Output.spdCaptured = 1;
			}
		} else if (!Gear.wow1Temp and !Gear.wow2Temp) {
			if (Internal.ktsMach.getBoolValue()) {
				if (Internal.machTemp > Velocities.athrMaxMach) {
					Internal.mach.setValue(Velocities.athrMaxMach);
				} else if (Internal.machTemp < Velocities.athrMinMach) {
					Internal.mach.setValue(Velocities.athrMinMach);
				}
			} else {
				if (Internal.ktsTemp > Velocities.athrMax) {
					Internal.kts.setValue(Velocities.athrMax);
				} else if (Internal.ktsTemp < Velocities.athrMin) {
					Internal.kts.setValue(Velocities.athrMin);
				}
			}
		} # Refresh Internal.ktsTemp and Internal.machTemp if using past this point
		
		# Heading Sync
		if (!Output.showHdg.getBoolValue()) {
			Misc.pfdHeadingScaleTemp = Misc.pfdHeadingScale.getValue();
			Internal.hdg.setValue(Misc.pfdHeadingScaleTemp);
			Input.hdg.setValue(Misc.pfdHeadingScaleTemp);
		}
		
		# Heading Capture
		Input.hdgTemp = Input.hdg.getValue();
		if (Output.latTemp == 0) {
			if (!Output.hdgCaptured) {
				Internal.hdg.setValue(Input.hdgTemp);
				Internal.targetHdgError = Internal.hdg.getValue() - Internal.hdgPredicted.getValue();
				if (abs(Internal.targetHdgError) <= 2.5) {
					Output.hdgCaptured = 1;
				}
			}
		} else if (!Output.hdgCaptured) {
			Output.hdgCaptured = 1;
		}
		
		# Synced Logic - Make sure Temp is refreshed when you compare here
		if (Input.altTemp == Internal.altTemp) { # Internal.altTemp is already updated after the syncing logic sets it
			Internal.syncedAlt = 1;
		} else {
			Internal.syncedAlt = 0;
		}
		if (Input.hdgTemp == Internal.hdg.getValue() and Output.latTemp == 0) {
			Internal.syncedHdg = 1;
		} else {
			Internal.syncedHdg = 0;
		}
		if (Input.ktsMachTemp == Internal.ktsMach.getBoolValue()) {
			if (Input.ktsMachTemp) {
				if (Input.machTemp == Internal.mach.getValue()) {
					Internal.syncedSpd = 1;
				} else {
					Internal.syncedSpd = 0;
				}
			} else {
				if (Input.ktsTemp == Internal.kts.getValue()) {
					Internal.syncedSpd = 1;
				} else {
					Internal.syncedSpd = 0;
				}
			}
		} else {
			Internal.syncedSpd = 0;
		}
		
		# Autoland Logic
		if (Output.vertTemp == 2 or Output.vertTemp == 6) {
			Radio.radioSel = Input.radioSel.getValue();
			Radio.locDeflTemp = Radio.locDefl[Radio.radioSel].getValue();
			Radio.signalQualityTemp = Radio.signalQuality[Radio.radioSel].getValue();
			Internal.canAutoland = (abs(Radio.locDeflTemp) <= 0.1 and Radio.locDeflTemp != 0 and Radio.signalQualityTemp >= 0.99) or Gear.wow0.getBoolValue();
		} else {
			Internal.canAutoland = 0;
		}
		Internal.landModeActive = (Output.latTemp == 2 or Output.latTemp == 4) and (Output.vertTemp == 2 or Output.vertTemp == 6);
		
		if (Position.gearAglFtTemp <= 1500 and Internal.landModeActive) {
			Internal.selfCheckStatus = 1;
		} else if (!Internal.landModeActive) {
			Internal.selfCheckStatus = 0;
		}
		
		if (Internal.selfCheckStatus == 1) {
			if (Internal.selfCheckStatus != 2 and Internal.selfCheckTime + 10 < Misc.elapsedSec.getValue()) {
				Internal.selfCheckStatus = 2;
			}
		} else {
			Internal.selfCheckTime = Misc.elapsedSec.getValue();
		}
		
		if (Internal.canAutoland and Internal.landModeActive and Internal.selfCheckStatus == 2) {
			if ((Output.ap1Temp or Output.ap2Temp) and Output.ap1Avail.getBoolValue() and Output.ap2Avail.getBoolValue() and (Output.athr.getBoolValue() or Text.thr.getValue() == "RETARD") and Position.gearAglFtTemp <= 1500) {
				Internal.landCondition = "DUAL";
			} else if (Output.ap1Temp or Output.ap2Temp and Position.gearAglFtTemp <= 1500) {
				Internal.landCondition = "SINGLE";
			} else if (Output.fd1.getBoolValue() or Output.fd2.getBoolValue()) {
				Internal.landCondition = "APPR";
			} else {
				Internal.landCondition = "OFF";
			}
		} else {
			Internal.landCondition = "OFF";
		}
		
		if (Internal.landCondition != Text.land.getValue()) {
			Text.land.setValue(Internal.landCondition);
		}
		
		# Trip system off
		if (Output.ap1Temp or Output.ap2Temp) { 
			if (abs(Controls.aileron.getValue()) >= 0.2 or abs(Controls.elevator.getValue()) >= 0.2) {
				me.ap1Master(0);
				me.ap2Master(0);
			}
		}
		if (!Output.ap1Avail.getBoolValue() and Output.ap1Temp) {
			me.ap1Master(0);
		}
		if (!Output.ap2Avail.getBoolValue() and Output.ap2Temp) {
			me.ap2Master(0);
		}
		if (!Output.athrAvail.getBoolValue() and Output.athrTemp) {
			if (Engines.reverserNorm[0].getValue() >= 0.01 or Engines.reverserNorm[1].getValue() >= 0.01 or Engines.reverserNorm[2].getValue() >= 0.01) { # Silently kill ATS only if a reverser is deployed
				me.killATSSilent();
			} else {
				me.athrMaster(0);
			}
		}
		
		if (Internal.landCondition != "DUAL" and Internal.landCondition != "SINGLE" and Text.vert.getValue() != "G/A CLB") {
			if (Position.gearAglFtTemp < 400 and Output.latTemp == 1) { # NAV trips at 400ft
				if (Output.ap1Temp) {
					me.ap1Master(0);
				}
				if (Output.ap2Temp) {
					me.ap2Master(0);
				}
			} else if (Position.gearAglFtTemp < 100 and Output.latTemp != 1) {
				if (Output.ap1Temp) {
					me.ap1Master(0);
				}
				if (Output.ap2Temp) {
					me.ap2Master(0);
				}
			}
		}
	},
	slowLoop: func() {
		FPLN.activeTemp = FPLN.active.getValue();
		FPLN.currentWpTemp = FPLN.currentWp.getValue();
		FPLN.numTemp = FPLN.num.getValue();
		
		# If in LNAV mode and route is not longer active, or IRUs unaligned, switch to HDG HLD
		if (Output.lat.getValue() == 1) { # Only evaulate the rest of the condition if we are in LNAV mode
			if (FPLN.num.getValue() == 0 or !FPLN.active.getBoolValue() or !systems.IRS.Iru.anyAligned.getBoolValue()) {
				me.setLatMode(3);
			}
		}
		
		# Waypoint Advance Logic
		if (FPLN.numTemp > 0 and FPLN.activeTemp == 1) {
			if ((FPLN.currentWpTemp + 1) < FPLN.numTemp) {
				Velocities.groundspeedMps = Velocities.groundspeedKt.getValue() * 0.5144444444444;
				FPLN.wpFlyFrom = FPLN.currentWpTemp;
				if (FPLN.wpFlyFrom < 0) {
					FPLN.wpFlyFrom = 0;
				}
				FPLN.currentCourse = getprop("/autopilot/route-manager/route/wp[" ~ FPLN.wpFlyFrom ~ "]/leg-bearing-true-deg"); # Best left at getprop
				FPLN.wpFlyTo = FPLN.currentWpTemp + 1;
				if (FPLN.wpFlyTo < 0) {
					FPLN.wpFlyTo = 0;
				}
				FPLN.nextCourse = getprop("/autopilot/route-manager/route/wp[" ~ FPLN.wpFlyTo ~ "]/leg-bearing-true-deg"); # Best left at getprop
				FPLN.maxBankLimit = Internal.bankLimit.getValue();

				FPLN.deltaAngle = math.abs(geo.normdeg180(FPLN.currentCourse - FPLN.nextCourse));
				FPLN.maxBank = FPLN.deltaAngle * 1.5;
				if (FPLN.maxBank > FPLN.maxBankLimit) {
					FPLN.maxBank = FPLN.maxBankLimit;
				}
				FPLN.radius = (Velocities.groundspeedMps * Velocities.groundspeedMps) / (9.81 * math.tan(FPLN.maxBank / 57.2957795131));
				FPLN.deltaAngleRad = (180 - FPLN.deltaAngle) / 114.5915590262;
				FPLN.R = FPLN.radius / math.sin(FPLN.deltaAngleRad);
				FPLN.distCoeff = FPLN.deltaAngle * -0.011111 + 2;
				if (FPLN.distCoeff < 1) {
					FPLN.distCoeff = 1;
				}
				FPLN.turnDist = math.cos(FPLN.deltaAngleRad) * FPLN.R * FPLN.distCoeff / 1852;
				if (Gear.wow0.getBoolValue() and FPLN.turnDist < 1) {
					FPLN.turnDist = 1;
				}
				Internal.lnavAdvanceNm.setValue(FPLN.turnDist);
				
				if (FPLN.wp0Dist.getValue() <= FPLN.turnDist and flightplan().getWP(FPLN.currentWp.getValue()).fly_type == "flyBy") { # Don't care unless we are flyBy-ing
					FPLN.currentWp.setValue(FPLN.currentWpTemp + 1);
				}
			}
		}
		
		# Reset system once flight complete
		if (!Output.ap1.getBoolValue() and !Output.ap2.getBoolValue() and Gear.wow0.getBoolValue() and Velocities.groundspeedKt.getValue() < 60 and Output.vert.getValue() != 7) { # Not in T/O or G/A
			fms.CORE.resetFMS();
		}
		
		# Speed Protection
		Velocities.vmax = fms.Speeds.vmax.getValue();
		Velocities.vmin = fms.Speeds.vminTape.getValue();
		Internal.throttleSaturatedTemp = Internal.throttleSaturated.getValue();
		Output.spdProtTemp = Output.spdProt.getValue();
		Output.vertTemp = Output.vert.getValue();
		
		if (me.spdProtAllowed()) {
			if (Output.athrAvail.getBoolValue()) { # A/THR Available
				if (Output.vertTemp != 0 and (Velocities.indicatedAirspeedKtTemp >= Velocities.vmax + 10 or (Velocities.indicatedAirspeedKtTemp >= Velocities.vmax + 5 and Internal.throttleSaturatedTemp == 1 and Output.spdProtTemp == 0))) { # High Speed Prot
					Output.spdProt.setValue(2);
					Internal.spdProtOnPitch = 1;
					me.setVertMode(4);
					if (!Output.athr.getBoolValue()) {
						me.athrMaster(1);
					}
				} else if (Output.vertTemp != 0 and (Velocities.indicatedAirspeedKtTemp <= Velocities.vmin - 10 or (Velocities.indicatedAirspeedKtTemp <= Velocities.vmin - 5 and Internal.throttleSaturatedTemp == 2 and Output.spdProtTemp == 0))) { # Low Speed Prot
					Output.spdProt.setValue(1);
					Internal.spdProtOnPitch = 1;
					me.setVertMode(4);
					if (!Output.athr.getBoolValue()) {
						me.athrMaster(1);
					}
				} else if (Velocities.indicatedAirspeedKtTemp >= Velocities.vmax + 5 and !Internal.spdProtOnPitch) {
					Output.spdProt.setValue(2);
					if (Output.vertTemp != 0 and Output.vertTemp != 1 and Output.vertTemp != 5) {
						me.setBasicMode(1); # Pitch mode only, no ALT
					}
					if (!Output.athr.getBoolValue()) {
						me.athrMaster(1);
					}
				} else if (Velocities.indicatedAirspeedKtTemp <= Velocities.vmin - 5 and !Internal.spdProtOnPitch) {
					Output.spdProt.setValue(1);
					if (Output.vertTemp != 0 and Output.vertTemp != 1 and Output.vertTemp != 5) {
						me.setBasicMode(1); # Pitch mode only, no ALT
					}
					if (!Output.athr.getBoolValue()) {
						me.athrMaster(1);
					}
				} else {
					if (Velocities.indicatedAirspeedKtTemp <= Velocities.vmax and Velocities.indicatedAirspeedKtTemp >= Velocities.vmin) {
						Output.spdProt.setValue(0);
						Internal.spdProtOnPitch = 0;
					}
				}
			} else { # A/THR not available, go directly into speed on pitch protection (except ALT HLD)
				if (Output.vertTemp != 0 and (Velocities.indicatedAirspeedKtTemp >= Velocities.vmax + 5)) { # High Speed Prot
					Output.spdProt.setValue(2);
					Internal.spdProtOnPitch = 1;
					me.setVertMode(4);
					if (!Output.athr.getBoolValue()) {
						me.athrMaster(1);
					}
				} else if (Output.vertTemp != 0 and (Velocities.indicatedAirspeedKtTemp <= Velocities.vmin - 5)) { # Low Speed Prot
					Output.spdProt.setValue(1);
					Internal.spdProtOnPitch = 1;
					me.setVertMode(4);
					if (!Output.athr.getBoolValue()) {
						me.athrMaster(1);
					}
				} else {
					if (Velocities.indicatedAirspeedKtTemp <= Velocities.vmax and Velocities.indicatedAirspeedKtTemp >= Velocities.vmin) {
						Output.spdProt.setValue(0);
						Internal.spdProtOnPitch = 0;
					}
				}
			}
		} else {
			Output.spdProt.setValue(0);
			Internal.spdProtOnPitch = 0;
		}
	},
	ap1Master: func(s) {
		if (s == 1) {
			if (me.apEngageAllowed() == 1 and Output.ap1Avail.getBoolValue()) {
				if (!Output.fd1.getBoolValue() and !Output.fd2.getBoolValue() and !Output.ap1.getBoolValue() and !Output.ap2.getBoolValue() and !Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
					me.setBasicMode(0);
				}
				Controls.rudder.setValue(0);
				Output.ap1.setBoolValue(1);
				me.updateActiveFms(1);
				apKill.stop();
				Warning.ap.setBoolValue(0);
				Sound.apOff.setBoolValue(0);
				Sound.enableApOff = 1;
			} else if (me.apEngageAllowed() == 2) {
				Sound.apOff.setBoolValue(1);
				Sound.enableApOff = 0;
				apKill.start();	
			}
		} else {
			Output.ap1.setBoolValue(0);
			if (Output.ap2Avail.getBoolValue()) {
				me.updateActiveFms(2);
			}
			me.apOffFunction();
		}
		Output.ap1Temp = Output.ap1.getBoolValue();
		if (Input.ap1.getBoolValue() != Output.ap1Temp) {
			Input.ap1.setBoolValue(Output.ap1Temp);
		}
	},
	ap2Master: func(s) {
		if (s == 1) {
			if (me.apEngageAllowed() == 1 and Output.ap2Avail.getBoolValue()) {
				if (!Output.fd1.getBoolValue() and !Output.fd2.getBoolValue() and !Output.ap1.getBoolValue() and !Output.ap2.getBoolValue() and !Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
					me.setBasicMode(0);
				}
				Controls.rudder.setValue(0);
				Output.ap2.setBoolValue(1);
				me.updateActiveFms(2);
				apKill.stop();
				Warning.ap.setBoolValue(0);
				Sound.apOff.setBoolValue(0);
				Sound.enableApOff = 1;
			} else if (me.apEngageAllowed() == 2) {
				Sound.apOff.setBoolValue(1);
				Sound.enableApOff = 0;
				apKill.start();	
			}
		} else {
			Output.ap2.setBoolValue(0);
			if (Output.ap1Avail.getBoolValue()) {
				me.updateActiveFms(1);
			}
			me.apOffFunction();
		}
		Output.ap2Temp = Output.ap2.getBoolValue();
		if (Input.ap2.getBoolValue() != Output.ap2Temp) {
			Input.ap2.setBoolValue(Output.ap2Temp);
		}
	},
	apOffFunction: func() {
		if (!Output.ap1.getBoolValue() and !Output.ap2.getBoolValue()) { # Only do if both APs are off
			if (Sound.enableApOff) {
				Sound.apOff.setBoolValue(1);
				Sound.enableApOff = 0;
				apKill.start();	
			}
			if (Text.vert.getValue() == "ROLLOUT") {
				fms.CORE.resetFMS();
			}
		}
	},
	athrMaster: func(s) {
		if (s == 1) {
			if (Output.athrAvail.getBoolValue()) {
				Output.athr.setBoolValue(1);
				atsKill.stop();
				Warning.ats.setBoolValue(0);
				Warning.atsFlash.setBoolValue(0);
				Internal.enableAthrOff = 1;
			}
		} else {
			Output.athr.setBoolValue(0);
			if (Internal.enableAthrOff) {
				Warning.atsFlash.setBoolValue(1);
				Internal.enableAthrOff = 0;
				atsKill.start();
			}
		}
		Output.athrTemp = Output.athr.getBoolValue();
		if (Input.athr.getBoolValue() != Output.athrTemp) {
			Input.athr.setBoolValue(Output.athrTemp);
		}
	},
	fd1Master: func(s) {
		if (s == 1) {
			if (!Output.fd1.getBoolValue() and !Output.fd2.getBoolValue() and !Output.ap1.getBoolValue() and !Output.ap2.getBoolValue() and !Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
				me.setBasicMode(0);
			}
			Output.fd1.setBoolValue(1);
		} else {
			Output.fd1.setBoolValue(0);
		}
		Output.fd1Temp = Output.fd1.getBoolValue();
		if (Input.fd1.getBoolValue() != Output.fd1Temp) {
			Input.fd1.setBoolValue(Output.fd1Temp);
		}
	},
	fd2Master: func(s) {
		if (s == 1) {
			if (!Output.fd1.getBoolValue() and !Output.fd2.getBoolValue() and !Output.ap1.getBoolValue() and !Output.ap2.getBoolValue() and !Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
				me.setBasicMode(0);
			}
			Output.fd2.setBoolValue(1);
		} else {
			Output.fd2.setBoolValue(0);
		}
		Output.fd2Temp = Output.fd2.getBoolValue();
		if (Input.fd2.getBoolValue() != Output.fd2Temp) {
			Input.fd2.setBoolValue(Output.fd2Temp);
		}
	},
	setBasicMode: func(t) {
		if (t != 1) {
			me.setLatMode(3); # HDG HOLD
		}
		if (abs(Internal.vs.getValue()) > 300 or t == 1) {
			if (afs.Output.vsFpa.getBoolValue()) {
				me.setVertMode(5); # FPA
			} else {
				me.setVertMode(1); # V/S
			}
		} else {
			me.setVertMode(0); # HOLD
		}
	},
	setLatMode: func(n) {
		Output.vertTemp = Output.vert.getValue();
		if (n == 0) { # HDG SEL
			Output.hdgCaptured = 0;
			Output.lat.setValue(0);
			me.bankLimit();
			Output.showHdg.setBoolValue(1);
			me.updateLatText("HDG");
			if (Output.vertTemp == 2 or Output.vertTemp == 6) { # Also cancel G/S or FLARE if active
				me.setVertMode(1);
			}
		} else if (n == 1) { # LNAV
			if (systems.IRS.Iru.anyAligned.getBoolValue()) { # Remember that slowLoop kills NAV if the IRUs fail
				me.updateLocArm(0);
				me.updateApprArm(0);
				me.checkLnav(0);
			}
		} else if (n == 2) { # VOR/LOC
			me.updateLnavArm(0);
			me.checkLoc(0);
		} else if (n == 3) { # HDG HLD
			me.updateLnavArm(0);
			me.updateLocArm(0);
			me.updateApprArm(0);
			me.syncHdg();
			Output.lat.setValue(0);
			me.bankLimit();
			Output.showHdg.setBoolValue(1);
			me.updateLatText("HDG");
			if (Output.vertTemp == 2 or Output.vertTemp == 6) { # Also cancel G/S or FLARE if active
				me.setVertMode(1);
			}
		} else if (n == 4) { # ALIGN
			me.updateLnavArm(0);
			me.updateLocArm(0);
			me.updateApprArm(0);
			Output.lat.setValue(4);
			me.bankLimit();
			Output.showHdg.setBoolValue(0);
			me.updateLatText("ALGN");
		} else if (n == 5) { # T/O
			me.updateLnavArm(0);
			me.updateLocArm(0);
			me.updateApprArm(0);
			Output.lat.setValue(5);
			me.bankLimit();
			Output.showHdg.setBoolValue(1);
			me.updateLatText("T/O");
		}
	},
	setLatArm: func(n) {
		if (n == 1) {
			if (FPLN.num.getValue() > 0 and FPLN.active.getBoolValue()) {
				me.updateLnavArm(1);
			}
		} else if (n == 3) {
			me.syncHdg();
			me.updateLnavArm(0);
		} 
	},
	setVertMode: func(n) {
		Input.altDiff = Input.alt.getValue() - Position.indicatedAltitudeFt.getValue();
		Output.latTemp = Output.lat.getValue();
		if (n == 0) { # ALT HLD
			Internal.flchActive = 0;
			Internal.altCaptureActive = 0;
			if (Output.latTemp == 2) {
				me.updateApprArm(0);
			}
			Output.vert.setValue(0);
			me.resetClimbRateLim();
			me.updateVertText("ALT HLD");
			me.syncAlt();
			me.updateThrustMode();
		} else if (n == 1) { # V/S
			if (abs(Input.altDiff) >= 25) {
				Internal.flchActive = 0;
				Internal.altCaptureActive = 0;
				Output.vsFpa.setBoolValue(0);
				Output.vert.setValue(1);
				me.updateVertText("V/S");
				me.syncVs();
				me.updateThrustMode();
			} else {
				me.updateApprArm(0);
			}
		} else if (n == 2) { # G/S
			me.updateLnavArm(0);
			me.checkLoc(0);
			me.checkAppr(0);
		} else if (n == 3) { # ALT CAP
			Internal.flchActive = 0;
			Output.vert.setValue(0);
			me.setClimbRateLim();
			Internal.altCaptureActive = 1;
			me.updateVertText("ALT CAP");
			me.updateThrustMode();
		} else if (n == 4) { # FLCH
			if (abs(Input.altDiff) >= 125) { # SPD CLB or SPD DES
				Internal.retardLock = 0;
				Internal.altCaptureActive = 0;
				Output.vert.setValue(4);
				Internal.flchActive = 1;
				Internal.alt.setValue(Input.alt.getValue());
				me.updateThrustMode();
			} else { # ALT CAP
				Internal.flchActive = 0;
				Internal.alt.setValue(Input.alt.getValue());
				Internal.altCaptureActive = 1;
				Output.vert.setValue(0);
				me.updateVertText("ALT CAP");
				me.updateThrustMode();
			}
		} else if (n == 5) { # FPA
			if (abs(Input.altDiff) >= 25) {
				Internal.flchActive = 0;
				Internal.altCaptureActive = 0;
				Output.vsFpa.setBoolValue(1);
				Output.vert.setValue(5);
				me.updateVertText("FPA");
				me.syncFpa();
				me.updateThrustMode();
			} else {
				me.updateApprArm(0);
			}
		} else if (n == 6) { # FLARE/ROLLOUT
			Internal.flchActive = 0;
			Internal.altCaptureActive = 0;
			Output.vert.setValue(6);
			me.updateVertText("G/S");
			me.updateThrustMode();
		} else if (n == 7) { # T/O CLB or G/A CLB, text is set by TOGA selector
			Internal.retardLock = 0;
			Internal.flchActive = 0;
			Internal.altCaptureActive = 0;
			if (Output.latTemp == 2) {
				me.updateApprArm(0);
			}
			Output.vert.setValue(7);
			me.updateThrustMode();
		}
	},
	updateThrustMode: func() {
		Output.spdProtTemp = Output.spdProt.getValue();
		Output.vertTemp = Output.vert.getValue();
		Velocities.indicatedAirspeedKtTemp = Velocities.indicatedAirspeedKt.getValue();
		if (Output.athr.getBoolValue() and Output.vertTemp != 7 and Position.gearAglFt.getValue() <= 50 and Misc.flapDeg.getValue() >= 31.5) {
			Output.thrMode.setValue(1);
			Text.thr.setValue("RETARD");
			Internal.retardLock = 1;
		} else if (Internal.retardLock != 1) { # Stays in RETARD unless we tell it to go to THRUST or PITCH
			if (Output.vertTemp == 4) {
				if (Output.spdProtTemp == 2) {
					Output.thrMode.setValue(1);
					Text.thr.setValue("PITCH");
					if (Internal.flchActive and Text.vert.getValue() != "SPD DES") {
						me.updateVertText("SPD DES");
					}
				} else if (Output.spdProtTemp == 1) {
					Output.thrMode.setValue(2);
					Text.thr.setValue("PITCH");
					if (Internal.flchActive and Text.vert.getValue() != "SPD CLB") {
						me.updateVertText("SPD CLB");
					}
				} else {
					if (Internal.alt.getValue() >= Position.indicatedAltitudeFt.getValue()) {
						Output.thrMode.setValue(2);
						Text.thr.setValue("PITCH");
						if (Internal.flchActive and Text.vert.getValue() != "SPD CLB") {
							me.updateVertText("SPD CLB");
						}
					} else {
						Output.thrMode.setValue(1);
						Text.thr.setValue("PITCH");
						if (Internal.flchActive and Text.vert.getValue() != "SPD DES") {
							me.updateVertText("SPD DES");
						}
					}
				}
			} else if (Output.vertTemp == 7) {
				Output.thrMode.setValue(2);
				Text.thr.setValue("PITCH");
			} else {
				Output.thrMode.setValue(0);
				Text.thr.setValue("THRUST");
			}
		}
	},
	bankLimit: func() {
		Output.latTemp = Output.lat.getValue();
		if (Text.vert.getValue() == "G/A CLB" or Output.latTemp == 5) {
			Internal.bankLimitCalc = 10;
		} else if (Output.latTemp == 2 or Output.latTemp == 4) {
			Radio.locDeflTemp = abs(Radio.locDefl[Input.radioSel.getValue()].getValue());
			if (Radio.locDeflTemp >= 0.105) {
				Internal.bankLimitCalc = 30;
			} else if (Radio.locDeflTemp < 0.1 and abs(Internal.navCourseTrackErrorDeg.getValue()) < 5 and abs(Misc.rollDeg.getValue()) < 10) {
				if (Position.gearAglFt.getValue() <= 200) {
					Internal.bankLimitCalc = 5;
				} else if (Internal.bankLimitCalc != 5) { # It does not go from 5 to 10, ever
					Internal.bankLimitCalc = 10;
				}
			}
		} else if (Output.latTemp == 1) {
			#if (FMS using curved-patch transitions or holding patterns or procedure turns) {
				#Internal.bankLimitAuto = fms.Internal.bankAngle2.getValue();
			#} else {
				Internal.bankLimitAuto = fms.Internal.bankAngle1.getValue();
			#}
			Internal.bankLimitCalc = Internal.bankLimitAuto;
		} else {
			Input.bankLimitSwTemp = Input.bankLimitSw.getValue();
			Internal.bankLimitAuto = fms.Internal.bankAngle1.getValue();
			if (Input.bankLimitSwTemp == 0) {
				Internal.bankLimitCalc = Internal.bankLimitAuto;
			} else {
				Internal.bankLimitCalc = math.clamp(Internal.bankLimitMax[Input.bankLimitSwTemp], Internal.bankLimitAuto * -1, Internal.bankLimitAuto);
			}
		}
		Internal.bankLimit.setValue(Internal.bankLimitCalc);
	},
	activateLnav: func() {
		if (Output.lat.getValue() != 1) {
			me.updateLnavArm(0);
			me.updateLocArm(0);
			me.updateApprArm(0);
			Output.lat.setValue(1);
			me.bankLimit();
			me.updateLatText("LNAV");
			if (Output.vertTemp == 2 or Output.vertTemp == 6) { # Also cancel G/S or FLARE if active
				me.setVertMode(1);
			}
		}
		Output.showHdg.setBoolValue(0);
	},
	activateLoc: func() {
		if (Output.lat.getValue() != 2) {
			me.updateLnavArm(0);
			me.updateLocArm(0);
			Output.lat.setValue(2);
			me.bankLimit();
			me.updateLatText("LOC");
		}
		Output.showHdg.setBoolValue(0);
	},
	activateGs: func() {
		if (Output.vert.getValue() != 2) {
			Internal.flchActive = 0;
			Internal.altCaptureActive = 0;
			me.updateApprArm(0);
			Output.vert.setValue(2);
			me.updateVertText("G/S");
			me.updateThrustMode();
		}
	},
	checkLnav: func(t) {
		FPLN.activeTemp = FPLN.active.getBoolValue();
		if (FPLN.num.getValue() > 0 and FPLN.activeTemp and Position.gearAglFt.getValue() >= Internal.lnavEngageFt) {
			me.activateLnav();
		} else if (FPLN.activeTemp and Output.lat.getValue() != 1 and t != 1) {
			me.updateLnavArm(1);
		}
		if (!FPLN.activeTemp) {
			me.updateLnavArm(0);
		}
	},
	checkFlch: func(a) {
		if (Position.gearAglFt.getValue() >= a and a != 0) {
			me.setVertMode(4);
		}
	},
	checkLoc: func(t) {
		Radio.radioSel = Input.radioSel.getValue();
		if (Radio.inRange[Radio.radioSel].getBoolValue()) { #  # Only evaulate the rest of the condition unless we are in range
			Radio.locDeflTemp = Radio.locDefl[Radio.radioSel].getValue();
			Radio.signalQualityTemp = Radio.signalQuality[Radio.radioSel].getValue();
			if (abs(Radio.locDeflTemp) <= 0.95 and Radio.locDeflTemp != 0 and Radio.signalQualityTemp >= 0.99) {
				me.activateLoc();
			} else if (t != 1) { # Do not do this if loop calls it
				if (Output.lat.getValue() != 2) {
					me.updateLnavArm(0);
					me.updateLocArm(1);
				}
			}
		} else {
			Radio.signalQuality[Radio.radioSel].setValue(0); # Prevent bad behavior due to FG not updating it when not in range
			me.updateLocArm(0);
		}
	},
	checkAppr: func(t) {
		Radio.radioSel = Input.radioSel.getValue();
		if (Radio.inRange[Radio.radioSel].getBoolValue()) { #  # Only evaulate the rest of the condition unless we are in range
			Radio.gsDeflTemp = Radio.gsDefl[Radio.radioSel].getValue();
			if (abs(Radio.gsDeflTemp) <= 0.2 and Radio.gsDeflTemp != 0 and Output.lat.getValue()  == 2 and abs(Internal.navCourseTrackErrorDeg.getValue()) <= 80) { # Only capture if LOC is active and course error less or equals 80
				me.activateGs();
			} else if (t != 1) { # Do not do this if loop calls it
				if (Output.vert.getValue() != 2) {
					me.updateApprArm(1);
				}
			}
		} else {
			Radio.signalQuality[Radio.radioSel].setValue(0); # Prevent bad behavior due to FG not updating it when not in range
			me.updateApprArm(0);
		}
	},
	checkRadioRevision: func(l, v) { # Revert mode if signal lost
		Radio.radioSel = Input.radioSel.getValue();
		Radio.inRangeTemp = Radio.inRange[Radio.radioSel].getBoolValue();
		if (!Radio.inRangeTemp) {
			if (l == 4 or v == 6) {
				me.ap1Master(0);
				me.ap2Master(0);
				me.setLatMode(3);
				me.setVertMode(1);
			} else {
				me.setLatMode(3); # Also cancels G/S if active
			}
		}
	},
	setClimbRateLim: func() {
		Internal.vsTemp = Internal.vs.getValue();
		if (Internal.alt.getValue() >= Position.indicatedAltitudeFt.getValue()) {
			Internal.maxVs.setValue(math.round(Internal.vsTemp));
			Internal.minVs.setValue(-500);
		} else {
			Internal.maxVs.setValue(500);
			Internal.minVs.setValue(math.round(Internal.vsTemp));
		}
	},
	resetClimbRateLim: func() {
		Internal.minVs.setValue(-500);
		Internal.maxVs.setValue(500);
	},
	takeoffGoAround: func() {
		Output.vertTemp = Output.vert.getValue();
		if (Gear.wow0Timer.getValue() < 1 and Output.vertTemp != 7 and Position.gearAglFt.getValue() < 2500) {
			if (!Output.fd1.getBoolValue()) {
				me.fd1Master(1);
			}
			if (!Output.fd2.getBoolValue()) {
				me.fd2Master(1);
			}
			if (!Output.athr.getBoolValue()) {
				me.athrMaster(1);
			}
			me.setLatMode(3);
			me.setVertMode(7);
			me.updateVertText("G/A CLB");
			Internal.ktsMach.setBoolValue(0);
			me.syncKts();
			if (Gear.wow1.getBoolValue() or Gear.wow2.getBoolValue()) {
				if (systems.BRAKES.Abs.armed.getBoolValue()) {
					systems.BRAKES.absSetOff(1); # Disarm autobrake
				}
				me.ap1Master(0);
				me.ap2Master(0);
			}
		}
	},
	syncKts: func() {
		Internal.kts.setValue(math.clamp(math.round(Velocities.indicatedAirspeedKt.getValue()), fms.Speeds.athrMin.getValue(), fms.Speeds.athrMax.getValue()));
	},
	syncKtsSel: func() {
		Input.kts.setValue(math.clamp(math.round(Velocities.indicatedAirspeedKt.getValue()), 100, 365));
	},
	syncMach: func() {
		Internal.mach.setValue(math.clamp(math.round(Velocities.indicatedMach.getValue(), 0.001), fms.Speeds.athrMinMach.getValue(), fms.Speeds.athrMaxMach.getValue()));
	},
	syncMachSel: func() {
		Input.mach.setValue(math.clamp(math.round(Velocities.indicatedMach.getValue(), 0.001), 0.5, 0.87));
	},
	syncHdg: func() {
		Internal.hdgSet = math.round(Internal.hdgPredicted.getValue()); # Switches to track automatically
		Internal.hdg.setValue(Internal.hdgSet);
		Input.hdg.setValue(Internal.hdgSet);
	},
	syncAlt: func() {
		Input.alt.setValue(math.clamp(math.round(Internal.altPredicted.getValue(), 100), 0, 50000));
		Internal.alt.setValue(math.clamp(math.round(Internal.altPredicted.getValue(), 100), 0, 50000));
	},
	syncVs: func() {
		Input.vs.setValue(math.clamp(math.round(Internal.vs.getValue(), 100), -6000, 6000));
	},
	syncFpa: func() {
		Input.fpa.setValue(math.clamp(math.round(Internal.fpa.getValue(), 0.1), -9.9, 9.9));
	},
	spdPush: func() {
		Internal.retardLock = 0;
		if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue() and (Text.vert.getValue() != "T/O CLB" or Position.gearAglFt.getValue() >= 400)) {
			Output.spdCaptured = 1;
			if (Input.ktsMach.getBoolValue()) {
				Internal.ktsMach.setBoolValue(1);
				Input.mach.setValue(math.clamp(math.round(Velocities.indicatedMach5Sec.getValue(), 0.001), 0.5, 0.87));
				Internal.mach.setValue(math.clamp(math.round(Velocities.indicatedMach5Sec.getValue(), 0.001), fms.Speeds.athrMinMach.getValue(), fms.Speeds.athrMaxMach.getValue()));
			} else {
				Internal.ktsMach.setBoolValue(0);
				Input.kts.setValue(math.clamp(math.round(Velocities.indicatedAirspeedKt5Sec.getValue()), 100, 365));
				Internal.kts.setValue(math.clamp(math.round(Velocities.indicatedAirspeedKt5Sec.getValue()), fms.Speeds.athrMin.getValue(), fms.Speeds.athrMax.getValue()));
			}
		} else {
			if (Input.ktsMach.getBoolValue()) {
				me.syncMachSel();
			} else {
				me.syncKtsSel();
			}
		}
	},
	spdPull: func() {
		Internal.retardLock = 0;
		if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue() and (Text.vert.getValue() != "T/O CLB" or Position.gearAglFt.getValue() >= 400)) {
			Input.ktsMachTemp = Input.ktsMach.getBoolValue();
			if (Internal.ktsMach.getBoolValue() != Input.ktsMachTemp) {
				Internal.ktsMach.setBoolValue(Input.ktsMachTemp);
			}
			if (Input.ktsMachTemp) {
				Internal.mach.setValue(math.clamp(Input.mach.getValue(), fms.Speeds.athrMinMach.getValue(), fms.Speeds.athrMaxMach.getValue()));
			} else {
				Internal.kts.setValue(math.clamp(Input.kts.getValue(), fms.Speeds.athrMin.getValue(), fms.Speeds.athrMax.getValue()));
			}
			Output.spdCaptured = 0;
		}
	},
	autoflight: func() {
		Input.ovrd1Temp = Input.ovrd1.getBoolValue();
		Input.ovrd2Temp = Input.ovrd2.getBoolValue();
		Internal.activeFmsTemp = Internal.activeFms.getValue();
		
		if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
			if ((Output.ap1.getBoolValue() or Output.ap2.getBoolValue()) and Output.athr.getBoolValue()) { # Switch active FMS if there is nothing to engage
				if (Internal.activeFmsTemp == 1 and Output.ap2Avail.getBoolValue()) {
					me.updateActiveFms(2);
				} else if (Internal.activeFmsTemp == 2 and Output.ap1Avail.getBoolValue()) {
					me.updateActiveFms(1);
				}
			}
			Internal.activeFmsTemp = Internal.activeFms.getValue(); # Update it after we just set it
			if (Internal.activeFmsTemp == 1) {
				if (Output.ap1Avail.getBoolValue()) { # AP1 on
					me.ap1Master(1);
					me.ap2Master(0);
				} else if (Output.ap2Avail.getBoolValue()) { # AP2 on because AP1 is not available
					me.ap2Master(1); # Will set activeFms to 2
					me.ap1Master(0);
				}
			} else if (Internal.activeFmsTemp == 2) {
				if (Output.ap2Avail.getBoolValue()) { # AP2 on
					me.ap2Master(1);
					me.ap1Master(0);
				} else if (Output.ap1Avail.getBoolValue()) { # AP1 on because AP2 is not available
					me.ap1Master(1); # Will set activeFms to 1
					me.ap2Master(0);
				}
			}
		}
		if (!Output.athr.getBoolValue() and Output.athrAvail.getBoolValue()) {
			me.athrMaster(1);
		}
	},
	# To avoid messy code in the ap1Master() and ap2Master()
	apEngageAllowed: func() {
		if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
			if (Output.vert.getValue() == 6 or Text.vert.getValue() == "G/A CLB") {
				return 1;
			} else if (Position.gearAglFt.getValue() >= 400 and Output.lat.getValue() == 1) {
				return 1;
			} else if (Position.gearAglFt.getValue() >= 100 and Output.lat.getValue() != 1) {
				return 1;
			} else {
				return 2;
			}
		} else {
			return 0;
		}
	},
	spdProtAllowed: func() {
		if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue() and Position.gearAglFt.getValue() > 50 and (!Input.ovrd1.getBoolValue() or !Input.ovrd2.getBoolValue())) {
			return 1;
		} else {
			return 0;
		}
	},
	# Silently kill AFS and ATS
	killAFSSilent: func() {
		Output.ap1.setBoolValue(0);
		Output.ap2.setBoolValue(0);
		Sound.apOff.setBoolValue(0);
		Sound.enableApOff = 0;
		# Now that AFS is off, we can safely update the input to 0 without the AP Master running
		Input.ap1.setBoolValue(0);
		Input.ap2.setBoolValue(0);
	},
	killATSSilent: func() {
		Output.athr.setBoolValue(0);
		Warning.atsFlash.setBoolValue(0);
		Internal.enableAthrOff = 0;
		# Now that ATS is off, we can safely update the input to 0 without the ATHR Master running
		Input.athr.setBoolValue(0);
	},
	updateActiveFms: func(n) {
		Internal.activeFms.setValue(n);
		updateFma.roll();
	},
	updateLatText: func(t) {
		Text.lat.setValue(t);
		updateFma.roll();
	},
	updateVertText: func(t) {
		Text.vert.setValue(t);
		updateFma.pitch();
	},
	updateLnavArm: func(n) {
		Output.lnavArm.setBoolValue(n);
		updateFma.arm();
	},
	updateLocArm: func(n) {
		Output.locArm.setBoolValue(n);
		updateFma.arm();
	},
	updateApprArm: func(n) {
		Output.apprArm.setBoolValue(n);
		updateFma.arm();
	},
};

setlistener("/it-autoflight/input/ap1", func() {
	Input.ap1Temp = Input.ap1.getBoolValue();
	if (Input.ap1Temp != Output.ap1.getBoolValue()) {
		ITAF.ap1Master(Input.ap1Temp);
	}
});

setlistener("/it-autoflight/input/ap2", func() {
	Input.ap2Temp = Input.ap2.getBoolValue();
	if (Input.ap2Temp != Output.ap2.getBoolValue()) {
		ITAF.ap2Master(Input.ap2Temp);
	}
});

setlistener("/it-autoflight/input/athr", func() {
	Input.athrTemp = Input.athr.getBoolValue();
	if (Input.athrTemp != Output.athr.getBoolValue()) {
		ITAF.athrMaster(Input.athrTemp);
	}
});

setlistener("/it-autoflight/input/fd1", func() {
	Input.fd1Temp = Input.fd1.getBoolValue();
	if (Input.fd1Temp != Output.fd1.getBoolValue()) {
		ITAF.fd1Master(Input.fd1Temp);
	}
});

setlistener("/it-autoflight/input/fd2", func() {
	Input.fd2Temp = Input.fd2.getBoolValue();
	if (Input.fd2Temp != Output.fd2.getBoolValue()) {
		ITAF.fd2Master(Input.fd2Temp);
	}
});

setlistener("/it-autoflight/input/kts-mach", func() {
	if (Input.ktsMach.getBoolValue()) {
		ITAF.syncMachSel();
	} else {
		ITAF.syncKtsSel();
	}
}, 0, 0);

setlistener("/it-autoflight/internal/kts-mach", func() {
	if (Internal.ktsMach.getBoolValue()) {
		ITAF.syncMach();
	} else {
		ITAF.syncKts();
	}
}, 0, 0);

setlistener("/it-autoflight/input/toga", func() {
	if (Input.toga.getBoolValue()) {
		ITAF.takeoffGoAround();
		Input.toga.setBoolValue(0);
	}
});

setlistener("/it-autoflight/input/lat", func() {
	Input.latTemp = Input.lat.getValue();
	if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue()) {
		ITAF.setLatMode(Input.latTemp);
	} else {
		ITAF.setLatArm(Input.latTemp);
	}
});

setlistener("/it-autoflight/input/vert", func() {
	if (!Gear.wow1.getBoolValue() and !Gear.wow2.getBoolValue() and (Text.vert.getValue() != "T/O CLB" or Position.gearAglFt.getValue() >= 400)) {
		ITAF.setVertMode(Input.vert.getValue());
	}
});

# Flashing Logic
var killAPWarn = func() {
	if (Sound.apOff.getBoolValue()) { # Second press only
		apKill.stop();
		Warning.ap.setBoolValue(0);
		Sound.apOff.setBoolValue(0);
	}
}

var killATSWarn = func() {
	if (Warning.atsFlash.getBoolValue()) { # Second press only
		atsKill.stop();
		Warning.ats.setBoolValue(0);
		Warning.atsFlash.setBoolValue(0);
	}
};

var apKill = maketimer(0.4, func() {
	if (!Sound.apOff.getBoolValue()) {
		apKill.stop();
		Warning.ap.setBoolValue(0);
	} else if (!Warning.ap.getBoolValue()) {
		Warning.ap.setBoolValue(1);
	} else {
		Warning.ap.setBoolValue(0);
	}
});

var atsKill = maketimer(0.4, func() {
	if (!Warning.atsFlash.getBoolValue()) {
		atsKill.stop();
		Warning.ats.setBoolValue(0);
	} else if (!Warning.ats.getBoolValue()) {
		Warning.ats.setBoolValue(1);
	} else {
		Warning.ats.setBoolValue(0);
	}
});

setlistener("/it-autoflight/input/trk", func() {
	Input.trkTemp = Input.trk.getBoolValue();
	
	if (Input.trkTemp) {
		Internal.hdgCalc = Internal.hdg.getValue() + math.round(Internal.driftAngle.getValue());
	} else {
		Internal.hdgCalc = Internal.hdg.getValue() - math.round(Internal.driftAngle.getValue());
	}
	
	if (Internal.hdgCalc > 359) { # It's rounded, so this is ok. Otherwise do >= 359.5
		Internal.hdgCalc = Internal.hdgCalc - 360;
	} else if (Internal.hdgCalc < 0) { # It's rounded, so this is ok. Otherwise do < -0.5
		Internal.hdgCalc = Internal.hdgCalc + 360;
	}
	
	Input.hdg.setValue(Internal.hdgCalc);
	Internal.hdg.setValue(Internal.hdgCalc);
	
	updateFma.roll();
	
	pts.Instrumentation.Efis.hdgTrkSelected[0].setBoolValue(Input.trkTemp); # For Canvas Nav Display.
	pts.Instrumentation.Efis.hdgTrkSelected[1].setBoolValue(Input.trkTemp); # For Canvas Nav Display.
}, 0, 0);

# For Canvas Nav Display.
setlistener("/it-autoflight/input/hdg", func() {
	setprop("/autopilot/settings/heading-bug-deg", getprop("/it-autoflight/input/hdg"));
});

setlistener("/it-autoflight/internal/alt", func() {
	setprop("/autopilot/settings/target-altitude-ft", getprop("/it-autoflight/input/alt"));
});

var loopTimer = maketimer(0.1, ITAF, ITAF.loop);
var slowLoopTimer = maketimer(1, ITAF, ITAF.slowLoop);
