#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use constant SIZE => 20;

my @primes = (2, 3);
my %primes;
@primes{@primes} = ();
sub add_primes {
    my ($top) = @_;
  CANDIDATE:
    for (my $candidate = $primes[-1] + 2;
         $candidate <= $top;
         $candidate += 2
    ) {
        for my $prime (@primes) {
            next CANDIDATE if 0 == $candidate % $prime;
            last if $prime * $prime > $candidate;
        }
        push @primes, $candidate;
        undef $primes{$candidate};
    }
}

sub left_truncatable_primes {
    my ($should_include_single_digit) = @_;
    my $candidate = $should_include_single_digit ? 2 : 11;
    my $step = $candidate % 2 + 1;

    my @left_truncatable;
  CANDIDATE:
    while (@left_truncatable < SIZE) {
        add_primes($candidate);
        if (exists $primes{$candidate}) {
            next CANDIDATE unless -1 == index $candidate, '0';

            for my $l (1 .. length($candidate) - 1) {
                next CANDIDATE unless exists $primes{substr $candidate, $l}
            }
            push @left_truncatable, $candidate;
        }
    } continue {
        $candidate += $step;
        $step = 2;
    }
    return @left_truncatable
}

for my $include_single_digit (1, 0) {
    my @left_truncatable = left_truncatable_primes($include_single_digit);

    # Wikipedia includes single digit primes, Project Euler excludes them.
    say +("don't ", "")[$include_single_digit], 'include single digit: ';

    say join ', ', @left_truncatable;
}
