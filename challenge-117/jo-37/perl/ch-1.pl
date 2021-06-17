#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use warnings;
use autodie;
use experimental 'signatures';

our ($tests, $examples, $rows);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV && $rows;
usage: $0 [-examples] [-tests] [-rows=n filename]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-rows=n
    expect n rows in the given file

filename
    filename containing numbered rows

EOS


### Input and Output

say join "\n", @{find_missing_rows(*ARGV{IO}, $rows)};


### Implementation

# The task is certainly over-determined:
# - There are 14 rows of data.
# - It's stated that rows are numbered 1 to 15.
# - It's stated that one row would be missing.
# Either the specification of the number of missing rows or the desired
# number of rows is superfluous.  Ignoring the number of missing rows
# here.
# Note: Ignoring both the number of rows *and* the number of missing
# rows prevents the determination of a missing last row.
sub find_missing_rows ($fh, $rows) {
    my %rows;
    @rows{1 .. $rows} = (1 .. $rows);
    # Row numbers shall be separated with a comma from the rest of the
    # row and may have leading zeros.
    delete @rows{do {local $/; <$fh> =~ /^0*(\d+)(?=,)/mg}};

    [sort {$a <=> $b} values %rows];
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        open my $fh, '<', \(<<EOS =~ s/^ +//gmr);
            11, Line Eleven
            1, Line one
            9, Line Nine
            13, Line Thirteen
            2, Line two
            6, Line Six
            8, Line Eight
            10, Line Ten
            7, Line Seven
            4, Line Four
            14, Line Fourteen
            3, Line three
            15, Line Fifteen
            5, Line Five
EOS
        is find_missing_rows($fh, 15), [12], 'example';
        close $fh;

    }

    SKIP: {
        skip "tests" unless $tests;

        my $fh;

        open $fh, '<', \(<<EOS =~ s/^ +//gmr);
            2, Line two
            3, Line three
EOS
        is find_missing_rows($fh, 3), [1], 'missing first row';
        close $fh;

        open $fh, '<', \(<<EOS =~ s/^ +//gmr);
            1, Line one
            2, Line two
EOS
        is find_missing_rows($fh, 3), [3], 'missing last row';
        close $fh;

        open $fh, '<', \(<<EOS =~ s/^ +//gmr);
            1, Line one
            2, Line two
            3, Line three
EOS
        is find_missing_rows($fh, 3), [], 'nothing missing';
        close $fh;

        open $fh, '<', \(<<EOS =~ s/^ +//gmr);
            01, Line one
            02, Line two
            03, Line three
EOS
        is find_missing_rows($fh, 3), [], 'leading zeros';
        close $fh;

        open $fh, '<', \(<<EOS =~ s/^ +//gmr);
            1, Line one
            3, Line three
            5, Line Five
EOS
        is find_missing_rows($fh, 5), [2, 4], 'multiple missing rows';
        close $fh;

        open $fh, '<', \(<<EOS =~ s/^ +//gmr);
            1, Line one
            2 Line two
            3, Line three
EOS
        is find_missing_rows($fh, 3), [2], 'malformed line number';
        close $fh;

	}

    done_testing;
    exit;
}
