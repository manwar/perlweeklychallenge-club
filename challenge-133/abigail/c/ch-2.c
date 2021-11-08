# include <stdlib.h>
# include <stdio.h>
# include <string.h>

/*
 * Run as: cc -o ch-2.o ch-2.c; ./ch-2.o
 */

/*
 * The first 10 Smith numbers are all than 1000, so they will
 * have at most one prime factor which exceeds 31. They also will
 * have at most 9 prime factors, as 2^10 > 1000.
 */
short small_primes [] = {2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31};
# define SMALL_PRIMES_SIZE 11
# define MAX_FACTORS        9

/*
 * The number of Smith numbers we are after. If you increase this, you
 * may have to update the values above.
 */
# define COUNT             10
# define BASE              10

/*
 * Factorize a number, given a set of small primes. This will work
 * for numbers up to, but not including, p^2, where p is the smallest
 * prime not included in the set. For the given set, the smallest number
 * which fails to factorize is 37^2 == 1369.
 */
size_t factorize (short n, short * factors) {
    size_t f_i = 0;   /* Index in output structure */
    
    for (size_t i = 0; i < SMALL_PRIMES_SIZE && n > 1; i ++) {
        short prime = small_primes [i];
        while (n % prime == 0) {
            factors [f_i ++] = prime;
            n /= prime;
        }
    }
    /*
     * Possible left over large prime
     */
    if (n > 1) {
        factors [f_i ++] = n;
    }

    return (f_i);
}

/*
 * Return the sum of the digits of all the numbers in the array 'numbers'.
 * We do this by taking each number, and repeatedly modding and dividing 
 * each by 10.
 */
short digitsum (size_t n, short * numbers) {
    short out = 0;
    char * tmp;
    for (size_t i = 0; i < n; i ++) {
        short number = numbers [i];
        while (number) {
            out    += number % BASE;
            number /= BASE;
        }
    }
    return (out);
}


int main () {
    short * factors;
    if ((factors = (short *) malloc (MAX_FACTORS * sizeof (short))) == NULL) {
        perror ("Malloc failed");
        exit (1);
    }

    size_t c = 0;
    short  n = 0;

    while (c < COUNT) {
        size_t fc = factorize (++ n, factors);
        if (fc > 1 && digitsum (1, &n) == digitsum (fc, factors)) {
            printf ("%d\n", n);
            c ++;
        }
    }
    free (factors);
}
