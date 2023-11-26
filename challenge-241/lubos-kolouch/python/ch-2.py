import math


def prime_factors(n):
    factors = []
    while n % 2 == 0:
        factors.append(2)
        n //= 2
    for i in range(3, int(math.sqrt(n)) + 1, 2):
        while n % i == 0:
            factors.append(i)
            n //= i
    if n > 2:
        factors.append(n)
    return factors


def sort_by_prime_factors(nums):
    nums_with_factors = [(len(prime_factors(num)), num) for num in nums]
    nums_with_factors.sort()
    return [num for _, num in nums_with_factors]


# Test Cases
print(sort_by_prime_factors([11, 8, 27, 4]))  # Output: [11, 4, 8, 27]
