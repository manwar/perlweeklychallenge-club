/*
Challenge 098

TASK #1 › Read N-characters
Submitted by: Mohammad S Anwar
You are given file $FILE.

Create subroutine readN($FILE, $number) returns the first n-characters and
moves the pointer to the (n+1)th character.

Example:
Input: Suppose the file (input.txt) contains "1234567890"
Output:
    print readN("input.txt", 4); # returns "1234"
    print readN("input.txt", 4); # returns "5678"
    print readN("input.txt", 4); # returns "90"
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

// store list of seen files
typedef struct File {
    char*   filename;
    FILE*   fp;
} File;

File* files = NULL;
int num_files = 0;

// memory allocation
void* check_mem(void* p) {
    if (!p) {
        fputs("Out of memory", stderr);
        exit(EXIT_FAILURE);
    }
    return p;
}

// add a new file, return FILE*
FILE* next_file(const char* filename) {
    // find in already open files
    for (int i = 0; i < num_files; i++) {
        if (strcmp(filename, files[i].filename)==0)
            return files[i].fp;     // found, return
    }

    // extend array and open a new file
    int i = num_files++;
    files = check_mem(realloc(files, (num_files)*sizeof(File)));
    files[i].filename = check_mem(strdup(filename));
    files[i].fp = fopen(filename, "r");
    if (!files[i].fp) {
        perror(filename);
        exit(EXIT_FAILURE);
    }

    return files[i].fp;
}

void free_files(void) {
    if (files) {
        for (int i = 0; i < num_files; i++) {
            free(files[i].filename);
            fclose(files[i].fp);
        }
        free(files);
        files = NULL;
        num_files = 0;
    }
}

// read next N chars from file, user must free memory
char* readN(const char* filename, int num) {
    FILE* fp = next_file(filename);
    char* text = check_mem(malloc(num+1));
    int n_read = fread(text, 1, num, fp);
    text[n_read] = '\0';
    return text;
}

int main(int argc, char* argv[]) {
    for (int i = 1; i+1 < argc; i+=2) {
        char* text = readN(argv[i], atoi(argv[i+1]));
        printf("%s\n", text);
        free(text);
    }
    free_files();
}
