#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use List::Gather;
use PDL;
use PDL::Char;
use PDL::NiceSlice;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - reverse string

    usage: $0 [-examples] [-tests] [STR]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        a string

    EOS
}


### Input and Output

say reverse_slice(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/06/28/ch-379.html#task-1

sub reverse_slice ($str) {
    join '', (split //, $str)[map -$_, 1 .. length $str];
}

# gather/take instead of push
sub reverse_pop ($str) {
    my @arr = split //, $str;
    join '', gather {take pop @arr while @arr};
}

# like shift/unshift
sub reverse_substr ($str) {
    my $rev = '';
    substr($rev, 0, 0) = substr $str, 0, 1, '' while length $str;
    $rev;
}

# avoid copying
sub reverse_inplace ($str) {
    substr($str, 0, 0) = substr $str, $_, 1, '' for 1 .. length($str);
    $str;
}

# natively fails on an empty string
sub reverse_pdl ($str) {
    length($str) ? PDL::Char->new($str)->(-1:0)->atstr(0) : '';
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        subtest("$name: '@$args' -> '$expected'" => sub {
            for (qw(reverse_slice reverse_pop reverse_substr reverse_inplace
                    reverse_pdl)) {
                no strict 'refs';
                my $result = &$_(@$args);
                is $result, $expected, $_;
            }
            done_testing;
        });
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[""], "", 'example 1'],
            [["reverse the given string"], "gnirts nevig eht esrever",
                'example 2'],
            [["Perl is Awesome"], "emosewA si lreP", 'example 3'],
            [["v1.0.0-Beta!"], "!ateB-0.0.1v", 'example 4'],
            [["racecar"], "racecar", 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
