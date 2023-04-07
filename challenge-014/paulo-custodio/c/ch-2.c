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

// string array
typedef struct {
    size_t count;
    char** strs;
} StringArray;

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

StringArray* strs_new() {
    StringArray* arr = check_mem(calloc(1, sizeof(StringArray)));
    arr->strs = check_mem(calloc(1, sizeof(char*)));
    return arr;
}

void strs_clear(StringArray* arr) {
    for (size_t i = 0; i < arr->count; i++)
        free(arr->strs[i]);
    arr->count = 0;
    arr->strs[0] = NULL;
}

void strs_free(StringArray* arr) {
    strs_clear(arr);
    free(arr->strs);
    free(arr);
}

void strs_push(StringArray* arr, const char* str) {
    arr->strs = check_mem(realloc(arr->strs, (arr->count + 2) * sizeof(char*)));
    arr->strs[arr->count++] = check_mem(strdup(str));
    arr->strs[arr->count] = NULL;
}

void strs_pop(StringArray* arr) {
    free(arr->strs[--arr->count]);
    arr->strs[arr->count] = NULL;
}

int compare(const void* a, const void* b) {
    return strcmp(*(const char**)a, *(const char**)b);
}

void strs_sort(StringArray* arr) {
    qsort(arr->strs, arr->count, sizeof(char*), compare);
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

StringArray* search_words(const char* dictionary) {
    FILE* fp = fopen(dictionary, "r");
    if (fp == NULL) {
        perror(dictionary);
        exit(EXIT_FAILURE);
    }

    // array to return list
    StringArray* words = strs_new();
    int curlen = 0;

    char word[BUFSIZ];
    while (fgets(word, sizeof(word), fp)) {
        chomp(word);
        char* text = state_words(word);
        if (text != NULL) {
            if (strlen(word) > curlen) {
                strs_clear(words);
                strs_push(words, word);
                curlen = strlen(word);
            }
            else if (strlen(word) == curlen) {
                strs_push(words, word);
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

    StringArray* words = search_words(argv[1]);
    for (char** p = words->strs; *p != NULL; p++) {
        char* text = state_words(*p);
        printf("%s = %s\n", *p, text);
        free(text);
    }

    strs_free(words);
}
