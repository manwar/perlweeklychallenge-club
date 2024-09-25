#!/usr/bin/perl
use strict;
use warnings;

=begin
The task isn't to generate a strong password, but simply to check how many
steps are needed to turn a given string into a strong password. If a character
is missing, you only need to count the insertion of that character. In the case
of repeating character triplets, you just need to break the triplet by replacing
one of the characters with another. I used a space to count the number of triplet
replacements. And if the number of triplet breaks is greater than the number of
missing characters, then the total number of steps is equal to the number of
triplet breaks: after all, a missing character could have been used to break the
triplet.
=cut

sub strong_password {
    my ($pw) = @_;
    my $count = 0;
    my $min_len_pw = 6;
    my $len = length($pw);

    # Simultaneously check for missing lowercase, uppercase, and digit characters
    # If a character is missing, simulate its addition
    ($len++ && $count++) if ($pw !~ /[a-z]/);
    ($len++ && $count++) if ($pw !~ /[A-Z]/);
    ($len++ && $count++) if ($pw !~ /[0-9]/);

    # Replace the third character of triplets with a space and count the replacement
    # only if no missing characters were found previously
    my $count_triplets = 0;
    while ($pw =~ /(.)\1\1/) {

        # If a triplet is found, replace the third character of the triplet
        # with a space to break the repetition and maintain the string length.
        $pw =~ s/(.)\1\1/${1}${1} /;
        $count_triplets++;
    }
    # A missing character could have been used to break the triplet
    $count = $count_triplets if ($count_triplets > $count);

    # Ensure password meets minimum length
    $count += $min_len_pw - $len if ($len < $min_len_pw);

    return ($count);
}

# TESTS

my $str;

# Example 1
$str = "a";
print(strong_password($str), "\n"); # Output: 5

# Example 2
$str = "aB2";
print(strong_password($str), "\n"); # Output: 3

# Example 3
$str = "PaaSW0rd";
print(strong_password($str), "\n"); # Output: 0

# Example 4
$str = "Paaasw0rd";
print(strong_password($str), "\n"); # Output: 1

# Example 5
$str = "aaaaa";
print(strong_password($str), "\n"); # Output: 2

# Example 6
$str = "Abbbbbb";
print(strong_password($str), "\n"); # Output: 2

# Example 7
$str = "bbbAb0bbb";
print(strong_password($str), "\n"); # Output: 2

# Example 8
$str = "bbbABC";
print(strong_password($str), "\n"); # Output: 1
