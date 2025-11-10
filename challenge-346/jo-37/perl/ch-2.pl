#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';

use Set::Product 'product';
use List::Gather;
use Math::Pari 'PARI';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 2;

sub usage {
    die <<~EOS;
    $0 - magic expression

    usage: $0 [-examples] [-tests] [-verbose] [--] [STR TARGET]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    STR
        string of decimal digits, may have leading zeroes

    TARGET
        an integer

    EOS
}


### Input and Output

say "(@{[magic_expression(@ARGV)]})";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/11/07/ch-346.html#task-2

sub magic_expression ($str, $target) {
    state $op = ['', '+', '-', '*'];
    my ($n, $t, $nz, $e) = (length($str), PARI($target), $str !~ /0./);
    return $str == $target ? $str : () if $n == 1;
    my @expr = split /()/, $str;
    my @odd = map 2 * $_ + 1, 0 .. $n - 2;

    gather {
        product {
            @expr[@odd] = @_;
            $e = join '', @expr;
            ($nz || $e !~ /(?<!\d)0\d/) && $t == PARI($e) && take $e;
        } ($op) x ($n - 1);
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = [magic_expression(@$args)];
        like $result, $expected,
            "$name: (@$args) -> (@{[map q(') . $_->expect . q('), $expected->items->@*]})";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[123, 6],
               bag {item '1+2+3'; item '1*2*3'; end}, 'example 1'],
            [[105, 5],
               bag {item '1*0+5'; item '10-5'; end}, 'example 2'],
            [[232, 8],
               bag {item '2+3*2'; item '2*3+2'; end}, 'example 3'],
            [[1234, 10],
               bag {item '1+2+3+4'; item '1*2*3+4'; end},
               'example 4'],
            [[1001, 2], 
               bag {item '1+0*0+1'; item '1+0+0+1';
                   item '1+0-0+1'; item '1-0*0+1';
                   item '1-0+0+1'; item '1-0-0+1'; end},
               'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        my @tests = (
            [[111, 4],
               bag {end}, 'no solution'],
            [[1, 1],
               bag {item '1'; end}, 'single digit, success'],
            [[1, 2],
               bag {end}, 'single digit, failure'],
            [[111, 111],
               bag {item '111'; end}, 'single value'],
            [[1000, 10],
               bag {item '10+0+0'; item '10+0-0'; item '10+0*0';
                   item '10-0+0'; item '10-0-0'; item '10-0*0';
                   end}, 'trailing zeroes'],
            [['0001', 1],
               bag {item '0+0+0+1'; item '0+0-0+1'; item '0+0*0+1'; 
                   item '0-0+0+1'; item '0-0-0+1'; item '0-0*0+1';
                   item '0*0+0+1'; item '0*0-0+1'; item '0*0*0+1';
                   end}, 'leading zeroes'],
            [[1234567890, 123456789],
               bag {item '123456789+0'; item '123456789-0'; end},
               'more digits'],
        );
        plan scalar @tests;
        run_example @$_ for @tests;
    }) : pass 'skip tests';

    exit;
}
