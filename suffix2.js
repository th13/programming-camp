'use strict';

const R = require('ramda');

let S = 'ABC';
let T = 'CBA';

let rules = [
  ['AA', 'BC'],
  ['BC', 'CC'],
  ['ACC', 'BAA'],
  ['BCC', 'CAA'],
  ['B', 'A'],
  ['C', 'B'],
  ['A', 'C']
];

function isSuffix(suf, token) {
  return token.endsWith(suf);
}

function transform(str, rule) {
  let tmp = R.reverse(R.replace(R.reverse(rule[0]), R.reverse(rule[1]), R.reverse(str)));
  return tmp === str ? false : tmp;
}

function apply_rule(rule, str) {

}
