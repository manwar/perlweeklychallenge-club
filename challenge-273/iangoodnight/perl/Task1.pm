#!/usr/bin/perl

=begin comment

## Task 1: Percentage of Character

**Submitted by:** [Mohammad Sajid Anwar][1]

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

[1]: https://manwar.org/

=end comment
=cut

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

__END__

=encoding utf-8

=head1 NAME

Task 1: Percentage of Character

=head1 VERSION

This documentation refers to Task 1: Percentage of Character version 1.0.0

=head1 EXPORTS

The function C<percentage_of_character> is exported by default.

=head1 USAGE

    use strict;
    use warnings;
    use feature qw(say);
    use Task1 qw(percentage_of_character);

    my $str  = 'perl';
    my $char = 'e';
    say percentage_of_character( $str, $char ); # output: 25

=head1 DESCRIPTION

Given a string, C<$str> and a character C<$char>, the function
C<percentage_of_character> returns the percentage, rounded to the nearest whole
number, of the given character in the given string.

=head1 REQUIRED ARGUMENTS

=over 4

=item C<$str>

A string.

=item C<$char>

A character.

=back

=head1 OPTIONS

None.

=head1 DIAGNOSTICS

None.

=head1 EXIT STATUS

None.

=head1 CONFIGURATION

None.

=head1 DEPENDENCIES

=over 4

=item * Exporter

=item * Readonly

=back

=head1 INCOMPATIBILITIES

None reported.

=head1 BUGS AND LIMITATIONS

None reported.

=head1 AUTHOR

Ian Goodnight

=head1 LICENSE AND COPYRIGHT

This software is released under the terms of the GNU General Public License
Version 3.

=cut
