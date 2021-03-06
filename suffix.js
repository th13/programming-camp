// Generated by LiveScript 1.5.0
(function(){
  var R, S, T, rules, isSuffix, replaceSuffix, transform, applyRule, tryTransformation, transformEach, getPaths, takeMin, getMinPath;
  R = require('ramda');
  S = 'ABC';
  T = 'CBA';
  rules = [['AA', 'BC'], ['BC', 'CC'], ['ACC', 'BAA'], ['BCC', 'CAA'], ['B', 'A'], ['C', 'B'], ['A', 'C']];
  isSuffix = function(rule, token){
    return token.endsWith(rule);
  };
  replaceSuffix = function(str, rule){
    return R.reverse(
    R.replace(R.reverse(
    rule[0]), R.reverse(
    rule[1]))(
    R.reverse(
    str)));
  };
  transform = function(str, rule){
    var transformation;
    transformation = replaceSuffix(str, rule);
    if (transformation === str) {
      return false;
    } else {
      return transformation;
    }
  };
  applyRule = function(rule, str){
    if (isSuffix(rule[0], str)) {
      return transform(str, rule);
    } else {
      return false;
    }
  };
  tryTransformation = curry$(function(rule, str, T, count, paths){
    var res;
    res = applyRule(rule, str);
    if (res === T) {
      return paths.push(
      R.inc(
      count));
    } else if (res) {
      return getPaths(res, T, R.inc(count), paths);
    }
  });
  transformEach = function(str, T, count, paths){
    return R.forEach(function(it){
      return tryTransformation(it, str, T, count, paths);
    });
  };
  getPaths = function(str, T, count, paths){
    count == null && (count = 0);
    paths == null && (paths = []);
    switch (false) {
    case !(count < 30):
      transformEach(str, T, count, paths)(
      rules);
    }
    return paths;
  };
  takeMin = R.reduce(R.min, Infinity);
  getMinPath = function(S, T){
    return takeMin(
    getPaths(S, T));
  };
  console.log(
  getMinPath(S, T));
  function curry$(f, bound){
    var context,
    _curry = function(args) {
      return f.length > 1 ? function(){
        var params = args ? args.concat() : [];
        context = bound ? context || this : this;
        return params.push.apply(params, arguments) <
            f.length && arguments.length ?
          _curry.call(context, params) : f.apply(context, params);
      } : f;
    };
    return _curry();
  }
}).call(this);
