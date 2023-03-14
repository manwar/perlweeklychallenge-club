/*
Challenge 203

Task 2: Copy Directory
Submitted by: Julien Fiegehenn

You are given path to two folders, $source and $target.

Write a script that recursively copy the directory from $source to $target
except any files.

Example

Input: $source = '/a/b/c' and $target = '/x/y'

Source directory structure:

├── a
│   └── b
│       └── c
│           ├── 1
│           │   └── 1.txt
│           ├── 2
│           │   └── 2.txt
│           ├── 3
│           │   └── 3.txt
│           ├── 4
│           └── 5
│               └── 5.txt

Target directory structure:

├── x
│   └── y

Expected Result:

├── x
│   └── y
|       ├── 1
│       ├── 2
│       ├── 3
│       ├── 4
│       └── 5
*/

#define MAX_PATH    1024

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <dirent.h>

const char* cat_path(const char* dir, const char* file) {
    static char path[MAX_PATH];
    assert(strlen(dir)+1+strlen(file)+1 < MAX_PATH);

    strcpy(path, dir);
    strcat(path, "/");
    strcat(path, file);
    return path;
}

void os_mkdir(const char* path) {
#ifdef _WIN32
    mkdir(path);
#else
    mkdir(path, 0777);
#endif
}

void make_path(const char* path) {
    char dir[MAX_PATH];
    const char* p = path;
    const char* p0 = p;

    while ((p = strchr(p0, '/')) != NULL) {
        strcpy(dir, path);
        dir[p-path] = '\0';

        os_mkdir(dir);
        p0 = p + 1;
    }
    os_mkdir(path);
}

void copy_dirs(const char* source, const char* target) {
    DIR *dp;
    struct dirent *ep;
    dp = opendir(source);
    if (dp != NULL) {
        while ((ep = readdir(dp)) != NULL)  {
            if (strcmp(ep->d_name, ".") != 0 && strcmp(ep->d_name, "..") != 0) {
                char source_file[MAX_PATH];
                strcpy(source_file, cat_path(source, ep->d_name));

                struct stat statbuf;
                if (stat(source_file, &statbuf) == 0) {
                    if ((statbuf.st_mode & S_IFMT) == S_IFDIR) {
                        char target_file[MAX_PATH];
                        strcpy(target_file, cat_path(target, ep->d_name));

                        make_path(target_file);
                        copy_dirs(source_file, target_file);
                    }
                }
            }
        }
        closedir(dp);
    }
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 2)
        fputs("usage: ch-1 source target", stderr);
    else {
        copy_dirs(argv[0], argv[1]);
    }
}
