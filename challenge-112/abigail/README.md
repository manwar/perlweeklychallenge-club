# Solutions by Abigail
## [Canonical Path](https://perlweeklychallenge.org/blog/perl-weekly-challenge-112/#TASK1)

> You are given a string path, starting with a slash `/`.
>
> Write a script to convert the given absolute path to the simplified
> canonical path.
>
> In a Unix-style file system:
>
> * A period `.` refers to the current directory.
> * A double period `..` refers to the directory up a level.
> * Multiple consecutive slashes (`//`) are treated as a single slash `/`.
>
> The canonical path format:
>
> * The path starts with a single slash `/`.
> * Any two directories are separated by a single slash `/`.
> * The path does not end with a trailing `/`.
> * The path only contains the directories on the path from the root
>   directory to the target file or directory

### Example
~~~~
Input: "/a/"
Output: "/a"

Input: "/a/b//c/"
Output: "/a/b/c"

Input: "/a/b/c/../.."
Output: "/a"
~~~~

### Solutions
* [AWK](awk/ch-1.awk)
* [Bash](bash/ch-1.sh)
* [C](c/ch-1.c)
* [Lua](lua/ch-1.lua)
* [Node.js](node/ch-1.js)
* [Perl](perl/ch-1.pl)
* [Python](python/ch-1.py)
* [Ruby](ruby/ch-1.rb)

### Blog

## [Climb Stairs](https://perlweeklychallenge.org/blog/perl-weekly-challenge-112/#TASK2)

> You are given `$n` steps to climb
>
> Write a script to find out the distinct ways to climb to the top.
> You are allowed to climb either 1 or 2 steps at a time.

### Notes
This is just finding the `$n + 1` Fibonacci number.


### Solutions
* [AWK](awk/ch-2.awk)
* [Bash](bash/ch-2.sh)
* [C](c/ch-2.c)
* [Go](go/ch-2.go)
* [Lua](lua/ch-2.lua)
* [Node.js](node/ch-2.js)
* [Perl](perl/ch-2.pl)
* [Pascal](pascal/ch-2.p)
* [Python](python/ch-2.py)
* [Ruby](ruby/ch-2.rb)
* [Scheme](scheme/ch-2.scm)

### Blog
