// Perl Weekly Challenge 216 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-216/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

// Count stickers using multiset logic
int count_stickers(const char* word, StrArray* stickers) {
    int need[26] = {0};
    for (const char* p = word; *p; p++) {
        if (*p < 'a' || *p > 'z')
            return 0; // assume only lowercase letters are valid
        need[*p - 'a']++;
    }

    int count = 0;

    while (1) {
        // check if we're done
        bool done = true;
        for (int c = 0; c < 26; c++) {
            if (need[c] > 0) {
                done = false;
                break;
            }
        }
        if (done)
            return count;

        int best_id = -1;
        int best_match = 0;

        // choose sticker that covers most remaining letters
        for (int id = 0; id < stickers->size; id++) {
            const char* s = stickers->data[id];
            int freq[26] = {0};
            for (const char* p = s; *p; p++) {
                if (*p < 'a' || *p > 'z')
                    return 0; // assume only lowercase letters are valid
                freq[*p - 'a']++;
            }
            int match = 0;
            for (int c = 0; c < 26; c++) {
                int m = MIN(need[c], freq[c]);
                match += m;
            }

            if (match > best_match) {
                best_match = match;
                best_id = id;
            }
        }

        // no sticker can help further ? impossible
        if (best_match == 0)
            return 0;

        // apply best sticker: subtract its contribution from need[]
        const char* best = stickers->data[best_id];
        int freq_best[26] = {0};
        for (const char* p = best; *p; p++)
            freq_best[*p - 'a']++;

        for (int c = 0; c < 26; c++) {
            int use = MIN(need[c], freq_best[c]);
            need[c] -= use;
        }

        count++;
    }
}

// Entry point
int main(int argc, char* argv[])
{
    if (argc < 3) {
        fprintf(stderr, "usage: %s word stickers...\n", argv[0]);
        return 1;
    }

    const char* word = argv[1];
    StrArray* stickers = strarray_new();

    for (int i = 2; i < argc; i++)
        strarray_push_back(stickers, argv[i]);

    int count = count_stickers(word, stickers);
    printf("%d\n", count);

    strarray_free(stickers);
    return 0;
}
