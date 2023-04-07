/*
Challenge 014

Challenge #2
Using only the official postal (2-letter) abbreviations for the 50 U.S.
states, write a script to find the longest English word you can spell? Here
is the list of U.S. states abbreviations as per wikipedia page. This challenge
was proposed by team member Neil Bowers.

For example,
Pennsylvania + Connecticut = PACT
Wisconsin + North Dakota = WIND
Maine + Alabama = MEAL
California + Louisiana + Massachusetts + Rhode Island = Calamari
*/

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <string.h>
#include "utstring.h"
#include "utarray.h"
#include "uthash.h"

struct us_states {
    const char* key;
    const char* name;
    UT_hash_handle hh;
};

struct us_states lut_us_states[] = {
    { "AL", "Alabama" },
    { "AK", "Alaska" },
    { "AZ", "Arizona" },
    { "AR", "Arkansas" },
    { "CA", "California" },
    { "CO", "Colorado" },
    { "CT", "Connecticut" },
    { "DE", "Delaware" },
    { "FL", "Florida" },
    { "GA", "Georgia" },
    { "HI", "Hawaii" },
    { "ID", "Idaho" },
    { "IL", "Illinois" },
    { "IN", "Indiana" },
    { "IA", "Iowa" },
    { "KS", "Kansas" },
    { "KY", "Kentucky" },
    { "LA", "Louisiana" },
    { "ME", "Maine" },
    { "MD", "Maryland" },
    { "MA", "Massachusetts" },
    { "MI", "Michigan" },
    { "MN", "Minnesota" },
    { "MS", "Mississippi" },
    { "MO", "Missouri" },
    { "MT", "Montana" },
    { "NE", "Nebraska" },
    { "NV", "Nevada" },
    { "NH", "New Hampshire" },
    { "NJ", "New Jersey" },
    { "NM", "New Mexico" },
    { "NY", "New York" },
    { "NC", "North Carolina" },
    { "ND", "North Dakota" },
    { "OH", "Ohio" },
    { "OK", "Oklahoma" },
    { "OR", "Oregon" },
    { "PA", "Pennsylvania" },
    { "RI", "Rhode Island" },
    { "SC", "South Carolina" },
    { "SD", "South Dakota" },
    { "TN", "Tennessee" },
    { "TX", "Texas" },
    { "UT", "Utah" },
    { "VT", "Vermont" },
    { "VA", "Virginia" },
    { "WA", "Washington" },
    { "WV", "West Virginia" },
    { "WI", "Wisconsin" },
    { "WY", "Wyoming" },
    { NULL, NULL },
};

struct us_states* lut_states = NULL;

void build_lookup_table() {
    for (struct us_states* p = lut_us_states; p->key != NULL; p++) 
        HASH_ADD_KEYPTR(hh, lut_states, p->key, strlen(p->key), p);
}

const char* lookup_state(const char* str, size_t len) {
    UT_string* str_upper;
    utstring_new(str_upper);
    for (const char* p = str; *p && utstring_len(str_upper) < len; p++)
        utstring_printf(str_upper, "%c", toupper(*p));

    struct us_states* elt;
    HASH_FIND_STR(lut_states, utstring_body(str_upper), elt);

    utstring_free(str_upper);
    return elt ? elt->name : NULL;
}

bool state_words(UT_string* result, const char* word) {
    utstring_clear(result);

    if (strlen(word) % 2 != 0)          // odd number of chars
        return false;

    for (int i = 0; i < strlen(word); i += 2) {
        const char* state = lookup_state(word + i, 2);
        if (state == NULL)
            return false;               // no state found
        utstring_printf(result, "%s%s", i == 0 ? "" : " + ", state);
    }

    return true;
}

char* chomp(char* str) {
    char* p = str + strlen(str) - 1;
    while (p >= str && isspace(*p))
        *p = '\0';
    return str;
}

UT_array* search_words(const char* dictionary) {
    FILE* fp = fopen(dictionary, "r");
    if (fp == NULL) {
        perror(dictionary);
        exit(EXIT_FAILURE);
    }

    // array to return list
    UT_array* words;
    utarray_new(words, &ut_str_icd);

    UT_string* text;
    utstring_new(text);

    size_t curlen = 0;

    char word[BUFSIZ];
    while (fgets(word, sizeof(word), fp)) {
        chomp(word);
        if (state_words(text, word)) {
            if (strlen(word) > curlen) {
                utarray_clear(words);
                char* elt = word;
                utarray_push_back(words, &elt);
                curlen = strlen(word);
            }
            else if (strlen(word) == curlen) {
                char* elt = word;
                utarray_push_back(words, &elt);
            }
        }
    }

    fclose(fp);
    utstring_free(text);
    return words;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 dictionary.txt\n", stderr);
        return EXIT_FAILURE;
    }

    build_lookup_table();
    UT_string* text;
    utstring_new(text);

    UT_array* words = search_words(argv[1]);
    for (char** p = NULL; (p = (char**)utarray_next(words, p)) != NULL; ) {
        if (state_words(text, *p))
            printf("%s = %s\n", *p, utstring_body(text));
    }

    utarray_free(words);
    utstring_free(text);
}
