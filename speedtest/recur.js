// Generated by LiveScript 1.5.0
(function(){
  var R, helloWorld;
  R = require('ramda');
  helloWorld = function(times){
    times == null && (times = 0);
    switch (false) {
    case !(times < 10):
      console.log("Hello World " + times);
      helloWorld(
      R.inc(
      times));
    }
  };
  helloWorld();
}).call(this);
