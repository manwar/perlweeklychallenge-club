def proc(hours):
    print("Input:", hours)
    tally = 0
    for i in range(len(hours) - 1):
        for j in range(i + 1, len(hours)):
            mysum = hours[i] + hours[j]
            if mysum % 24 == 0:
                tally += 1
    print("Output:", tally)


hours = [12, 12, 30, 24, 24]
proc(hours)
hours = [72, 48, 24, 5]
proc(hours)
hours = [12, 18, 24]
proc(hours)

