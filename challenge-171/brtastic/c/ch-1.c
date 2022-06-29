#include <stdio.h>

int sum_divisors (int number)
{
	int sum = 0;
	int i;
	for (i = 1; i <= number / 2; ++i) {
		if (number % i == 0)
			sum += i;
	}

	return sum;
}

int get_next_abundant_odd (int current)
{
	for (;; ++current) {
		if (current % 2 != 0 && sum_divisors(current) > current)
			return current;
	}
}

int main()
{
	int next = 0;
	int i;

	for (i = 0; i < 20; ++i) {
		next = get_next_abundant_odd(next + 1);
		printf("%d\n", next);
	}

	return 0;
}

