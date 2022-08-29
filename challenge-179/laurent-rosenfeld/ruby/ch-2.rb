bars = ('▁'..'█').to_a
tests = [ [1, 2, 3, 4, 5, 6, 7, 8, 7, 6, 5, 4, 3, 2, 1],
    [0, 1, 19, 20], [0, 999, 4000, 4999, 7000, 7999] ]
for test in tests
    min, max = test.minmax
    puts test.join(" ")
    puts "min: %.2f; max: %.2f"% [min, max]
    scale = (max - min) / (bars.size - 1)
    line = ""
    for item in test
        h = bars.size * (item - min) / (max - min)
        if h >= bars.size
            h = bars.size - 1
        end
        line += bars[h]
    end
    puts line
    puts " "
end
