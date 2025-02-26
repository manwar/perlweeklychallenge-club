#!/usr/bin/perl

use v5.26;
use Test2::V0 '!float', -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
use Getopt::Long;
use experimental 'signatures';

use PDL;
use PDL::NiceSlice;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - Arrays Intersection

    usage: $0 [-examples] [-tests] [-verbose] [--] [A...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        enable trace output

    A...
        list of arrays as accepted by the PDL string constructor, e.g.
        '1,2,3,4;4,5,6,1;4,2,1,3' or '[1, 2, 3], [4, 5], [6]]'

    EOS
}


### Input and Output

printset(arrays_intersection(@ARGV), 0);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/28/ch-310.html#task-1

BEGIN {
    broadcast_define 'intersect_over(a(m,n);[o]b(n))' => over {
        my $tmp;
        for my $set ($_[0]->xchg(0, 1)->dog) {
            $tmp = $set, next unless defined $tmp;
            next unless $set->ngood;
            $tmp = intersect $tmp, $set;
        }
        my $card = $tmp->nelem;
        reshape($tmp, $_[1]->dims);
        $_[1] .= $tmp->setbadif(sequence($tmp) >= $card);
    };

    # print set or collect it in a provided array
    broadcast_define 'printset(a(n)), NOtherPars => 1' => over {
        my $set = $_[0]->($_[0]->isgood;?);
        if (ref $_[1] eq 'ARRAY') {
            push $_[1]->@*, $set->sever;
        } else {
            say $set;
        }
    }
}

sub arrays_intersection {
    local $PDL::undefval = long->badvalue;
    my $list = long(@_)->xchg(0, 1);
    $list->badflag(1);
    intersect_over($list, my $res = null);
    $res;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        printset(arrays_intersection(@$args), \my @result);
        my $exp = pdl $expected;
        pdl_is $result[0], $exp,
            qq{$name: @{[map "(@$_)", @$args]} -> $exp};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]], [1, 4], 'example 1'],
            [[[1, 0, 2, 3], [2, 4, 5]], [2], 'example 2'],
            [[[1, 2, 3], [4, 5], [6]], empty, 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        my $in = [
            [[1, 2, 3, 4], [4, 5, 6, 1], [4, 2, 1, 3]],
            [[1, 0, 2, 3], [2, 4, 5]],
            [[1, 2, 3], [4, 5], [6]]];
        my $res = arrays_intersection($in);
        printset($res, 0);
        pdl_is $res, long('1 4 bad bad; 2 bad bad bad; bad bad bad bad'),
            'all at once';
                
        pdl_is arrays_intersection([[1, 4]]), long([1, 4]), 'single array';

    }) : pass 'skip tests';

    exit;
}
