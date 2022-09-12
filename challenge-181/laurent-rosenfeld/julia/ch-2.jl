fh = open("./temperature.txt", "r")
lines = readlines(fh)
sorted_lines = sort(lines)
temp = 100000
for line in sorted_lines
    (date, temp_str) = split(line, ", ")
    curr_temp = parse(Int64, temp_str)
    if curr_temp > temp
        println(date)
    end
    global temp = curr_temp
end
