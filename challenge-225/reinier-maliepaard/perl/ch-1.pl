#!/usr/bin/perl
use strict;
use warnings;

# split / /, $s; or split ' ', $s;
#
# both work, but the second one:
#
# - ignores leading whitespace
# - ignores trailing whitespace
# - treats multiple spaces as one

sub max_words {

    my ($list) = @_;
    my $max = 0;

    for my $s (@$list) {

        my $m = scalar split ' ', $s;
        $max = $m if $m > $max;
    }
    return $max;
}

# Tests

my @list;

# Example 1
my @list = ("Perl and Raku belong to the same family.",
            "I love Perl.",
            "The Perl and Raku Conference");
print max_words(\@list), "\n"; # Output: 8

# Example 2
@list = ("The Weekly Challenge.",
         "Python is the most popular guest language.",
         "Team PWC has over 300 members.");
print max_words(\@list), "\n"; # Output: 7
