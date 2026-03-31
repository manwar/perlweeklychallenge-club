// Perl Weekly Challenge 193 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-193/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"
#include <ctype.h>

#define INDEX(c)    (tolower((unsigned char)(c)) - 'a')

typedef struct {
    char* text;
    char* key;  // string with list of differences
} Diff;

typedef struct {
    char* key;
    int count;
} Freq;

Diff* diff_new(const char* text) {
    Str* diffs = str_new();
    for (int i = 0; i < strlen(text)-1; i++) {
        int n = INDEX(text[i+1]) - INDEX(text[i]);
        str_printf(diffs, "%d ", n);
    }

    Diff* diff = xmalloc(sizeof(Diff));
    diff->text = xstrdup(text);
    diff->key = xstrdup(diffs->body);

    str_free(diffs);

    // store a key
    return diff;
}

void diff_free(Diff* diff) {
    xfree(diff->text);
    xfree(diff->key);
    xfree(diff);
}

Freq* freq_new(const char* key) {
    Freq* freq = xmalloc(sizeof(Freq));
    freq->key = xstrdup(key);
    freq->count = 1;
    return freq;
}

void freq_free(Freq* freq) {
    xfree(freq->key);
    xfree(freq);
}

void add_freq(Freq** freqs, int* num_freq, const char* key) {
    // search exisiting
    for (int i = 0; i < *num_freq; i++) {
        if (strcmp(key, freqs[i]->key) == 0) {
            freqs[i]->count++;
            return;
        }
    }

    // not found, add one
    freqs[*num_freq] = freq_new(key);
    (*num_freq)++;
}

int main(int argc, char* argv[]) {
    if (argc < 4)
        die("usage: %s words...", argv[0]);

    // create list of differences for each word
    int num_diffs = argc-1;
    Diff** diffs = xmalloc(num_diffs * sizeof(Diff*));
    for (int i = 0; i < num_diffs; i++)
        diffs[i] = diff_new(argv[i+1]);

    // create frequency map
    Freq** freqs = xmalloc(num_diffs * sizeof(Freq*));
    int num_freq = 0;
    for (int i = 0; i < num_diffs; i++) {
        add_freq(freqs, &num_freq, diffs[i]->key);
    }

    // get first key with count 1
    int found = -1;
    for (int i = 0; i < num_freq; i++) {
        if (freqs[i]->count == 1) {
            found = i;
            break;
        }
    }

    if (found < 0) {    // not found
        printf(".\n");
    }
    else {              // at least one exists, print the first
        for (int i = 0; i < num_diffs; i++) {
            if (strcmp(freqs[found]->key, diffs[i]->key) == 0) {
                printf("%s\n", diffs[i]->text);
                break;
            }
        }
    }

    // free list of differences
    for (int i = 0; i < num_diffs; i++)
        diff_free(diffs[i]);
    xfree(diffs);

    // free frequency map
    for (int i = 0; i < num_freq; i++)
        freq_free(freqs[i]);
    xfree(freqs);
}
