# Weekly Challenge 399

Solutions by ItsMeSamey for [Week 399](https://theweeklychallenge.org/blog/perl-weekly-challenge-399/).

```sh
perl perl/ch-1.pl BAAABAAAA 1
# 8
printf 'dir\n\tfile.txt\n' | perl perl/ch-2.pl
# 12
```

Both scripts use core Perl modules, print one integer and support `--help`.
They can also be loaded with `require` to call their named functions.

`longest_repeating_character($text, $k)` uses a sliding window with character
counts. `longest_absolute_path($text)` tracks path lengths by tab depth and
uses the next entry to identify directories, including dotted directory names.
Both algorithms take linear time and linear storage in the input length.

The CLI accepts UTF-8; lengths count Unicode code points. Task 2 accepts a
multiline argument or stdin. Empty input returns zero, and Task 1 also accepts
`k = 0`. Task 2 accepts CRLF and one final newline. Empty names and depth jumps
produce an error on stderr and exit status 2.

Code is licensed under the [MIT License](LICENSE).
