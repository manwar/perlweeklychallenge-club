# Perl Weekly Challenge - 273

Welcome to [Week #273][0] of [The Weekly Challenge][1].

## Task 1: Percentage of Character

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str` and a character `$char`.

Write a script to return the percentage, nearest whole, of given character in
the given string.

**Example 1**

```
Input: $str = "perl", $char = "e"
Output: 25
```

**Example 2**

```
Input: $str = "java", $char = "a"
Output: 50
```

**Example 3**

```
Input: $str = "python", $char = "m"
Output: 0
```

**Example 4**

```
Input: $str = "ada", $char = "a"
Output: 67
```

**Example 5**

```
Input: $str = "ballerina", $char = "l"
Output: 22
```

**Example 6**

```
Input: $str = "analitik", $char = "k"
Output: 13
```

### Solution

Our solution is implemented as the [task1.pm][3] module. The module provides a
single exported function `percentage_of_character` that takes two arguments as
described in the task and returns the percentage of the given character in the
given string.

```perl
use strict;
use warnings;
use autodie;

use Exporter;
use Readonly;

our $VERSION = '1.0.0';

our @EXPORT_OK = qw(percentage_of_character);

Readonly::Scalar my $EMPTY              => q{};    # for splitting the string
Readonly::Scalar my $PERCENTAGE_FACTOR  => 100;    # for converting decimal
Readonly::Scalar my $ROUNDING_THRESHOLD => 0.5;    # for rounding the percentage

sub percentage_of_character {
    my ( $str, $char ) = @_;

    # string length ends up as the denominator of our percentage calculation
    my $string_length = length $str // 0;

    # if the string is empty, return 0 rather than dividing by zero
    if ( $string_length == 0 || !defined $char ) {
        return 0;
    }

    # grab characters as a list
    my @characters = split $EMPTY, $str;

    # filter down to the characters that match the given character
    my @matching_characters = grep { $_ eq $char } @characters;

    # count the number of matching characters
    my $matching_characters_count = scalar @matching_characters;

    # calculate the percentage as a decimal
    my $decimal_percentage = $matching_characters_count / $string_length;

    # convert the decimal to a percentage
    my $percentage = $decimal_percentage * $PERCENTAGE_FACTOR;

    # round the percentage to the nearest whole number
    my $rounded_percentage = int( $percentage + $ROUNDING_THRESHOLD );

    # return the rounded percentage as the result
    return $rounded_percentage;
}

1;
```

This solution could be a lot more concise, but we have opted for clarity and
readability (possibly at the expense of brevity). For the most part, the
comments in the code should be self-explanatory. We have used the `Readonly`
module to define some constants that are used in the calculation of the
percentage. The `percentage_of_character` function takes the string and the
character as arguments and returns the percentage of the character in the string
as an integer.

### Testing

We have included a test script to verify the correctness of our solution. The
test script uses the `Test::More` module to run a series of tests against the
`percentage_of_character` function. The test script is as follows:

```perl
use strict;
use warnings;
use autodie;

use Readonly;
use Test::More;

use lib qw( . );

use Task1 qw(percentage_of_character);

Readonly::Scalar my $EMPTY_STR => q{};

subtest 'Examples' => sub {
    plan tests => 6;

    is( percentage_of_character( 'perl',      'e' ), 25, 'Example 1' );
    is( percentage_of_character( 'java',      'a' ), 50, 'Example 2' );
    is( percentage_of_character( 'python',    'm' ), 0,  'Example 3' );
    is( percentage_of_character( 'ada',       'a' ), 67, 'Example 4' );
    is( percentage_of_character( 'ballerina', 'l' ), 22, 'Example 5' );
    is( percentage_of_character( 'analitik',  'k' ), 13, 'Example 6' );
};

subtest 'Additional tests' => sub {
    plan tests => 7;

    is( percentage_of_character( 'perl', 'x' ), 0, 'Character not found' );
    is( percentage_of_character( 'perl', 2 ),   0, 'Input other than strings' );
    is( percentage_of_character( 2, 'e' ),      0, 'Input other than strings' );
    is( percentage_of_character( $EMPTY_STR, 'e' ),    0, 'Empty string' );
    is( percentage_of_character( 'perl', $EMPTY_STR ), 0, 'Empty character' );
    is( percentage_of_character('perl'), 0, 'No character argument' );
    is( percentage_of_character(),       0, 'No input' );
};

done_testing();
```

You can run the test script using the following command (assumes the `prove`
utility is available):

```bash
prove ./t/task1.t
```

## Task 2: B After A

**Submitted by:** [Mohammad Sajid Anwar][2]

You are given a string, `$str`.

Write a script to return `true` if there is at least one `b`, and no `a` appears
after the first `b`.

**Example 1**

```
Input: $str = "aabb"
Output: true
```

**Example 2**

```
Input: $str = "abab"
Output: false
```

**Example 3**

```
Input: $str = "aaa"
Output: false
```

**Example 4**

```
Input: $str = "bbb"
Output: true
```

### Solution

Our solution is implemented as the [task2.pm][4] module. The module provides a
single exported function `b_after_a` that takes a single argument as described
in the task and returns a boolean value indicating whether the given string
satisfies the conditions of the task.

```perl

use strict;
use warnings;
use autodie;
use Exporter;

our $VERSION = '1.0.0';

our @EXPORT_OK = qw(b_after_a);

sub b_after_a {
    my $str = shift // q{};

    # Regular expression to match the string
    ## no critic (RegularExpressions::RequireDotMatchAnything)
    my $re = qr{
        ^      # Start of the string
        [^b]*  # Match any character except 'b' zero or more times
        b+     # Match 'b' one or more times
        [^a]*  # Match any character except 'a' zero or more times
        $      # End of the string
    }mx;
    ## use critic
    # Test the string against the regular expression and return the result
    if ( $str =~ $re ) {
        return 1;
    }
    return 0;
}

1;
```

Our function uses a regular expression to match the against the conditions input
string. Arguably, the regular expression could be more concise, but despite the
prompt example describing all the input strings as being comprised of only 'a'
and 'b' characters, the initial problem statement does not explicitly constrain
the input to only those characters. Therefore, we have opted for a more general
regular expression that will matches strings that contain any any character
after the first 'b' that is not an 'a'. Perlcritic has reminded us that in many
regex implementations, the dot character '.' is a wildcard that matches any
character except a newline. This is certainly worth considering, but in this
particular case, we do not use the dot character in our regular expression.  We
opt to disable this particular critic rule for this regular expression rather
than add a superfluous flag to the regular expression.

### Testing

We have included a test script to verify the correctness of our solution. The
test script uses the `Test::More` module to run a series of tests against the
`b_after_a` function. The test script is as follows:

```perl
use strict;
use warnings;
use autodie;
use Test::More;

use lib qw( . );

use task2 qw(b_after_a);

subtest 'Examples' => sub {
    plan tests => 4;

    is( b_after_a('aabb'), 1, 'Example 1' );
    is( b_after_a('abab'), 0, 'Example 2' );
    is( b_after_a('aaa'),  0, 'Example 3' );
    is( b_after_a('bbb'),  1, 'Example 4' );
};

subtest 'Additional tests' => sub {
    plan tests => 3;

    is( b_after_a('abbc'), 1, 'Characters other than "a" after "b"' );
    is( b_after_a(2),      0, 'Input other than strings' );
    is( b_after_a(),       0, 'No input' );
};

done_testing();
```

You can run the test script using the following command (assumes the `prove`
utility is available):

```bash
prove ./t/task2.t
```

You can run both test scripts using the following command:

```bash
prove -r
```

[0]: https://perlweeklychallenge.org/blog/perl-weekly-challenge-272/
[1]: https://perlweeklychallenge.org
[2]: https://manwar.org/
[3]: ./task1.pm
[4]: ./task2.pm
