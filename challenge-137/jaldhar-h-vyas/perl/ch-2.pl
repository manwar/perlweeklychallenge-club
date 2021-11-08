#!/usr/bin/perl
use 5.020;
use warnings;

sub usage {
    say 'Need an integer between 10 and 1000';
    exit 0;
}

sub lychrel {
    my ($n) = @_;

    my $i = $n;
    for (1 .. 500) {
        my $r = join q{}, (reverse split //, $i);
        $i =  $i + $r;

        if ($i == join q{}, (reverse split //, $i)) {
            return 0;
        }

        if ($i > 10_000_000) {
            return 1;
        }
    }

    return 1;
}

my $n = shift // usage;
if ($n < 10 || $n > 1000) {
    usage;
}

say lychrel($n);
