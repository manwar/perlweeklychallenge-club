from math import sqrt


def find_power(input):
    if input == 1:   # Trivial solution
        return 1
    for base in range(2, int(sqrt(input)) + 1):
        for exp in range(2, int(sqrt(input))):
            power = base ** exp
            if power == input:
                return 1                
            if power > input:
                break
    return 0

tests = [15, 121, 144, 145, 1451]
for test in tests:
    print(test, ": ", find_power (test))

