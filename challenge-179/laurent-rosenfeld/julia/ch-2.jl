function sparkline(test)
    bars = '\u2581':'\u2588'
    bar_count = length(bars)
    min, max = extrema(test)
    out = ""
    for item in test
        h = 1 + bar_count * (item - min) / (max - min)
        h > bar_count && (h = bar_count)
        out = out * string(bars[Int(floor(h))])
    end
    return out * "\n"
end

tests = [ [2, 4, 6, 8, 10, 12, 10, 8, 6, 4, 2],
    [0, 1, 19, 20], [0, 999, 4000, 4999, 7000, 7999] ]
for test in tests
    println(test, "\n")
    println( sparkline(test))
end
