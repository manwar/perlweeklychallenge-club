// Perl Weekly Challenge 171 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-171/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef int (*func_t)(int);

struct composed_ctx {
    func_t f1;
    func_t f2;
};

int composed(void *ctx, int x) {
    struct composed_ctx *c = ctx;
    return c->f1(c->f2(x));
}

int times3(int n) {
    return 3 * n;
}

int times5(int n) {
    return 5 * n;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s n", argv[0]);

    int n = atoi(argv[1]);
    struct composed_ctx c = { times3, times5 };
    int r = composed(&c, n);
    printf("%d\n", r);
}
