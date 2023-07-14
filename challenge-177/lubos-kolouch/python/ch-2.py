import math


def is_prime(num):
    if num < 2:
        return False
    for i in range(2, int(math.sqrt(num)) + 1):
        if num % i == 0:
            return False
    return True


def is_cyclops(num):
    digits = len(str(num))
    if digits % 2 == 0:
        return False
    middle = digits // 2
    return str(num)[middle] == '0' and str(num)[:middle] == str(num)[middle +
                                                                     1:][::-1]


def generate_palindromic_prime_cyclops(count):
    results = []
    num = 0

    while count > 0:
        if is_cyclops(num) and is_prime(num):
            results.append(num)
            count -= 1
        num += 1

    return results


# Testing
results = generate_palindromic_prime_cyclops(20)
print(", ".join(map(str, results)))
