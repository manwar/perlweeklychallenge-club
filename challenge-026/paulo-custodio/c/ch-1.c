/*
Challenge 026

Task #1
Create a script that accepts two strings, let us call it, "stones" and
"jewels". It should print the count of "alphabet" from the string "stones"
found in the string "jewels". For example, if your stones is "chancellor" and
"jewels" is "chocolate", then the script should print "8". To keep it simple,
only A-Z,a-z characters are acceptable. Also make the comparison case
sensitive.
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int count_alphabet(const char* stones, const char* jewels) {
    int count = 0;
    for (const char* p = stones; *p; p++) {
        if (strchr(jewels, *p))
            count++;
    }
    return count;
}

int main(int argc, char* argv[]) {
    if (argc != 3) {
        fputs("Usage: ch-1 stones jewels\n", stderr);
        return EXIT_FAILURE;
    }

    printf("%d\n", count_alphabet(argv[1], argv[2]));
}
