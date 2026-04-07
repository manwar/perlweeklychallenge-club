// Perl Weekly Challenge 166 - Task 1 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-166/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

const char* LETTERS = "abcdefolist";
const char* REPLACE = "abcdef01157";

void trim(char* str) {
    int len = strlen(str);
    while (len > 0 && isspace(str[len-1]))
        str[--len] = '\0';
}

bool match_word(const char* word) {
    int len = strlen(word);
    if (len < 2 || len > 8)
        return false;
    for (int i = 0; i < len; i++) {
        if (strchr(LETTERS, tolower(word[i])) == NULL)  // not found
            return false;
    }
    return true;
}

char* convert_hex(const char* word) {
    // create word with 0x prefix
    int len = strlen(word);
    char* hex_word = xmalloc(len + 3);  // word + 0x + null terminator
    sprintf(hex_word, "0x%s", word);

    // make upper case and translate letters
    for (int i = 2; i < len+2; i++) {   // skip 0x
        char ch = tolower(hex_word[i]);
        char* p = strchr(LETTERS, ch);
        if (p != NULL) {
            ch = REPLACE[p - LETTERS];
        }
        ch = toupper(ch);
        hex_word[i] = ch;
    }

    return hex_word;
}

void print_matched_words(const char* filename) {
    FILE* fp = fopen(filename, "r");
    if (fp == NULL)
        die("file %s open failed", filename);

    char line[BUFSIZ];
    while (fgets(line, sizeof(line), fp) != NULL) {
        trim(line);
        if (match_word(line)) {
            char* hex_word = convert_hex(line);
            printf("%s\n", hex_word);
            xfree(hex_word);
        }
    }
    fclose(fp);
}

int main(int argc, char* argv[]) {
    if (argc != 2)
        die("usage: %s dictionary", argv[0]);

    print_matched_words(argv[1]);
}
