#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'forpart';
use List::Util 'uniqint';
use experimental 'signatures';

our $examples;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [M N]

-examples
    run the examples from the challenge
 
M N
    Find all partitions of M into N prime parts having no duplicates.

EOS


### Input and Output

say "@$_" for prime_part(@ARGV);


### Implementation

sub prime_part ($m, $n) {
    my @part;

    # Find all prime partitions and filter out those containing
    # duplicates.
	forpart {push @part, [@_] if @_ == uniqint @_} $m, {n => $n, prime => 1};

    wantarray ? @part : \@part;
}


### Examples and tests

sub run_tests {

    is scalar(prime_part(18, 2)),
        bag {
            item bag {item 5; item 13; end};
            item bag {item 7; item 11; end};
            end;
        }, 'example 1';

    is scalar(prime_part(19, 3)),
        bag {
            item bag {item 3; item 5; item 11; end};
            end;
        }, 'example 2';

    done_testing;
    exit;
}
