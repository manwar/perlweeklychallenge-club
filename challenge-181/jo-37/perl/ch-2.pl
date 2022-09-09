#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use List::Gen 'slide';
use DateTime::Duration;
use DateTime::Format::Strptime;
use autodie;
use experimental 'signatures';

our ($examples, $tests);

run_tests() if $examples || $tests;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [DATA]

-examples
    run the examples from the challenge
 
-tests
    run some tests

DATA
    name of a file containing date/temperature data,
    use '-' for STDIN

EOS


### Input and Output

say for hot_days(\*ARGV);


### Implementation

# Slurp the file, split it into lines, dates and temperatures, convert
# dates to DateTime objects, sort by date and sliding over date pairs
# keep only "hot days".
# There is an ambiguity in the term "previous day":  It could mean the
# previous day from the given data or the previous day from the calendar
# (that could be missing in the data).  I'm going for the latter
# interpretation.
#
use constant DAY => DateTime::Duration->new(days => 1);
use constant DATE => DateTime::Format::Strptime->new(pattern => '%F');

sub hot_days ($fh) {
    local $/;

    slide {
        @_ == 2 &&                      # @_ shrinks at the end of the list
        $_[0][0] + DAY == $_[1][0] &&   # two consecutive days
        $_[1][1] > $_[0][1] ?           # higher temperature
        $_[1][0] : ()} 2,   
    sort {$a->[0] cmp $b->[0]}
    map {[DATE->parse_datetime($_->[0])->set_formatter(DATE), $_->[1]]}
    map [/(\S+), *(\S+)/],
    split /\n/, <$fh>;
}


### Examples and tests

sub run_tests {

    SKIP: {
        skip "examples" unless $examples;

        open my $fh, '<', \<<EOS;
2022-08-01, 20
2022-08-09, 10
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-10, 28
2022-08-07, 20
2022-08-04, 18
2022-08-08, 21
2022-08-02, 25
EOS
        is [hot_days($fh)],
        [qw(2022-08-02 2022-08-05 2022-08-06 2022-08-08 2022-08-10)],
        'example';
    }

    SKIP: {
        skip "tests" unless $tests;

        open my $fh, '<', \<<EOS;
2022-09-01, 26
2022-08-01, 20
2022-08-03, 19
2022-08-06, 24
2022-08-05, 22
2022-08-31, 25
2022-08-07, 20
2022-08-08, 21
2022-08-02, 25
EOS

        is [hot_days($fh)],
        [qw(2022-08-02 2022-08-06 2022-08-08 2022-09-01)],
        'gaps';
    }

    done_testing;
    exit;
}
