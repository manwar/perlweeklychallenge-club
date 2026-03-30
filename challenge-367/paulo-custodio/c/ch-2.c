// Perl Weekly Challenge 367 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-367/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

typedef struct {
    int s;
    int e;
} Interval;

#define NUM_INTERVALS   2
#define DAY             (24*60)

int parse_hhmm(const char* str) {
    assert(strlen(str) == 5 && str[2] == ':');
    return 60*atoi(str)+atoi(str+3);
}

Interval parse_interval(const char* s, const char* e) {
    Interval i;
    i.s = parse_hhmm(s);
    i.e = parse_hhmm(e);
    return i;
}

void normalize_interval(Interval* out, Interval in) {
    // Interval does not cross midnight
    if (in.e >= in.s) {
        out[0].s = in.s;
        out[0].e = in.e;
        out[1].s = in.s+DAY;
        out[1].e = in.e+DAY;
    }
    // Interval crosses midnight: e.g. 23:30 ? 00:30
    else {
        out[0].s = in.s;
        out[0].e = in.e+DAY;
        out[1].s = in.s-DAY;
        out[1].e = in.e;
    }
}

bool check_overlap(Interval a, Interval b) {
    Interval A[NUM_INTERVALS];
    Interval B[NUM_INTERVALS];

    normalize_interval(A, a);
    normalize_interval(B, b);

    // Check overlap for all pairings of normalized forms
    for (int i = 0; i < NUM_INTERVALS; i++) {
        for (int j = 0; j < NUM_INTERVALS; j++) {
            if (A[i].s < B[j].e && B[j].s < A[i].e)
                return true;
        }
    }

    return false;
}

int main(int argc, char* argv[]) {
    if (argc != 5)
        die("usage: %s hh:mm hh:mm hh:mm hh:mm", argv[0]);

    Interval a = parse_interval(argv[1], argv[2]);
    Interval b = parse_interval(argv[3], argv[4]);
    bool overlap = check_overlap(a, b);
    printf("%s\n", bool_to_string(overlap));
}
