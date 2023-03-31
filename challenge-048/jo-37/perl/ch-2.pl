#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Date::Manip::Recur;
use List::UtilsBy 'sort_by';

our ($tests, $examples, $help);

run_tests() if $examples;	# does not return

die <<EOS if $help;
usage: $0 [-examples] [-help]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-help
    print this text

EOS


### Input and Output

say for palindrome_dates();


### Implementation

sub palindrome_dates {
    # In a palindrome date, the first two digits of the year equal the
    # reversed day of month.  As the year shall be within 2000 and 2999,
    # the possible days of month reduce to 2, 12 and 22. These days are
    # present in any month.  Taking all matching days from an arbitrary
    # single year and reverting MMDD to YYYY produces all palindromic
    # dates in the requested interval.
    # Create a Date::Manip::Date object for every palindrome date, sort
    # and format to MMDDYYYY.
    map $_->printf('%m%d%Y'),
    sort_by {$_->printf('%Y%m%d')}
    map {
        my $md = $_->printf('%m%d');
        Date::Manip::Date->new(scalar(reverse $md) . $md);
    } Date::Manip::Recur->new('0:1:0*2,12,22:0:0:0')->dates(2000, 2001);
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        like [palindrome_dates()], array {item '10022001'; etc;}, 'example';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
