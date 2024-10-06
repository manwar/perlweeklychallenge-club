# The Weekly Challenge 289
# Task 1 Third Maximum
use v5.30;
use warnings;

sub tm {
    my @arr = $_[0]->@*;
    my ($fm, $sm, $tm) = (undef,undef,undef);
    for my $p (@arr) {
        if (!defined($fm) || $fm < $p) {
            $tm = $sm;
            $sm = $fm;
            $fm = $p;
        } elsif (!defined($sm) || $sm < $p) {
            if ($p != $fm) {
                $tm = $sm;
                $sm = $p;
            }
        } elsif (!defined($tm) || $tm < $p) {
            $tm = $p if $p != $sm;
        }
    }
    return $fm if !defined($tm);
    return $tm;
}

use Test::More tests=>5;
ok tm([5,6,4,1]) == 4;
ok tm([4,5]) == 5;
ok tm([1,2,2,3]) == 1;
ok tm([1,2,3,3]) == 1;
ok tm([1,1,2,3]) == 1;
