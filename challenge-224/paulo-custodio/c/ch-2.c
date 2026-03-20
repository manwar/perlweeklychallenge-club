// Perl Weekly Challenge 224 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-224/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int substr_atoi(const char* str, int len) {
    char* num = xstrndup(str, len);
    int value = atoi(num);
    xfree(num);
    return value;
}

bool is_adictive_sequence_sub(IntArray* seq, const char* remaining) {
    if (seq->size >= 3 && seq->data[seq->size-3] + seq->data[seq->size-2] != seq->data[seq->size-1])
        return false;   // last three numbers don't form a sequence
    if (seq->size >= 3 && remaining[0] == '\0')
        return true;    // found a solution
    if (remaining[0] == '\0')
        return false;   // no solution

    // add one number to the sequence and recurse
    for (int len = 1; len <= strlen(remaining); len++) {
        int next = substr_atoi(remaining, len);
        intarray_push_back(seq, next);
        bool found = is_adictive_sequence_sub(seq, remaining+len);
        intarray_pop_back(seq);
        if (found)
            return true;
    }
    return false;
}

bool is_adictive_sequence(const char* digits) {
    IntArray* seq = intarray_new();
    bool found = is_adictive_sequence_sub(seq, digits);
    intarray_free(seq);
    return found;
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s digits", argv[0]);

    bool ok = is_adictive_sequence(argv[1]);
    printf("%s\n", bool_to_string(ok));
}
