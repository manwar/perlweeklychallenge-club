#!/usr/bin/env perl
#
# ch-1.pl - Parse phone numbers using templates
#
# 2021 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
no warnings 'uninitialized';

# Valid phone number templates, where n is a digit.
# Internal whitespace is squashed, leading/trailing is trimmed.
my %valid = 
    map { y/ / /sr => 1 } 
    split /\s*(\n|$)\s*/, q{
        +nn  nnnnnnnnnn
        (nn) nnnnnnnnnn
        nnnn nnnnnnnnnn
    };

print for grep { check_number($_) } <>;

# Check if a number matches any template in %valid
sub check_number {
    local $_ = shift;

    s/^\s+//, s/\s+$//; # Trim leading and trailing whitespace
    y/0-9/n/, y/ / /s;  # Replace digits, squash internal spaces

    return $_ if $valid{$_};
}
