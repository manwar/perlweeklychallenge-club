' Challenge 203
'
' Task 2: Copy Directory
' Submitted by: Julien Fiegehenn
'
' You are given path to two folders, $source and $target.
'
' Write a script that recursively copy the directory from $source to $target
' except any files.
'
' Example
'
' Input: $source = '/a/b/c' and $target = '/x/y'
'
' Source directory structure:
'
' ├── a
' │   └── b
' │       └── c
' │           ├── 1
' │           │   └── 1.txt
' │           ├── 2
' │           │   └── 2.txt
' │           ├── 3
' │           │   └── 3.txt
' │           ├── 4
' │           └── 5
' │               └── 5.txt
'
' Target directory structure:
'
' ├── x
' │   └── y
'
' Expected Result:
'
' ├── x
' │   └── y
' |       ├── 1
' │       ├── 2
' │       ├── 3
' │       ├── 4
' │       └── 5

# include "dir.bi"

sub get_dirs(path as string, dirs() as string)
    dim i as integer, d as string
    i=0
    d=dir(path & "/*", fbDirectory)
    do while d<>""
        if d<>"." and d<>".." then
            redim preserve dirs(i) as string
            dirs(i)=d
            i=i+1
        end if
        d=dir()
    loop
end sub

sub make_path(path as string)
    dim p as integer
    p=0
    do
        p=instr(p+1, path, "/")
        if p=0 then exit do
        mkdir left(path,p-1)
    loop
    mkdir path
end sub

sub copy_dirs(source as string, target as string)
    dim dirs() as string, i as integer

    get_dirs source, dirs()
    for i=0 to ubound(dirs)
        make_path target & "/" & dirs(i)
        copy_dirs source & "/" & dirs(i), target & "/" & dirs(i)
    next
end sub

copy_dirs command(1), command(2)
