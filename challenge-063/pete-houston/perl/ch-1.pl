#
#===============================================================================
#
#        FILE: 6301.t
#
#  DESCRIPTION: Last word test cases with solution
#
#      AUTHOR: Pete Houston
#
#===============================================================================

use strict;
use warnings;

use List::MoreUtils 'lastval';
use Test::More tests => 4;

is last_word ('  hello world',                qr/[ea]l/),      'hello';
is last_word ("Don't match too much, Chet!",  qr/ch.t/i),      'Chet!';
is last_word ("spaces in regexp won't match", qr/in re/),      undef;
is last_word ( join(' ', 1..1e6),            qr/^(3.*?){3}/), '399933';

sub last_word {
    my ($line, $re) = @_;
    return lastval { /$re/ } split /\s/, $line;
}
