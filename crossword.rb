NSLOTS = gets.chomp.to_i
slots = []
words = []
grid = Array.new 15
grid.length.times { |n| grid[n] = Array.new 15 }

NSLOTS.times do |n|
  s = gets.split
  slots.push({ row: s[0].to_i - 1, col: s[1].to_i - 1, dir: s[2].upcase})
  puts slots[n]
end

slots.each do |slot|
  grid[slot[:row]][slot[:col]] = slot[:dir]
end

def print_grid(grid)
  grid.each do |row|
    row.each do |val|
      if val == nil
        print ". "
      else
        print val, " "
      end
    end
    print "\n"
  end
end

# # We always have 1 extra word
# (NSLOTS + 1).times do |n|
#   words.push gets.chomp.upcase
#   puts words[n]
# end

def fill_first(gr, w)
  down_start = nil
  col = nil
  g = gr
  g.each_with_index do |row, row_n|
    row.each_with_index do |val, n|
      if val == 'A'
        w.split('').each_with_index do |l, i|
          if row[i + n] == nil || row[i + n] == 'A'
            row[i + n] = l
          else
            if row[i + n] != l
              return gr
            end
          end
        end
        return g
      elsif val == 'D'
        # Save column number
        col = n
        down_start = row_n
      end
    end
  end

  if col >= 0
    w.split('').each_with_index do |l, i|
      g[down_start + i][col] = l
    end
  end
  g
end

test = fill_first(grid, "test")
print_grid(fill_first(test, "across"))

def solve(words, grid)
  if words.length == 0
    if is_valid(grid)
      return grid
    else
      return nil
    end
  end
  words.each do |word|
    possibleSol = fill_first(grid, word)
    ret = solve(words.delete_if { |w| w == word }, possibleSol)
    if ret != nil
      return ret
    end
  end
  nil
end
