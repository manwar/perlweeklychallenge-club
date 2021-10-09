#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Text::CSV 'csv';
use experimental qw(signatures postderef);

our ($tests, $examples);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 4;
usage: $0 [-examples] [-tests] [table1 index1 table2 index2]

-examples
    run the examples from the challenge

-tests
    run some tests

table1 index1 table2 index2
    tableN is the name of a csv file holding data of table N
    indexN is the position of the join column in table N

call
    $0 ch-2-ages.csv 1 ch-2-names.csv 0
for the given example.

EOS


### Input and Output

say join ', ', @$_
    for @{join_arrays(csv(in => shift), shift, csv(in => shift), shift)};


### Implementation


# I didn't look at the linked wikipedia implementation in detail.  The
# task - as I understand it - is to join two "tables" on a non-unique
# index.  The plan is: create two hashes with the indices as the keys
# and an array holding the corresponding records without their key as
# values.  Then join the the hashes as a "set product" of the values for
# corresponding keys, with the joining key inbetween.  The order of the
# resulting records will be random.
#
# The parameters are: two array refs with the corresponding index
# position.
sub join_arrays ($t1, $i1, $t2, $i2) {
    my (%h1, %h2);
    push $h1{splice @$_, $i1, 1}->@*, $_ for @$t1;
    push $h2{splice @$_, $i2, 1}->@*, $_ for @$t2;

    [map {
        my $key = $_;
        map {
            my $rec = $_;
            map [@$rec, $key, @$_], $h2{$key}->@*;
        } $h1{$key}->@*;
    } keys %h1];
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my @player_ages = (
            [20, "Alex"],
            [28, "Joe"],
            [38, "Mike"],
            [18, "Alex"],
            [25, "David"],
            [18, "Simon"]);

        my @player_names = (
            ["Alex", "Stewart"],
            ["Joe",  "Root"],
            ["Mike", "Gatting"],
            ["Joe", "Blog"],
            ["Alex", "Jones"],
            ["Simon","Duane"]);

        like join_arrays(\@player_ages, 1, \@player_names, 0),
            bag {
                item [20, "Alex",  "Stewart"];
                item [20, "Alex",  "Jones"];
                item [18, "Alex",  "Stewart"];
                item [18, "Alex",  "Jones"];
                item [28, "Joe",   "Root"];
                item [28, "Joe",   "Blog"];
                item [38, "Mike",  "Gatting"];
                item [18, "Simon", "Duane"];
                end;
            }, 'example';

    }
    SKIP: {
        skip "tests" unless $tests;

        is join_arrays([[1, 'a'], [2, 'b']], 0, [[2, 'B'], [3, 'C']], 0),
            [['b', 2, 'B']], 'nonmatching keys';
	}

    done_testing;
    exit;
}
