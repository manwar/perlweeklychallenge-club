#!/usr/bin/env perl

use Modern::Perl;

my @source = split ' ', <>;
my @target = split ' ', <>;
say is_reverse_equal(\@source, \@target) ? "true" : "false";

sub is_reverse_equal {
    my($n1, $n2) = @_;
    my @n1 = @$n1;
    my @n2 = @$n2;
    return 1 if "@n1" eq "@n2";
    for my $i (0 .. $#n1) {
        for my $len (1 .. @n1 - $i) {
            my @tmp1 = @n1;
            @tmp1[$i .. $i+$len-1] = reverse @tmp1[$i .. $i+$len-1];
            return 1 if "@tmp1" eq "@n2";
        }
    }
    return 0;
}
