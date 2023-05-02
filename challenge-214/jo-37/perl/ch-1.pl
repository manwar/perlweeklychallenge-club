#!/usr/bin/perl -s

use v5.24;
use autodie;
use Test2::V0;
use List::UtilsBy 'sort_by';

our ($tests, $examples, $verbose);

{
    # Import the solution from week #9.
    package CH_009;

    # Without arguments, the called programm will die with a usage
    # message.  Capture this message as success indicator.
    local @ARGV;
    do "../../../challenge-009/jo-37/perl/ch-2.pl";
    die $@ unless $@ =~ /^usage: $0/;
}

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [N...]

-examples
    run the examples from the challenge
 
-tests
    run some tests

N...
    list of scores

EOS


### Input and Output

say "(@{rank(@ARGV)})";


### Implementation

# Ranking was already done in week #9.  Reusing that implementation.
# All it needs is a wrapper that prepares the subroutine arguments and
# rearranges the result:
# - expected input:
#   * rank type (standard)
#   * array of hashes containing an id and a score
# - provided output:
#   * array of hashes containing id, score and rank.
# Using a running number as id, sort the result by id, pick the rank and
# translate the first three ranks to gold, silver and bronze.
sub rank {
    my $id = 0;
    [map $_->{rank} =~ s/^([123])$/(qw(G S B))[$1 - 1]/er,
        sort_by {$_->{id}}
        CH_009::rank(
            CH_009->R_STD,
            map +{id => $id++, score => $_}, @_
        )->@*];
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        
        is rank(1,2,4,3,5),     [qw(5 4 S B G)],     'example 1';
        is rank(8,5,6,7,4),     [qw(G 4 B S 5)],     'example 2';
        is rank(3,5,4,2),       [qw(B G S 4)],       'example 3';
        is rank(2,5,2,1,7,5,1), [qw(4 S 4 6 G S 6)], 'example 4';
    }

    SKIP: {
        skip "tests" unless $tests;
	}

    done_testing;
    exit;
}
