require! ramda: R

available-dirs = (dir) ->
  | dir is \up or dir is \down    => <[ right left ]>
  | dir is \left or dir is \right => <[ up down ]>
  | _                             => <[ up down right left ]>

transform = (pos, length, dir) ->
  switch dir
  | \up     => [pos.0, pos.1 + length]
  | \down   => [pos.0, pos.1 - length]
  | \right  => [pos.0 + length, pos.1]
  | \left   => [pos.0 - length, pos.1]

calc-path = (start, pos, length, dir, max-n, directions, path = [start]) ->
  if not (0 <= pos.0 <= max-n and 0 <= pos.1 <= max-n) then return false
  R.forEach (d) ->
    next-pos = transform pos, length, d
    if R.equals next-pos, start
      console.log "Path found: ", R.append next-pos, path
    else
      calc-path start, next-pos, length + 1, d, max-n, directions, R.append(next-pos, path)
  , available-dirs dir

calc-path([5 10], [5 10], 1, null, 20, available-dirs!)
