#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use bigint;
use Math::Prime::Util qw(vecsum vecprod factorial vecreduce);
use List::AllUtils qw(sort_by count_by pairs);
use experimental qw(refaliasing signatures);

our ($tests, $examples, $benchmark);

run_tests() if $tests || $examples || $benchmark;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-tests] [W]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-benchmark
    run benchmark

W
    a word

EOS


### Input and Output

say 1 + dictionary_rank(shift);


### Implementation

sub dictionary_rank {
    no bigint;
    my @chars = split //, shift;
    my @freq = sort_by {$_->[0]} pairs count_by {$_} @chars;
    (\my %chartoidx)->@{map $_->[0], @freq} = 0 .. $#freq;
    my @mperm = @chartoidx{@chars};
    my @mset = map $_->[1], @freq;
    
    use bigint;
    my $mult = factorial(@mperm) / vecprod map factorial($_), @mset;
    multipermtonum(0->copy, $mult, \@mperm, \@mset);
}

sub multipermtonum ($, $, $perm, $set) {
    \my $num = \$_[0];
    \my $mult = \$_[1];
    my $n = @$perm;
    return $num if $n == 1;
    my $first = shift @$perm;

    $num += vecreduce {
        $a + $mult * $set->[$b] / $n;
    } 0, grep $set->[$_], 0 .. $first - 1;

    $mult = $mult * $set->[$first]-- / $n;

    goto &multipermtonum;
}

# for cross check and benchmarking
use Math::Prime::Util qw(formultiperm lastfor);
sub count_rank {
    my $word = shift;
    my @word = split //, $word;
    my $rank = 0;
    local $" = '';
    formultiperm {"@_" lt $word ? $rank++ : lastfor} \@word;
    $rank;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is dictionary_rank('cat'), 2, 'example 1';
        is dictionary_rank('google'), 87, 'example 2';
        is dictionary_rank('secret'), 254, 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        my $word;
        $word = join '', reverse 'a' .. 'z';
        is dictionary_rank($word), factorial(26) - 1, $word;
        $word = join '', map $_ x 2, reverse 'a' .. 'p';
        is dictionary_rank($word), factorial(32) / 2**16 - 1, $word;
	}

    SKIP: {
        use Benchmark 'cmpthese';
        skip "benchmark" unless $benchmark;

        # cross check against enumeration
        my @alphabet = qw(e o t h a s i n r d);
        my @word;
        push @word, $alphabet[rand @alphabet] for 0 .. 9;
        my $word = join '', @word;

        my $rank;
        is $rank = dictionary_rank($word), count_rank($word),
            "rank('$word') = $rank";

        cmpthese(0, {
                count => "count_rank($word)",
                calc => "dictionary_rank($word)"
            });
    }

    done_testing;
    exit;
}

__DATA__
        Rate   count    calc
count 1.89/s      --   -100%
calc  1907/s 100981%      --
