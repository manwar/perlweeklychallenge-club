#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

my @pentagon_numbers;
my %pentagon_numbers;
{   my $last = 0;
    sub add_pentagon_number {
        ++$last;
        push @pentagon_numbers, $last * (3 * $last - 1) / 2;
        undef $pentagon_numbers{ $pentagon_numbers[-1] };
        return $pentagon_numbers[-1]
    }
}

sub pentagon_numbers {
    while (1) {
        my $sum = add_pentagon_number();
        for my $p1 (@pentagon_numbers) {
            last if $p1 * 2 > $sum;

            my $p2 = $sum - $p1;
            next unless exists $pentagon_numbers{$p2}
                     && exists $pentagon_numbers{$p2 - $p1};

            return $p1, $p2
        }
    }
}

say join ' ', pentagon_numbers();
