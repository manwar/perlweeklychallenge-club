#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use String::Compile::Tr;


### Options and Arguments

my ($tests, $examples, $remove_pairs, $make_good, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    '1!'        => \$remove_pairs,
    '2!'        => \$make_good,
) or usage();
$remove_pairs = 1 unless $make_good;

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - good string

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

say "remove pairs: '@{[remove_pairs(@ARGV)]}'" if $remove_pairs;
say "make good:    '@{[make_good(@ARGV)]}'" if $make_good;


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/07/04/ch-328.html#task-2


sub remove_pairs ($str) {
    1 while $str =~ s/(\p{Lu})(??{lc $1})|(\p{Ll})(??{uc $2})//;
    $str;
}

sub make_good {
    shift =~ s/(\p{LC})\1+/
    trgen(2 * trgen(lc($1))->($&) < length($&) ? lc($1) : uc($1),
        '', 'dr')->($&);
    /iegr;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($str, $removed, $good, $name) {
        subtest(qq{$name: "$str"} => sub {
            plan 2;
            my $result1 = remove_pairs($str);
            is $result1, $removed,
                qq{remove pairs -> "$removed"};
            my $result2 = make_good($str);
            is $result2, $good,
                qq{make good -> "$good"};
        });
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            ['WeEeekly', 'Weekly', 'Weeekly', 'example 1'],
            ['abBAdD', '', 'abAd', 'example 2'],
            ['abc', 'abc', 'abc', 'example 3'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 2;
        run_example('WeEeEkly', 'Wkly', 'Weekly', 'even repetitions');
        run_example('WeEeEekly', 'Wekly', 'Weeekly', 'odd repetitions');
    }) : pass 'skip tests';

    exit;
}
