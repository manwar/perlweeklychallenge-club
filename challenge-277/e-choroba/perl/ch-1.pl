#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub count_common($words1, $words2) {
    my %freq;
    ++$freq{$_}[0] for @$words1;
    ++$freq{$_}[1] for @$words2;
    return grep 1 == ($freq{$_}[0] // 0)
             && 1 == ($freq{$_}[1] // 0), keys %freq
}

use Test::More tests => 3;

is count_common(['Perl', 'is', 'my', 'friend'],
                ['Perl', 'and', 'Raku', 'are', 'friend']),
    2, 'Example 1';

is count_common(['Perl', 'and', 'Python', 'are', 'very', 'similar'],
                ['Python', 'is', 'top', 'in', 'guest', 'languages']),
    1, 'Example 2';

is count_common(['Perl', 'is', 'imperative', 'Lisp', 'is', 'functional'],
                ['Crystal', 'is', 'similar', 'to', 'Ruby']),
    0, 'Example 3';
