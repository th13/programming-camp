S = 'ABC'
T = 'CBA'

RULES = [
  ['AA', 'BC'],
  ['BC', 'CC'],
  ['ACC', 'BAA'],
  ['BCC', 'CAA'],
  ['B', 'A'],
  ['C', 'B'],
  ['A', 'C']
]

def suffix?(rule, token)
  token.reverse.index(rule.reverse) == 0 ? true : false
end

def transform(str, rule)
  tmp = str.reverse.sub(rule[0].reverse, rule[1].reverse).reverse
  tmp == str ? false : tmp
end

def apply_rule(rule, str)
  suffix?(rule[0], str) ? transform(str, rule) : false
end

def transformations(str, count, paths = [])
  return if count > 15

  RULES.each do |rule|
    res = apply_rule rule, str
    if res == T
      paths.push count + 1
      return
    elsif res
      transformations res, count + 1, paths
    end
  end
  paths
end

puts transformations(S, 0).min
