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

#include <iostream>
#include <filesystem>

namespace fs = std::filesystem;

void copy_dirs(const fs::path& source, const fs::path& target) {
    for (auto& dir_entry : fs::directory_iterator(source)) {
        if (dir_entry.is_directory()) {
            fs::path target_dir = target / dir_entry.path().filename();
            fs::create_directories(target_dir);
            copy_dirs(dir_entry, target_dir);
        }
    }
}

int main(int argc, char* argv[]) {
    argv++; argc--;
    if (argc != 2)
        std::cerr << "usage: ch-1 source target" << std::endl;
    else {
        copy_dirs(fs::path(argv[0]), fs::path(argv[1]));
    }
}
