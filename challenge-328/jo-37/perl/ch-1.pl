#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental qw(signatures vlb);


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
    $0 - replace all ?

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

say replace_all(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/04/ch-328.html#task-1

sub rc {
    (\my %c)->@{'a' .. 'z'} = ();
    delete @c{@_};

    scalar each %c;
}

sub replace_all ($str) {
    1 while $str =~ s/(?<=([^?]?))\?(?=([^?]?))/rc($1, $2)/e;

    $str;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($str, $name) {
        my $result = replace_all($str);
        my $pattern = $str =~ s/\?/./gr;
        subtest("$name: $str -> $result" => sub {
            plan 2;
            like $result, qr/$pattern/, 'match characters';
            unlike $result, qr/(.)\1/, 'no repeated characters';
        });
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            ['a?z', 'example 1'],
            ['pe?k', 'example 2'],
            ['gra?te', 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        run_example('a???b', 'adjacent question marks');
    }) : pass 'skip tests';

    exit;
}
