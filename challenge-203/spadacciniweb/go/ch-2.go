/*
Task 2: Copy Directory
Submitted by: Julien Fiegehenn

You are given path to two folders, $source and $target.
Write a script that recursively copy the directory from $source to $target except any files.

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

package main

import (
    "fmt"
    "log"
    "path/filepath"
    "os"
    "strings"
)

func main() {
    var dirs []string
    var source string
    var target string

    fmt.Print("path source: ")
    fmt.Scanf("%s", &source)

    fileInfo, err := os.Stat(source)
    if err != nil {
        log.Fatal(err)
    } else if !fileInfo.IsDir() {
        log.Fatalf("%s directory does not exist.", source)
    }

    fmt.Print("path target: ")
    fmt.Scanf("%s", &target)

    fileInfo, err = os.Stat(target)
    if err != nil {
        log.Fatal(err)
    } else if !fileInfo.IsDir() {
        log.Fatalf("%s directory does not exist.", target)
    }

    err = filepath.Walk(source, func(path string, info os.FileInfo, err error) error {
        if err != nil {
            return err
        }
        if info.IsDir() {
            if len(path) > len(source) {
                dirFmt := path[len(source)+1:]
                dirs = append(dirs, dirFmt)
            }
        }
        return err
    })

    if err != nil {
        log.Println(err)
    }

    for _, currDir := range dirs {
        outDir := strings.Join( []string{target, currDir}, "/")
        err := os.Mkdir(outDir, 0750)
        if err != nil && !os.IsExist(err) {
            log.Fatal(err)
        }
    }
}
