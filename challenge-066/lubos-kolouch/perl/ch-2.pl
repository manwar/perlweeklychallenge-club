#!/usr/bin/perl
use strict;
use warnings;

sub find_expressions {
    my ($N) = @_;
    my @solutions;

    for my $m (2 .. sqrt($N)) {
        for my $n (2 .. log($N)/log($m)) {
            if ($m ** $n == $N) {
                push @solutions, "$m^$n";
            }
        }
    }

    return @solutions ? \@solutions : 0;
}

my $N = 64;
my $result = find_expressions($N);
if (ref $result eq 'ARRAY') {
    print join(' or ', @$result), "\n";
} else {
    print "0\n";
}

