#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
use Test2::Tools::PDL;
use Benchmark 'cmpthese';
use Getopt::Long;
use experimental qw(signatures bitwise);

use List::Util 'reductions';
use List::MoreUtils 'slide';
use PDL;
use PDL::NiceSlice;

### Options and Arguments

my ($tests, $examples, $benchmark, $verbose, $init, $encode);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'benchmark!'    => \$benchmark,
    'verbose!'  => \$verbose,
    'initial=i' => \$init,
) or usage();

run_tests($examples, $tests, $benchmark);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - Decode XOR

    usage: $0 [-examples] [-tests] [-initial I] [N..]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -initial I
        use I as inital value for the original list or
        encode numbers if this option is not specified

    N...
        list of numbers

    EOS
}


### Input and Output

say "@{[defined $init ? decode_xor($init, @ARGV) : encode_xor(@ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/02/14/ch-308.html#task-2

sub decode_xor {
    reductions {$a ^ $b} @_;
}

sub encode_xor {
    slide {$a ^ $b} @_;
}

sub decode_xor_pdl {
    my $init = shift;
    my $enc = long @_;
    my $orig = zeroes(long, $enc->dim(0) + 1)->set(0, $init);
    PDL::xor($enc, $orig(0:-2), $orig(1:-1), 0);
    $orig;
}

sub encode_xor_pdl {
    my $orig = long @_;
    $orig(0:-2) ^ $orig(1:-1);
}

### Examples and Tests

sub run_tests ($examples, $tests, $benchmark) {
    return unless $examples || $tests || $benchmark;

    state sub run_example ($args, $expected, $name) {
        my @result = decode_xor(@$args);
        is \@result, $expected,
            "$name: $args->[0] => ($args->@[1..$#$args]) -> (@$expected)";
    }

    plan 3;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[1 ,=> 1, 2, 3], [1, 0, 2, 1], 'example 1'],
            [[4 ,=> 6, 2, 7, 3], [4, 2, 0, 7, 4], 'example 2'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 6;
        is [encode_xor(1, 0, 2, 1)], [1, 2, 3], 'encode example 1';
        is [encode_xor(4, 2, 0, 7, 4)], [6, 2, 7, 3], 'encode example 2';
        pdl_is decode_xor_pdl(1 ,=> 1, 2, 3), long(1, 0, 2, 1),
            'decode example 1 pdl';
        pdl_is decode_xor_pdl(4 ,=> 6, 2, 7, 3), long(4, 2, 0, 7, 4),
            'decode example 2 pdl';
        pdl_is encode_xor_pdl(1, 0, 2, 1), long(1, 2, 3),
            'encode example 1 pdl';
        pdl_is encode_xor_pdl(4, 2, 0, 7, 4), long(6, 2, 7, 3),
            'encode example 1 pdl';
    }) : pass 'skip tests';

    $benchmark ? subtest_streamed(benchmark => sub {
        plan 2;

        my $orig = (2**31 * random(2**18))->long;
        my @orig = $orig->list;
        my $enc = encode_xor_pdl($orig);
        is $enc->unpdl, [encode_xor(@orig)], 'cross check encode';

        my $init = $orig->at(0);
        my @enc = $enc->list;
        is decode_xor_pdl($init, $enc)->unpdl,
            [decode_xor($init, @enc)], 'cross check decode';
        
        cmpthese(0, {
                enc_list => sub {encode_xor    (@orig)},
                enc_pdl  => sub {encode_xor_pdl($orig)},
                dec_list => sub {decode_xor    ($init, @enc)},
                dec_pdl  => sub {decode_xor_pdl($init, $enc)},
        });
    }) : pass 'skip benchmark';

    exit;
}
