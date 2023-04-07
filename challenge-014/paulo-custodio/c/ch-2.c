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

#include <assert.h>
#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define LU_IDX(a,b) (((a)-'A')*26 + ((b)-'A'))

struct us_states {
    const char* key;
    const char* name;
};

struct us_states lut_us_states[] = {
    {"AL", "Alabama"},
    {"AK", "Alaska"},
    {"AZ", "Arizona"},
    {"AR", "Arkansas"},
    {"CA", "California"},
    {"CO", "Colorado"},
    {"CT", "Connecticut"},
    {"DE", "Delaware"},
    {"FL", "Florida"},
    {"GA", "Georgia"},
    {"HI", "Hawaii"},
    {"ID", "Idaho"},
    {"IL", "Illinois"},
    {"IN", "Indiana"},
    {"IA", "Iowa"},
    {"KS", "Kansas"},
    {"KY", "Kentucky"},
    {"LA", "Louisiana"},
    {"ME", "Maine"},
    {"MD", "Maryland"},
    {"MA", "Massachusetts"},
    {"MI", "Michigan"},
    {"MN", "Minnesota"},
    {"MS", "Mississippi"},
    {"MO", "Missouri"},
    {"MT", "Montana"},
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

const char* lut_states[LU_IDX('Z', 'Z') + 1];

void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

void build_lookup_table() {
    for (struct us_states* p = lut_us_states; p->key != NULL; p++) {
        int idx = LU_IDX(toupper(p->key[0]), toupper(p->key[1]));
        assert(lut_states[idx] == NULL);
        lut_states[idx] = p->name;
    }
}

const char* lookup_state(const char* str) {
    if (!isalpha(str[0]) || !isalpha(str[1]))
        return NULL;
    else {
        int idx = LU_IDX(toupper(str[0]), toupper(str[1]));
        return lut_states[idx];
    }
}

char* state_words(const char* word) {
    char text[BUFSIZ];

    if (strlen(word) % 2 != 0)          // odd number of chars
        return NULL;

    text[0] = '\0';
    const char* sep = "";
    for (int i = 0; i < strlen(word); i += 2) {
        const char* state = lookup_state(word + i);
        if (state == NULL)
            return NULL;                // no state found
        sprintf(text + strlen(text), "%s%s", sep, state);
        sep = " + ";
    }

    return check_mem(strdup(text));
}

char* chomp(char* str) {
    char* p = str + strlen(str) - 1;
    while (p >= str && isspace(*p))
        *p = '\0';
    return str;
}

char** search_words(const char* dictionary) {
    FILE* fp = fopen(dictionary, "r");
    if (fp == NULL) {
        perror(dictionary);
        exit(EXIT_FAILURE);
    }

    // array to return list
    int N = 0;
    char** words = check_mem(malloc((N + 1) * sizeof(char*)));
    words[0] = NULL;
    int curlen = 0;

    char word[BUFSIZ];
    while (fgets(word, sizeof(word), fp)) {
        chomp(word);
        char* text = state_words(word);
        if (text != NULL) {
            if (strlen(word) > curlen) {
                for (int i = 0; i < N; i++)
                    free(words[i]);
                N = 1;
                words = check_mem(realloc(words, (N + 1) * sizeof(char*)));
                words[0] = check_mem(strdup(word));
                words[1] = NULL;
                curlen = strlen(word);
            }
            else if (strlen(word) == curlen) {
                N++;
                words = check_mem(realloc(words, (N + 1) * sizeof(char*)));
                words[N - 1] = check_mem(strdup(word));
                words[N] = NULL;
            }
            free(text);
        }
    }

    fclose(fp);

    return words;
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fputs("usage: ch-2 dictionary.txt\n", stderr);
        return EXIT_FAILURE;
    }

    build_lookup_table();

    char** words = search_words(argv[1]);
    for (char** p = words; *p != NULL; p++) {
        char* text = state_words(*p);
        printf("%s = %s\n", *p, text);
        free(text);
    }

    free(words);
}
