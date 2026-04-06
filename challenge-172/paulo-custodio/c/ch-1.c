// Perl Weekly Challenge 172 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-172/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

bool is_prime(int n) {
    if (n <= 1)
        return false;
    if (n <= 3)
        return true;
    if ((n % 2) == 0 || (n % 3) == 0)
        return false;
    for (int i = 5; i * i <= n; i += 6)
        if ((n % i) == 0 || (n % (i + 2)) == 0)
            return false;
    return true;
}

int next_prime(int n) {
    if (n < 2)
        return 2;
    for (int p = n+1; true; p++) {
        if (is_prime(p))
            return p;
    }
}

IntArray* get_primes(int n) {
    int p = 2;
    IntArray* primes = intarray_new();
    while (p <= n) {
        intarray_push_back(primes, p);
        p = next_prime(p);
    }
    return primes;
}

IntArray* index_new(int n) {
    IntArray* index = intarray_new();
    for (int i = 0; i < n; i++)
        intarray_push_back(index, i);
    return index;
}

void index_increment(IntArray* index, int limit) {
    int pos = index->size-1;
    while (pos >= 0) {
        index->data[pos]++;
        if (index->data[pos] < limit)
            break;
        else {
            index->data[pos] = 0;
            pos--;
        }
    }
    if (pos < 0)
        die("no solution");
}

bool index_has_duplicates(IntArray* index, int limit) {
    int* freq = xcalloc(limit, sizeof(int));
    for (int i = 0; i < index->size; i++) {
        int n = index->data[i];
        freq[n]++;
        if (freq[n] > 1) {
            xfree(freq);
            return true;
        }
    }
    xfree(freq);
    return false;
}

int primes_sum(IntArray* primes, IntArray* index) {
    int sum = 0;
    for (int i = 0; i < index->size; i++) {
        int idx = index->data[i];
        sum += primes->data[idx];
    }
    return sum;
}

IntArray* select_primes(IntArray* primes, IntArray* index) {
    IntArray* result = intarray_new();
    for (int i = 0; i < index->size; i++) {
        int idx = index->data[i];
        intarray_push_back(result, primes->data[idx]);
    }
    return result;
}

IntArray* get_prime_partition(int m, int n) {
    IntArray* primes = get_primes(m);
    IntArray* index = index_new(n);

    for (; true; index_increment(index, primes->size)) {
        if (index_has_duplicates(index, primes->size))
            continue;

        int sum = primes_sum(primes, index);
        if (sum != m)
            continue;

        IntArray* partition = select_primes(primes, index);
        intarray_free(primes);
        intarray_free(index);
        return partition;
    }
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("usage: %s m n", argv[0]);

    int m = atoi(argv[1]);
    int n = atoi(argv[2]);
    IntArray* partition = get_prime_partition(m, n);
    intarray_print(partition);
    intarray_free(partition);
}
