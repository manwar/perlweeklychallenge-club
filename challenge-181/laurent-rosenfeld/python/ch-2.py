lines = []
file_in = "./temperature.txt"
fh = open(file_in, "r")
for line in fh:
    line.rstrip()
    lines.append(line)
lines.sort();
temp = 1e9
for line in lines:
    fields = line.split(',')
    cur_temp = int(fields[1].strip())
    if cur_temp > temp:
        print(fields[0])
    temp = cur_temp
