require! ramda: R

input = [ 1 2 3 ]
shapes = {
  3: \triangle,
  4: \parallelagram,
  6: \hexagon
}

diff = (a, b) -> a - b
sort = R.sort diff

triangle = (row) ->
  next = 1
  tri = []
  for i from 0 to row - 1
    t = [next to next + i]
    tri = R.append t, tri
    next = t[* - 1] + 1
  tri

in-row = (triangle, row, pt) ->
  if (R.indexOf pt, triangle[row]) >= 0
    return true
  false

row-of = (triangle, pt) -->
  for i from 0 to triangle.length - 1
    if in-row triangle, i, pt then return i


length = (triangle, p1, p2) -->
  get-row = row-of triangle

  if (get-row p1) is (get-row p2)
    return Math.abs(p1 - p2)

  p1row = get-row p1
  p2row = get-row p2
  rowDiff = Math.abs(p1row - p2row)
  p1index = R.indexOf p1, triangle[p1row]
  p2index = R.indexOf p2, triangle[p2row]
  indexDiff = Math.abs(p1index - p2index)

  if indexDiff is rowDiff or indexDiff is 0
    return rowDiff
  return -1

shape = (triangle, points, shapes) ->
  if shapes[points.length] == undefined
    return false

  tri-length = length triangle
  if shapes[points.length] is \triangle
    if (tri-length points.0, points.1) is (tri-length points.1, points.2) && (tri-length points.1, points.2) is (tri-length points.2, points.0)
      return true
    else
      return false
  else if shapes[points.length] is \parallelagram
    side1 = tri-length points.0, points.1
    side2 = tri-length points.1, points.2
    side3 = tri-length points.2, points.3
    side4 = tri-length points.3, points.0
    if side1 is side2 and side2 is side3 and side3 is side4 and side4 is side1
      return true
    else
      return false

  else if shapes[points.length] is \hexagon
    side1 = tri-length points.0, points.1
    side2 = tri-length points.1, points.2
    side3 = tri-length points.2, points.3
    side4 = tri-length points.3, points.4
    side5 = tri-length points.4, points.5
    side6 = tri-length points.5, points.0
    if side1 is side2 and side2 is side3 and side3 is side4 and side4 is side5 and side5 is side6 and side6 is side1
      return true
    else
      return false

# length triangle(10), 6, 39 |> console.log
test = sort [26 11 13 24]
res = shape triangle(25), test, shapes
if res
  console.log "#{test} are the vertices of #{shapes[test.length]}"
else
  console.log "#{test} are not the vertices of any shapes"
