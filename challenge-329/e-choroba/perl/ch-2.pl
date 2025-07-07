#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub nice_string($str) {
    my %seen;
    $seen{lc $_} |= 1 + /[a-z]/ for $str =~ /[a-zA-Z]/g;
    for my $char (keys %seen) {
        next if 3 == $seen{$char};  # Seen both lower and upper-case.
        $str =~ s/$char//gi;
    }
    return $str
}

use Test::More tests => 3;

is nice_string('YaaAho'), 'aaA', 'Example 1';
is nice_string('cC'), 'cC', 'Example 2';
is nice_string('A'), '', 'Example 3';
