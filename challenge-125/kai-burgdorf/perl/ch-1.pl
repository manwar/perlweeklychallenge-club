#!/usr/bin/env perl

use utf8;
use strict;
use warnings;

my $N = 5;

if($N == 0) {
    print "(0, 0, 0)\n";
    exit(0);
}

print "Input: \$N = $N\nOutput:\n";
print "\t-1\n" if(!(n_as_hypotenuse($N) and n_as_cathete($N)));

sub n_as_cathete {
    my ($a) = @_;

    my $c = 0;

    while ($c**2 - ($c-1)**2 <= $a**2) {
        for(1..($c-1)) {
            if($c*$c - $_*$_ == $a*$a) {
                print "\t($a, $_, $c)\n";
                return 1;
            }
        }
        $c++;
    }

    return 0;
}


sub n_as_hypotenuse {
    my ($c) = @_;

    for(1..($c-1)) {
        my $a = $_;
        for($a..($c-1)) {
            if($a**2 + $_**2 == $c**2) {
                print "\t($a, $_, $c)\n";
                return 1;
            }
        }
    }

    return 0;
}
