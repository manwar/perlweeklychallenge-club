// Perl Weekly Challenge 182 - Task 2 - solution by Paulo Custodio
// https://theweeklychallenge.org/blog/perl-weekly-challenge-182/

#include "../../../challenge-001/paulo-custodio/c/alloc.h"

int rfind(const char* str, char ch, int len) {
    for (int i = len-1; i >= 0; i--) {
        if (str[i] == ch)
            return i;
    }
    return -1;
}

void get_parent(char* file) {
    int i = rfind(file, '/', strlen(file));
    if (i > 0)
        file[i] = '\0';
    else
        strcpy(file, "/");
}

void collect_common(bool first, Str* common, const char* path_) {
    char* path = xstrdup(path_);
    get_parent(path);

    if (first)
        str_append(common, path);

    while (strcmp(common->body, path) != 0) {
        int len_path = strlen(path);
        int len_common = strlen(common->body);
        if (len_path == len_common) {
            get_parent(path);
            get_parent(common->body);
            str_sync_size(common);
        }
        else if (len_path > len_common) {
            get_parent(path);
        }
        else {
            get_parent(common->body);
            str_sync_size(common);
        }
    }

    xfree(path);
}

int main(int argc, char* argv[]) {
    if (argc < 2)
        die("usage: %s paths...", argv[0]);

    Str* common = str_new();
    for (int i = 1; i < argc; i++)
        collect_common(i==1, common, argv[i]);
    printf("%s\n", common->body);

    str_free(common);
}
