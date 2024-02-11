# The Weekly Challenge 255
# Task 1 Odd Character
use v5.30.0;
use warnings;
use List::MoreUtils qw/frequency/;

sub oc {
    my $s = $_[0];
    my $t = $_[1];
    my %f_s = frequency split "", $s;
    my %f_t = frequency split "", $t;
    for my $c (keys %f_t) {
        next if defined($f_s{$c}) && $f_t{$c} == $f_s{$c};
        # if ($f_t{$c} == $f_s{$c} + 1 || !defined($f_s{$c})) {...}
        # the above checker is not necessary
        return $c;
    }
}

use Test::More tests=>3;
ok oc("Perl", "Preel") eq "e";
ok oc("Weekly", "Weeakly") eq "a";
ok oc("Box", "Boxy") eq "y";
