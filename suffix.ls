require! ramda: R

S = \ABC
T = \CBA
rules =
  <[ AA BC ]>
  <[ BC CC ]>
  <[ ACC BAA ]>
  <[ BCC CAA ]>
  <[ B A ]>
  <[ C B ]>
  <[ A C ]>

is-suffix = (rule, token) ->
  token.endsWith rule
replace-suffix = (str, rule) ->
  str
  |> R.reverse
  |> R.replace(rule.0 |> R.reverse, rule.1 |> R.reverse)
  |> R.reverse
transform = (str, rule) ->
  transformation = replace-suffix(str, rule)
  if transformation is str then false else transformation
apply-rule = (rule, str) ->
  if is-suffix rule.0, str then transform str, rule else false
try-transformation = (rule, str, T, count, paths) -->
  res = apply-rule rule, str
  if res is T
    count |> R.inc |> paths.push
  else if res
    get-paths res, T, R.inc(count), paths
transform-each = (str, T, count, paths) ->
  R.forEach -> try-transformation it, str, T, count, paths
get-paths = (str, T, count = 0, paths = []) ->
  | count < 30  => rules |> transform-each str, T, count, paths
  paths
take-min = R.reduce R.min, Infinity
get-min-path = (S, T) -> get-paths S, T |> take-min
get-min-path S, T |> console.log
