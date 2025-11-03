#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use experimental qw( signatures );

use Algorithm::Combinatorics qw{ variations_with_repetition };
use List::Util qw{ mesh };

sub magic_expression($str, $target) {
    my @digits = split //, $str;
    # We use "" for no operator.
    my $iter = variations_with_repetition(['+', '-', '*',  ""], @digits - 1);
    my @correct;
    while (my $ops = $iter->next) {
        my $expression = join "", mesh(\@digits, [@$ops, ""]);
        next if $expression =~ /\b0[0-9]/;  # Only 0 can start with a 0.

        # Implement subtraction as addition of a negative number.
        my $eval = $expression =~ s/-/+-/gr;

        # First solve all multiplications.
        $eval =~ s/([0-9]+)\*([0-9]+)/$1*$2/ge while $eval =~ /\*/;

        # Then do additions.
        $eval =~ s/(-?[0-9]+)\+(-?[0-9]+)/$1+$2/ge while $eval =~ /\+/;

        push @correct, $expression if $target == $eval;
    }
    return @correct
}

use Test2::V0;
plan(5 + 1);

# It seems we can't insert more than one operator, otherwise 1*-2*-3
# would have been a solution, too.
is [magic_expression('123', 6)],
    bag { item $_ for '1*2*3', '1+2+3'; end },
    'Example 1';

is [magic_expression('105', 5)],
    bag { item $_ for '1*0+5', '10-5'; end },
    'Example 2';

is [magic_expression('232', 8)],
    bag { item $_ for '2*3+2', '2+3*2'; end },
    'Example 3';

is [magic_expression('1234', 10)],
    bag { item $_ for '1*2*3+4', '1+2+3+4'; end },
    'Example 4';

is [magic_expression('1001', 2)],
    bag { item $_ for '1+0*0+1', '1+0+0+1', '1+0-0+1',
                      '1-0*0+1', '1-0+0+1', '1-0-0+1';
          end },
    'Example 5';

my @large = magic_expression('123456789', 250);
is scalar @large, 8, 'Large';
