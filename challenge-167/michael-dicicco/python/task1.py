# Challenge 167 Task1
#
#  Solution By: Michael DiCicco
#
#  Write a script to find out first 10 circular primes having at least 3
#  digits (base 10). Please checkout wikipedia for more information. A
#  circular prime is a prime number with the property that the number
#  generated at each intermediate step when cyclically permuting its (base
#  10) digits will also be prime.
#
#  Output 113, 197, 199, 337, 1193, 3779, 11939, 19937, 193939, 199933

class CircularPrime:
    used_numbers = set()

    @staticmethod
    def is_prime(some_number):
        if int(some_number) <= 1:
            return False
        for i in range(2, int(some_number) - 1):
            if int(some_number) % i == 0:
                return False
        return True

    @staticmethod
    def rotate(some_number):
        return some_number[1: len(some_number)] + some_number[0]

    @staticmethod
    def validate(some_number):
        if not CircularPrime.is_prime(some_number):
            return False
        tmp = some_number
        for i in range(0, len(some_number) - 1):
            tmp = CircularPrime.rotate(tmp)
            if not CircularPrime.is_prime(int(tmp)):
                return False
            CircularPrime.used_numbers.add(tmp)
        return True


def main():
    ten_circular_primes = []
    some_number = "111"
    while len(ten_circular_primes) < 10:
        if CircularPrime.validate(some_number):
            if some_number not in CircularPrime.used_numbers:
                ten_circular_primes.append(some_number)
        some_number = str(int(some_number) + 1)
    print(", ".join(ten_circular_primes))


if __name__ == '__main__':
    main()
