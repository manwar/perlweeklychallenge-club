<!--
SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
SPDX-License-Identifier: BSD-2-Clause
-->

# Peter Pentchev's solutions to PWC 287

\[[Home][ringlet-home] | [GitHub][github]\]

## Overview

This directory contains Peter Pentchev's solutions to the two tasks in
the [Perl & Raku Weekly Challenge 287][pwc-287].

## General remarks

### Task 1: Strong Password

#### What we have to do

There are three things that could be wrong with a string:

- it may be too short
- it may not have characters of enough distinct classes
- it may have one or more too long runs of repeating characters

#### What we can do

There are two actions that we will perform on a string to improve its strength as
a password:

- add a character to the end; this may increase the string length if necessary and
  also mark another character class as represented in the string
- replace a character within the string; this may mark another character class as
  represented, and also break a long run of characters

Note that we will not delete characters from the string at all; there is no case in
which deleting a character will lead to fewer steps in strengthening a password.

It is always possible to add a character to the end of the string in such a way that
it is in a different character class than the one before it (if the string is not empty).
An even stronger assertion is that if a string does not yet contain characters of
a specific class, it is always possible to add a character to the end in such a way that
the new one will be in the required class, so that a single change will improve
the password strength in two ways at the same time.

Since there are three different character classes, it is also always possible to
replace an existing character in such a way that the class of the new one is not
the same as the class of either the previous or the next character (if those exist).
An even stronger assertion is that if a string does not yet contain characters of
a specific class, it is always possible to replace a specific character so that
the new one will be in the required class, so that a single change will improve
the password strength in two ways at the same time.

#### Examining a string

The exact character classes of the specific characters within the string or the ones
added or replaced do not really matter; they are practically interchangeable.
For the purposes of judging a string's password strength it is enough to count
the different classes, no need to keep track of which ones are represented.
This means that we can define a function that examines a string and reports on three of
its aspects:

- its length in characters as a single number
- the number of character classes already represented in it
- a set (possibly empty) of numbers representing the lengths of the different runs of
  repeating characters (three or more) within the string

Once we have examined a string, we can start "fixing" it, improving the strength of
the password.

#### Fixing long runs of characters

If there are any long runs, then it is mandatory to fix them.
This can be done by replacing as many characters as necessary in each run to break it into
pieces of two or more characters.
The number of characters to replace in each run is equal to the length of the run
divided by three and rounded down:

- for runs of 0, 1, or 2 characters, we don't need to replace anything
- for runs of 3, 4, or 5 characters, it is enough to replace a single one
- for runs of 6, 7, or 8 characters, it is enough to replace two, etc.

As mentioned above, each time we replace a character we can also make the new one
represent a new character class within the password.

Thus, a function that fixes the long runs can take as input the result of
examining a string (its length, the number of its character classes, and
the lengths of the long runs), and return the number of "replace a character"
actions needed along with the updated state of the string.
We do not need to examine any new strings to get the updated state; all we need to do is
decrease the number of not-yet-represented character classes by the number of
characters replaced, possibly bringing it down to zero.
The string length will not change.

#### Fixing the string length

If the string is too short, then it is mandatory to add characters to the end.
The number of characters to add is equal to the difference between the desired length (6) and
the current length of the string.

As mentioned above, each time we add a character we can also make the new one
represent a new character class within the password.

Thus, a function that fixes the string length can take as input the result of
examining a string (its length, the number of its character classes, and
the lengths of the long runs), and return the number of "add a character"
actions needed along with the updated state of the string.
We do not need to examine any new strings to get the updated state; all we need to do is
decrease the number of not-yet-represented character classes by the number of
characters added, possibly bringing it down to zero.
The number and respective length of too-long runs of the same characters will not change.

#### Adding more character classes

If after breaking the long runs and extending the string to the desired length it should
turn out that it still does not contain characters of enough different classes, it is
mandatory to fix that, too.
The shortest way to do it is to replace as many characters as needed (at most two, since
there must be at least one character class represented in a string of six characters or more);
as noted above, since each character has at most two neighbors, we can always replace it
with one of a character class that is different from those of its neighbors, so at each step
we can always replace a character with one in the desired missing class.

Thus, a function that fixes the missing classes can take as input the result of
examining a string (its length, the number of its character classes, and
the lengths of the long runs), and return the number of "replace a character"
actions needed along with the updated state of the string.
We do not need to examine any new strings to get the updated state; all we need to do is
decrease the number of not-yet-represented character classes by the number of
characters replaced, possibly bringing it down to zero.
If we do this as a third step, after fixing the other two classes of problems, then
neither the string length (already enough) nor the number and length of too-long runs
(already none) will change.

#### Bringing it all together

The algorithm for improving a password's strength will then look as follows:

- examine the initial string, noting its length, the number of character classes missing,
  and the number and respective lengths of the too-long runs of the same characters
- start with 0 as the number of actions taken
- fix the too-long runs: for each run, increase the number of actions by its length
  divided by 3 and rounded down; at the same time, decrease the number of missing
  character classes by the same amount if needed
- fix the string length: if needed, increase the number of actions by the difference between
  the desired length (6) and the current string length; decrease the number of
  missing character classes by the same amount if needed
- fix any remaining missing character classes: increase the number of actions by
  the number of character classes still not represented, and bring that number to zero in
  the state of the string
- return the total number of actions that need to be taken

### Task 2: Valid Number

There are several approaches to solving this problem:

- match the input string against a regular expression
- try to parse the input string using a pre-built parser

Some languages have built-in constructs for building parsers, others can handle
regular expressions with ease, and some are good at both, so the approach depends on
the programming language.

## Running the test suite

The `tests/` subdirectory contains a Perl test suite that outputs TAP, so that
it can be run using `prove tests` (or, for the more adventurous, `prove -v tests`).

### Task 1: Strong Password

This task takes a string as input, so there are two ways of running the program:

- if the `PWC_FROM_STDIN` environment variable is not set to the exact value `1`,
  the program examines the seven strings given as examples, and produces seven words on
  its standard output stream, each one on a line by itself.
  In other words, the program must output `true\nfalse\nfalse\nfalse\ntrue\ntrue\ntrue\n` exactly.
- if the `PWC_FROM_STDIN` environment variable is set, the program reads a single line of
  text from its standard input, treats it as an expression to be examined, and produces
  a single word (either "true" or "false") on a line by itself on its standard output stream.

The `PWCTest::Ch287` module in `tests/lib/` defines a `test_strong_password_default` function that
runs a program with `PWC_FROM_STDIN` unset and expects the exact output, and also
a `test_strong_password` function that runs a series of tests with different sequences,
each time running the program with `PWC_FROM_STDIN` set to 1 and feeding it the sequence.

If the implementation in any language should provide more than one method, then
the program should honor the `PWC_METHOD` environment variable.
The value "0" indicates the use of the most natural method for the language,
the value "1" indicates the use of an alternative method, and if there are more than two,
then the values "2", "3", etc, are used to select them.
If `PWC_METHOD` is set to a non-numeric value or to a value that is higher than
the index of the last supported methods, it is ignored and the program proceeds as if
`PWC_METHOD` was set to "0".

The `tests/01-perl-ch-1.t` test runs these functions on the Perl implementation and
produces TAP output suitable for the `prove` tool.

### Task 2: Valid Number

This task takes a string as input, so there are two ways of running the program:

- if the `PWC_FROM_STDIN` environment variable is not set to the exact value `1`,
  the program examines the seven strings given as examples, and produces seven words on
  its standard output stream, each one on a line by itself.
  In other words, the program must output `true\nfalse\nfalse\nfalse\ntrue\ntrue\ntrue\n` exactly.
- if the `PWC_FROM_STDIN` environment variable is set, the program reads a single line of
  text from its standard input, treats it as an expression to be examined, and produces
  a single word (either "true" or "false") on a line by itself on its standard output stream.

The `PWCTest::Ch287` module in `tests/lib/` defines a `test_valid_number_default` function that
runs a program with `PWC_FROM_STDIN` unset and expects the exact output, and also
a `test_valid_number` function that runs a series of tests with different sequences,
each time running the program with `PWC_FROM_STDIN` set to 1 and feeding it the sequence.

If the implementation in any language should provide more than one method, then
the program should honor the `PWC_METHOD` environment variable.
The value "0" indicates the use of the most natural method for the language,
the value "1" indicates the use of an alternative method, and if there are more than two,
then the values "2", "3", etc, are used to select them.
If `PWC_METHOD` is set to a non-numeric value or to a value that is higher than
the index of the last supported methods, it is ignored and the program proceeds as if
`PWC_METHOD` was set to "0".

The `tests/02-perl-ch-2.t` test runs these functions on the Perl implementation and
produces TAP output suitable for the `prove` tool.

## Implementation details

### Task 1: Strong Password

#### Perl

The Perl solution has several important functions:

- `classify()` - examine a single character passed as an argument and return the name of
  its character class ( `lower`, `upper`, `digit`, or `unknown`).
  If the `PWC_USE_LOCALE` environment variable is set exactly to the value "1", then
  this function will use the current locale settings; otherwise it will only recognize
  ASCII Latin uppercase and lowercase letters and ASCII digits.
- `examine_password()` - perform the initial examination of the password string.
  Determine its length, the number of character classses not represented in it, and
  the number and length of successive runs of the same character.
  There are several ways to detect successive runs; a comment in the source code
  refers to a regular expression that uses Perl's `/e` modifier to replace a run with
  its length as an integer.
  This solution processes the string character by character and keeps track of what
  the last character was and how many of it we have seen so far.
- `fix_runs()` - count the "replace a single character" actions that must be performed to
  break too-long runs of the same character.
  At the same time, decrease the number of missing character classes by the same amount.
- `fix_length()` - count the "add a single character" actions that must be performed to
  bring the string up to the desired length if it is shorter.
  At the same time, decrease the number of missing character classes by the same amount.
- `fix_missing()` - count the "replace a single character" actions that must be performed to
  represent all the required character classes in the password string.
- `strong_password()` - invoke the above functions, sum up the number of required actions.

Note that the `examine_password()` and the `fix_*()` functions return the current state
directly as three scalar variables instead of any kind of structured data.
Of course it would be possible to stash them into a hash or a simple object, but
this way was a bit simpler.

### Task 2: Valid Number

#### Perl

The Perl solution has three major elements:

- `$re_valid_number` - a documented (using the `/x` modifier) regular expression that
  determines whether a string represents a valid number or not
- `valid_number` - a function that returns either the string "true" or the string "false"
  depending on whether the argument represents a valid number
- `parse_stdin` - read a line from the standard input, return it as a string to be examined

## Contact

These solutions were written by [Peter Pentchev][roam].
They are developed in [the common PWC-club GitHub repository][github].
This documentation is hosted at [Ringlet][ringlet-home].

[roam]: mailto:roam@ringlet.net "Peter Pentchev"
[github]: https://github.com/manwar/perlweeklychallenge-club/tree/master/challenge-287/ppentchev "These solutions at GitHub"
[ringlet-home]: https://devel.ringlet.net/misc/perlweeklychallenge-club/287/ "This documentation at Ringlet"

[pwc-287]: https://theweeklychallenge.org/blog/perl-weekly-challenge-287/ "The 287th Perl & Raku Weekly Challenge"
