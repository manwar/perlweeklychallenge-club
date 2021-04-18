max = 9
tr = Array.new(max+1){Array.new(max+1)}
tr[0][0] = 1
results = [1]
for row in 1..max
    tr[row][0] = tr[row - 1][row -1]
    results << tr[row][0]
    for i in 1..row
        tr[row][i] = tr[row][i-1] + tr[row - 1][i-1]
    end
end
puts "The #{max+1} first Bell numbers are: #{results.join(" ")}"
