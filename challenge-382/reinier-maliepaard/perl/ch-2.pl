#!/usr/bin/perl
use strict;
use warnings;

Read first this text

The heart of the function below is this line:

glob '{' . ($str =~ s/\?/{0,1}/gr) . '}';

It is easiest to understand by following the steps.

Suppose: my $str = "a?b?";

Step 1 Replace every `?` by `{0,1}`
$str =~ s/\?/{0,1}/gr

The `s///` operator performs a substitution.

* `\?` matches a literal `?`.
* `{0,1}` replaces it.
* `g` means "replace all occurrences."
* `r` means "return the new string" without changing `$str`.

The result is: "a{0,1}b{0,1}"

Step 2 Add one pair of outer braces
'{' . "a{0,1}b{0,1}" . '}' produces "{a{0,1}b{0,1}}"

Step 3 Let `glob` expand the braces
`glob` treats every `{0,1}` as a choice: choose either `0` or `1`.

So glob "{a{0,1}b{0,1}}" expands into ("a0b0", "a0b1", "a1b0", "a1b1")

# Solution #382, 2:
sub replace_question_mark {
    glob '{' . ($_[0] =~ s/\?/{0,1}/gr) . '}';
}


# Tests

my $str;

# Example 1
$str = "01??0";
print "(", join(", ", map { qq("$_") } replace_question_mark($str)), ")\n"; # Output: ("01000", "01010", "01100", "01110")

# Example 2
$str = "101";
print "(", join(", ", map { qq("$_") } replace_question_mark($str)), ")\n"; # Output: ("101")

# Example 3
Input: $str = "???";
print "(", join(", ", map { qq("$_") } replace_question_mark($str)), ")\n"; # Output: ("000", "001", "010", "011", "100", "101", "110", "111")

# Example 4
$str = "1?10";
print "(", join(", ", map { qq("$_") } replace_question_mark($str)), ")\n"; # Output: ("1010", "1110")

# Example 5
$str = "1?1?0";
print "(", join(", ", map { qq("$_") } replace_question_mark($str)), ")\n"; # Output: ("10100", "10110", "11100", "11110")
