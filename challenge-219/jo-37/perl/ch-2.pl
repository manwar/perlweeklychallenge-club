#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use PDL::Opt::GLPK;
use experimental 'signatures';

our ($tests, $examples, $duration, $price, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless $price && @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [-duration=DURATION]
    [-price=PRICE] [DAY...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    explain the solution as in the examples

-duration=DURATION
    list of card durations. Default: 1, 7, 30

-price=PRICE
    list of card prices

DAY...
    list of travel days

EOS


### Input and Output

main: {
    my @duration = $duration ? split /[, ] */, $duration : (1, 7, 30);
    my @price = split /[, ] */, $price;

    die "duration and price have different sizes" if @duration != @price;
    my @cards = map [$duration[$_], $price[$_]], 0 .. $#duration;

    my ($selection, $cost) = travel_cost(\@cards, \@ARGV);
    
    if ($verbose) {
        printf "On day %d, we buy a %3\$d-day pass for %2\$d.\n", @$_
            for @$selection;
        say "total cost: $cost";
    } else {
        say $cost;
    }

}


### Implementation

sub travel_cost ($crd, $dy) {
    my $cards = long @$crd;
    my $days = long $dy;
    my $from = $days->dummy(1);
    my $to = $from + $cards((0))->dummy(0);
    my $valid = ($days->dummy(1) >= $from->dummy(0)) &
        ($days->dummy(1) < $to->dummy(0));

    my $a = $valid->clump(1,2)->xchg(0,1);
    my $b = ones($days);
    my $c = $cards((1))->dummy(0,$days->dim(0))->clump(-1);

    my $xopt = null;
    my $fopt = null;
    my $status = null;

    glpk($c, $a, $b, zeros($c), zeros($c), GLP_LO * ones($b),
        GLP_BV * ones($c), GLP_MIN, $xopt, $fopt, $status);

    my $selection = $xopt->reshape($to->dims);
    my $solution = whichND $selection;

    ($days->dice($solution((0)))->dummy(0)
        ->glue(0, $cards->dice('X', $solution((1))))->qsortvec->unpdl, $fopt);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        is scalar(travel_cost([[1, 2], [7, 7], [30, 25]], [1, 5, 6, 7, 9, 15])),
            11, 'example 1';

        is scalar(travel_cost([[1, 2], [7, 7], [30, 25]],
            [1, 2, 3, 5, 7, 10, 11, 12, 14, 20, 30, 31])),
            20, 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
