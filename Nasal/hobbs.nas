var d0 = props.globals.initNode ("instrumentation/hobbs-meter/digits0", 1, "INT");
var d1 = props.globals.initNode ("instrumentation/hobbs-meter/digits1", 1, "INT");
var d2 = props.globals.initNode ("instrumentation/hobbs-meter/digits2", 1, "INT");
var d3 = props.globals.initNode ("instrumentation/hobbs-meter/digits3", 1, "INT");
var d4 = props.globals.initNode ("instrumentation/hobbs-meter/digits4", 1, "INT");
var e0 = props.globals.initNode ("engines/engine[0]/running-time-s", 1, "DOUBLE");
var t = aircraft.timer.new (e0);
var lis = setlistener ("/engines/engine[0]/running", func (r) {
    if (r.getBoolValue ()) {
      t.start ();
    }
    else {
      t.stop ();
    }
}, 1, 0);

var update = func () {
    var h = e0.getValue () or 0.0;
    h = h / 360.0; # tenths of an hour, initially
    d0.setValue (math.mod (int (h), 10)); h = h / 10;
    d1.setValue (math.mod (int (h), 10)); h = h / 10;
    d2.setValue (math.mod (int (h), 10)); h = h / 10;
    d3.setValue (math.mod (int (h), 10)); h = h / 10;
    d4.setValue (math.mod (int (h), 10)); h = h / 10;
};

var update_timer = maketimer (1, func () {
   update ();
});
update_timer.start ();
