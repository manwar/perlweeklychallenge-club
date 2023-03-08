#! /usr/bin/env gforth

\ Challenge 203
\
\ Task 2: Copy Directory
\ Submitted by: Julien Fiegehenn
\
\ You are given path to two folders, $source and $target.
\
\ Write a script that recursively copy the directory from $source to $target
\ except any files.
\
\ Example
\
\ Input: $source = '/a/b/c' and $target = '/x/y'
\
\ Source directory structure:
\
\ ├── a
\ │   └── b
\ │       └── c
\ │           ├── 1
\ │           │   └── 1.txt
\ │           ├── 2
\ │           │   └── 2.txt
\ │           ├── 3
\ │           │   └── 3.txt
\ │           ├── 4
\ │           └── 5
\ │               └── 5.txt
\
\ Target directory structure:
\
\ ├── x
\ │   └── y
\
\ Expected Result:
\
\ ├── x
\ │   └── y
\ |       ├── 1
\ │       ├── 2
\ │       ├── 3
\ │       ├── 4
\ │       └── 5

\ copy text to counted string
: copy_text { addr-from len addr-to -- }
    addr-from addr-to 1+ len CMOVE
    len addr-to C!
;

\ append text to counted string
: cat_text { addr-cstr addr-from len-from -- }
    addr-from  addr-cstr COUNT +  len-from  CMOVE
    addr-cstr C@ len-from + addr-cstr C!
;

\ concat two paths
: cat_paths { target addr-path1 len-path1 addr-path2 len-path2 -- }
    0 target C!
    target addr-path1 len-path1 cat_text
    target S" /" cat_text
    target addr-path2 len-path2 cat_text
;

: is_dot_dot_dot { cstr -- f }
    cstr COUNT S" ." COMPARE 0=
    cstr COUNT S" .." COMPARE 0= OR
;

: is_dir { cstr -- f }
    cstr COUNT OPEN-DIR 0= IF \ ok
        CLOSE-DIR THROW
        TRUE
    ELSE
        DROP
        FALSE
    THEN
;

\ copy dirs
: copy_dirs { source-addr target-addr -- }
    source-addr COUNT OPEN-DIR THROW { dirid }
    256 ALLOCATE THROW { fname }
    BEGIN fname 1+ 255 dirid READ-DIR THROW WHILE
        fname C!
        fname is_dot_dot_dot 0= IF
            256 ALLOCATE THROW { source-file }
            source-file source-addr COUNT fname COUNT cat_paths

            256 ALLOCATE THROW { target-file }
            target-file target-addr COUNT fname COUNT cat_paths

            source-file is_dir IF
                target-file COUNT  [ 8 BASE ! 777 DECIMAL ] LITERAL
                MKDIR-PARENTS THROW
            THEN

            source-file FREE THROW
            target-file FREE THROW
        THEN
    REPEAT
    fname FREE THROW
;

\ file names
CREATE source_dir 256 ALLOT
CREATE target_dir 256 ALLOT

NEXT-ARG DUP 0= THROW source_dir copy_text
NEXT-ARG DUP 0= THROW target_dir copy_text
source_dir target_dir copy_dirs
BYE
