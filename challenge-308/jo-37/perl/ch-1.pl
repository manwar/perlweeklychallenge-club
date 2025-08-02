#!/usr/bin/perl

use v5.26;
use Test2::V0;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Util qw(min sum);


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
    $0 - Count common strings

    usage: $0 [-examples] [-tests] [LIST1 LIST2...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    LIST1 LIST2...
        lists of comma-separated strings

    EOS
}


### Input and Output

say count_common(map [split /,/, $_], @ARGV);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/14/ch-308.html#task-1


sub count_common {
    my %count;
    my @z = (0) x @_;
    while (my ($i, $strings) = each @_) {
        ($count{$_} //= [@z])->[$i]++ for @$strings;
    }
    sum map min(@$_), values %count;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = count_common(@$args);
        is $result, $expected,
            "$name: " . join(" ", map "(@$_)", @$args) . " -> $expected";
    }

    plan 1;

    subtest_streamed('examples and tests' => sub {
        my @examples;
        push @examples, 
            [[["perl", "weekly", "challenge"],
                    ["raku", "weekly", "challenge"]], 2, 'example 1'],
            [[["perl", "raku", "python"],
                    ["python", "java"]], 1, 'example 2'],
            [[["guest", "contribution"],
                    ["fun", "weekly", "challenge"]], 0, 'example 3']
            if $examples;
        push @examples, 
            [[[qw(abc abc cde cde efg)], [qw(abc abc cde ghi)]], 3,
                'non-unique strings'],
            [[[qw(abc cde)], [qw(abc efg)], [qw(abc ghi)]], 1,
                'three arrays']
            if $tests;
        
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    });

    exit;
}
