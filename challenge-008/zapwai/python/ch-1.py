def is_perfect(num):
    divs = []
    for i in range(1, int(num/2) + 1):
        if num % i == 0:
            divs.append(i)
    return (sum(divs) == num);

def perfects() :
    for i in range(2, 15):
        num = pow(2, i - 1) * (pow(2,i) - 1);
        if is_perfect(num):
            print(num,"", end='')

perfects();
print()
