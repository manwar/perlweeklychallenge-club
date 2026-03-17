#include "../../../challenge-001/paulo-custodio/c/alloc.h"

void shuffle_word(char* p, char* q) {
    p++;    // dont shufle first char
    q--;    // dont shuffle last char
    int len = q - p;
    if (len < 0)
        return;     // less than 2 chars

    for (int i = len - 1; i > 0; i--) {
        int j = rand() % (i + 1); // random index in [0, i]
        SWAP(char, p[i], p[j]);
    }
}

void shuffle_text(char* text) {
    char* p = text;
    while (*p) {
        while (*p && !isalpha(*p))
            p++;
        if (!*p)
            break;
        // p is start of word
        char* q = p;
        while (*q && isalpha(*q))
            q++;
        // q is after end of word
        shuffle_word(p, q);
        p = q;
    }
}

int main(int argc, char* argv[]) {
    if (argc == 2)
        srand(atoi(argv[1]));
    else if (argc != 1)
        die("usage: %s [seed]", argv[0]);

    char line[BUFSIZ];
    while (fgets(line, sizeof(line), stdin)) {
        shuffle_text(line);
        printf("%s", line);
    }
}
