#!/usr/bin/perl
use 5.030;
use warnings;
use experimental qw/ switch /;

sub nochange {
    say 'false';
    exit(0);
}

my $fives = 0;
my $tens = 0;
my $twenties = 0;

for my $bill (@ARGV) {
    given ($bill) {
        when (5) { 
            $fives++;
        }

        when (10) {
            if ($fives > 0) {
                $fives--;
                $tens++;
            } else {
                nochange();
            }

        }

        when (20) {
            if ($tens > 0 && $fives > 0) {
                $tens -= 1;
                $fives -= 1;
                $twenties += 1;
            } elsif ($fives > 2) {
                $fives -= 3;
                $twenties += 1;
            } else {
                nochange();
            }

        }

        default {
            die "illegal bill value\n";
        }
    }
}

say "true";
