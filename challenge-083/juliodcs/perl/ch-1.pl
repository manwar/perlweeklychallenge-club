use strict;
use warnings;
use feature 'say';
use experimental 'signatures';

sub count_middle($phrase) {
    length $phrase =~ s/^\s*\w+|\w+\s*$|\s+//gr
}

if (@ARGV == 1) {
    say count_middle(shift);
    exit 0;
}

#Tests

use Test::More;

is count_middle('a a a'), 1, 'a simple phrase of 3 words';
is count_middle('a dummy phrase'), 5, 'a phrase of 3 words';
is count_middle('this a phrase of more than 3 words'), 18, 'can count phrases with more than 3 words';
is count_middle('a a'), 0, 'No middle words';
is count_middle('a'), 0, 'works with single word';
is count_middle('a'), 0, 'works with empty string';
is count_middle('   this a phrase of more than 3 words   '), 18, 'works with leading and trailing spaces';

done_testing;
