def digit_sum(ints):
    sum = 0
    for integer in ints:
        while integer != 0:
            sum += integer % 10;
            integer = int(integer / 10);
    return sum

ints = [1,2,3,45];
print("Input:", ints);
print("Output:", abs(digit_sum(ints) - sum(ints)));

