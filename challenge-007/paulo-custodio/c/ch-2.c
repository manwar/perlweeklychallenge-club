/*
Challenge 007

Challenge #2

Word Ladder
A word ladder is a sequence of words [w0, w1, …, wn] such that each word wi
in the sequence is obtained by changing a single character in the word wi-1.
All words in the ladder must be valid English words.

Given two input words and a file that contains an ordered word list,
implement a routine (e.g., find_shortest_ladder(word1, word2, wordlist))
that finds the shortest ladder between the two input words. For example,
for the words cold and warm, the routine might return:

("cold", "cord", "core", "care", "card", "ward", "warm")

However, there’s a shortest ladder:
(“cold”, “cord”, “card”, “ward”, “warm”).

Givens:
All words in the list have the same length.

All words contain only lowercase alphabetical characters.

There are no duplicates in the word list.

The input words aren’t empty and aren’t equal but they have the same length
as any word in the word list.

Requirements:
The routine must return a list of the words in the ladder if it exists.
Otherwise, it returns an empty list.

If any of the input words is the wrong length (i.e., its length is different
to a random from the word list) or isn’t in the word list, return an empty
list.
*/

#include "uthash.h"
#include "utlist.h"
#include <ctype.h>
#include <limits.h>
#include <stdarg.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>

#define MAXLINE         1024

// list of words
typedef struct word_t {
    char* word;
    UT_hash_handle hh;
} word_t;

word_t* all_words = NULL;

// queue of paths to analyse
typedef struct queue_t {
    word_t* path;
    struct queue_t* next, * prev;
} queue_t;

// utils
void die(const char* message, ...) {
    va_list ap;
    va_start(ap, message);
    vfprintf(stderr, message, ap);
    fprintf(stderr, "\n");
    va_end(ap);
    exit(EXIT_FAILURE);
}

void* check_mem(void* p) {
    if (!p) die("Out of memory");
    return p;
}

bool word_is_lower(const char* word) {
    for (const char* p = word; *p; p++)
        if (*p < 'a' || *p > 'z')
            return false;
    return true;
}

void trim(char* str) {
    int len = strlen(str);
    while (len > 0 && isspace(str[len - 1]))
        str[--len] = '\0';
}

// compare words
int word_diff(const char* word1, const char* word2) {
    int diff = 0;
    for (size_t i = 0; i < strlen(word1); i++)
        if (word1[i] != word2[i])
            diff++;
    return diff;
}

// list of words
bool word_list_contains(word_t** phead, const char* word) {
    word_t* elem;
    HASH_FIND_STR(*phead, word, elem);
    return elem != NULL;
}

void word_list_append(word_t** phead, const char* word) {
    // assert word is not already in list
    if (word_list_contains(phead, word))
        die("Word '%s' already in list", word);

    // create new element and append to list
    word_t* elem = check_mem(malloc(sizeof(word_t)));
    elem->word = check_mem(strdup(word));
    HASH_ADD_KEYPTR(hh, *phead, elem->word, strlen(elem->word), elem);
}

void word_list_free(word_t** phead) {
    word_t* elem, * tmp;
    HASH_ITER(hh, *phead, elem, tmp) {
        HASH_DEL(*phead, elem);
        free(elem->word);
        free(elem);
    }
}

const char* word_list_last_word(word_t** phead) {
    word_t* elem;
    word_t* tmp;
    const char* last_word = "";
    HASH_ITER(hh, *phead, elem, tmp)
        last_word = elem->word;
    return last_word;
}

word_t* word_list_next_words(word_t** pladder) {
    word_t* ret = NULL;

    const char* last_word = word_list_last_word(pladder);
    word_t* elem;
    word_t* tmp;
    HASH_ITER(hh, all_words, elem, tmp) {
        const char* word = elem->word;
        if (word_diff(last_word, word) == 1)
            if (!word_list_contains(pladder, word))
                word_list_append(&ret, elem->word);
    }
    return ret;
}

word_t* word_list_clone(word_t** phead) {
    word_t* ret = NULL;
    word_t* elem;
    word_t* tmp;
    HASH_ITER(hh, *phead, elem, tmp)
        word_list_append(&ret, elem->word);
    return ret;
}

void word_list_print(word_t** phead) {
    word_t* elem;
    word_t* tmp;
    printf("(");
    const char* delim = "";
    HASH_ITER(hh, *phead, elem, tmp) {
        printf("%s\"%s\"", delim, elem->word);
        delim = ", ";
    }
    printf(")");
}

// queue of paths
word_t* dequeue(queue_t** phead) {
    queue_t* elem = *phead;
    DL_DELETE(*phead, elem);
    word_t* path = elem->path;
    free(elem);
    return path;
}

void enqueue(queue_t** phead, word_t* path) {
    queue_t* elem = check_mem(malloc(sizeof(queue_t)));
    elem->path = path;
    DL_APPEND(*phead, elem);
}

// read all words with the given length
int word_list_compare(word_t* a, word_t* b) {
    return strcmp(a->word, b->word);
}

void read_words(int len) {
    word_list_free(&all_words);

    FILE* fp = fopen("words.txt", "r");
    char word[MAXLINE];
    if (!fp)
        die("cannot open words.txt");
    while (fgets(word, sizeof(word), fp)) {
        trim(word);
        if (strlen(word) == len && word_is_lower(word))
            word_list_append(&all_words, word);
    }
    fclose(fp);

    HASH_SORT(all_words, word_list_compare);
}

// find shortest ladder
word_t* find_shortest_ladder(const char* word1, const char* word2) {
    // build initial path
    word_t* path = NULL;
    word_list_append(&path, word1);

    // build initial queue
    queue_t* queue = NULL;
    enqueue(&queue, path);
    while (queue) {
        path = dequeue(&queue);         // current path being examined

        // check if finished
        const char* last_word = word_list_last_word(&path);
        if (strcmp(word2, last_word) == 0) {    // found shortest path
            // release memory
            while (queue) {
                word_t* tmp = dequeue(&queue);
                word_list_free(&tmp);
            }
            return path;
        }
        else {
            // find next step
            word_t* next_words = word_list_next_words(&path);

            word_t* elem, * tmp;
            HASH_ITER(hh, next_words, elem, tmp) {
                word_t* new_path = word_list_clone(&path);
                word_list_append(&new_path, elem->word);

                enqueue(&queue, new_path);
            }
        }
    }
    return NULL;
}

int main(int argc, char* argv[]) {
    if (argc != 3)
        die("Usage: ch-2 word1 word2");

    const char* word1 = argv[1];
    const char* word2 = argv[2];

    if (strlen(word1) != strlen(word2))
        die("words must have the same length");

    if (strcmp(word1, word2) == 0)
        die("words must be different");

    if (!word_is_lower(word1) || !word_is_lower(word2))
        die("words must have lower case letters only");

    read_words(strlen(word1));  // reads to all_words

    if (!word_list_contains(&all_words, word1) ||
        !word_list_contains(&all_words, word2))
        die("words not found in dictionary");

    // find sortest ladder
    word_t* shortest_ladder = find_shortest_ladder(word1, word2);
    word_list_print(&shortest_ladder);
    printf("\n");

    // cleanup
    word_list_free(&shortest_ladder);
    word_list_free(&all_words);
    return EXIT_SUCCESS;
}
