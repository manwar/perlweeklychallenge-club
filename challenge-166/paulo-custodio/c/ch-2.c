// Perl Weekly Challenge 166 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-166/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

#include <dirent.h>
#include <sys/stat.h>
#include <unistd.h>

#define WIDTH 16

StrArray* read_dir(const char* dirname) {
    StrArray* result = strarray_new();

    DIR *dir = opendir(dirname);
    if (!dir) {
        perror("opendir");
        die("directory %s open failed", dirname);
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strcmp(entry->d_name, ".") == 0 ||
            strcmp(entry->d_name, "..") == 0) {
            continue;
        }

        Str* pathname = str_new();
        str_printf(pathname, "%s/%s", dirname, entry->d_name);
        struct stat st;
        if (stat(pathname->body, &st) == 0) {
            if (S_ISDIR(st.st_mode)) {
                Str* dir_entry = str_new();
                str_printf(dir_entry, "%s/", entry->d_name);
                strarray_push_back(result, dir_entry->body);
                str_free(dir_entry);
            }
            else if (S_ISREG(st.st_mode)) {
                strarray_push_back(result, entry->d_name);
            }
        }
        str_free(pathname);
    }

    closedir(dir);

    strarray_sort(result);
    return result;
}

void print_header(char* argv[], int argc) {
    for (int i = 0; i < argc; i++) {
        printf("%-*s", WIDTH, argv[i]);
        if (i+1 < argc)
            printf(" | ");
    }
    printf("\n");
    for (int i = 0; i < argc; i++) {
        for (int c = 0; c < WIDTH; c++)
            putchar('-');
        if (i+1 < argc)
            printf(" | ");
    }
    printf("\n");
}

StrArray* collect_files(StrArray** dirs, int size) {
    StrArray* files = strarray_new();
    for (int i = 0; i < size; i++) {
        StrArray* dir = dirs[i];
        for (int j = 0; j < dir->size; j++) {
            strarray_push_back(files, dir->data[j]);
        }
    }
    strarray_uniq(files);
    return files;
}

void print_diffs(StrArray** dirs, int size) {
    StrArray* files = collect_files(dirs, size);
    for (int r = 0; r < files->size; r++) {
        const char* file = files->data[r];

        // check if file exists in all directories
        bool* found = xcalloc(size, sizeof(bool));
        int num_found = 0;
        for (int c = 0; c < size; c++) {
            StrArray* dir = dirs[c];
            if (strarray_find_index(dir, file) >= 0) {
                found[c] = true;
                num_found++;
            }
        }

        if (num_found != size) {
            for (int c = 0; c < size; c++) {
                if (found[c])
                    printf("%-*s", WIDTH, file);
                else
                    printf("%-*s", WIDTH, "");
                if (c+1 < size)
                    printf(" | ");
            }
            printf("\n");
        }

        xfree(found);
    }

    strarray_free(files);
}

int main(int argc, char* argv[]) {
    if (argc < 3)
        die("usage: %s dirs...", argv[0]);

    argv++; argc--;
    StrArray** dirs = xmalloc(argc * sizeof(StrArray*));
    for (int i = 0; i < argc; i++)
        dirs[i] = read_dir(argv[i]);

    print_header(argv, argc);
    print_diffs(dirs, argc);

    for (int i = 0; i < argc; i++)
        strarray_free(dirs[i]);
    xfree(dirs);
}
