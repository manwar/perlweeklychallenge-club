#!/usr/bin/perl
use 5.030;
use warnings;

sub allEqual {
    my @arr = @{ shift @_ };
    my $first = shift @arr;

    for my $elem (@arr) {
        if ($elem != $first) {
            return undef;
        }
    }

    return 1;
}

my $s = shift // die "Need a string of alphabetic characters only\n";
my @chars = split //, $s;
my $result = 0;

for my $i (0 .. scalar @chars - 1) {
    my @others = @chars;
    splice @others, $i, 1;

    my %freq;
    for my $elem (@others) {
        $freq{$elem}++;
    }


    if (allEqual([values %freq])) {
        $result = 1;
        last;
    } 
}

say $result;
