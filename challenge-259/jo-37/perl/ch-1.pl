#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use File::Temp 'tempfile';
use Date::Manip::Date;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV >= 2;
usage: $0 [-examples] [-tests] [START OFFS [HOLIDAY...]]

-examples
    run the examples from the challenge
 
-tests
    run some tests

START
    start date in format YYYY-MM-DD

OFFS
    business days offset

HOLIDAY...
    list of bank holidays in format YYYY-MM-DD

EOS


### Input and Output

say bdo(@ARGV[0, 1], [@ARGV[2..$#ARGV]]);


### Implementation

sub bdo ($start, $offs, $bank=[]) {
    my ($fh, $fn) = tempfile();
    print $fh "*HOLIDAYS\n";
    print $fh "$_ =\n" for @$bank;
    close $fh;

    my $sd = Date::Manip::Date->new($start);
    $sd->config(ConfigFile => $fn);
    
    $sd->next_business_day($offs);
    $sd->printf('%Y-%m-%d');
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is bdo('2018-06-28', 3, ['2018-07-03']), '2018-07-04', 'example 1';
        is bdo('2018-06-28', 3), '2018-07-03', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        is bdo('2018-06-30', 1), '2018-07-03', 'start on weekend';
        is bdo('2018-06-28', 2,
            [qw(2018-07-03 2018-06-29 2018-07-01 2018-07-04)]), '2018-07-05',
            'multiple holidays';
	}

    done_testing;
    exit;
}
