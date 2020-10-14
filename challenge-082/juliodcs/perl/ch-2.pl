use strict;
use warnings;
use experimental 'signatures';
use feature 'say';
use experimental 'smartmatch';

sub comparable($string) {
    join q(), sort split m//, $string
}

say comparable(shift . shift) eq comparable(shift) ? 1 : 0;
