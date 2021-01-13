#!/usr/bin/env perl
use strict; use warnings;
use v5.26;

use List::Util qw(sum);

# tested with: perl perl/ch-2.pl --debug 1 4 3 2

our $d = 0;

sub candies {
    my @rank = @_;
    say "default candies: ".scalar(@_) if$d;
    my @ruleA = @_;
    if ( $d ) {
        @ruleA +
            scalar
            ( map {
                my @ruleB;
                if ( 0 < $_ and $rank[$_-1] < $rank[$_] ) {
                    say "add 1 more candy".
                        " as $rank[$_] has higher rank than $rank[$_-1]" if $d;
                    push @ruleB, 1;
                }
                if ( ($rank[$_+1]//$rank[$_] ) < $rank[$_] ) {
                    say "add 1 more candy".
                        " as $rank[$_] has higher rank than $rank[$_+1]" if $d;
                    push @ruleB, 1;
                }
                @ruleB
              } 1 .. $#rank )
    }
    else {
        # https://dev.to/jeongoon/weekly-challenge-080-2n1n
        @ruleA + scalar ( grep { $rank[$_-1] != $rank[$_] } 1..$#rank );
    }
}

my @filteredARGV;
for (@ARGV) {
    /^-(d|v|-*debug|-*verbose)$/ and ( $d = 1, next );

    (  /^(-h|--*help)$/ or ($_+0) ne $_ or $_ < 0 )
        and say("perl ch-1.pl <interger> ..."), exit 0;

    push @filteredARGV, $_;
}

@filteredARGV < 1 and
    ( warn("using default input: '1, 4, 3, 2' ... "),
      @filteredARGV = ( 1, 4, 3, 2 ));

say( ($d?"therefore: ":""), candies @filteredARGV );
