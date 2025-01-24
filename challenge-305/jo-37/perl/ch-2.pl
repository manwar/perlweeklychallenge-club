#!/usr/bin/perl -T

use v5.26;
use Test2::V0;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use Unicode::Normalize;
use warnings FATAL => 'all';
use Data::Dump qw(dd pp);
use experimental 'signatures';
use utf8;

### Options and Arguments

my ($tests, $examples, $verbose, $order);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
    'order=s'   => \$order,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV;

sub usage {
    die <<~EOS;
    $0 - alien sort

    usage: $0 [-examples] [-tests] [-order C,... W...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -order C,...
        comma and/or whitspace separated list of characters 'a' .. 'z'

    W...
        list of words

    EOS
}


### Input and Output

say "@{[alien_sort([split /[,\s]\s*/, $order], @ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/01/24/ch-305.html#task-2

BEGIN {
    my @all = 'a' .. 'z';

    sub alien_sort ($order, @words) {
        my %a2n;
        @a2n{@$order} = @all;
        die 'order not valid' if @all > grep defined, @a2n{@all};
        my %n2a = map {$a2n{$_} => $_} @all;
        my $alien = join '', @n2a{@all};

        map $_->[0],
            sort {$a->[1] cmp $b->[1]}
            map {
                [$_, eval "NFD(fc) =~ tr/a-z//cdr =~ tr/$alien/a-z/r"]
            } @words;
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = [alien_sort(@$args)];
        my $alien = shift @$args;
        like $result, $expected,
            "$name: alien='@$alien' (@$args) -> (@$expected)", $@;
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/],
                    "perl", "python", "raku"],
                ["raku", "python", "perl"], 'example 1'],
            [[[qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/],
                    "the", "weekly", "challenge"],
                ["challenge", "the", "weekly"], 'example 2'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 5;
        my $tainted = substr $ENV{PATH}, 0, 0;

        ok lives {alien_sort([map $_ . $tainted, 'a' .. 'z'], 'abc')},
            'laundered', $@;

        like dies {alien_sort(['//;die-gotcha;tr/a', 'a' .. 'z'], 'abc')},
            qr/order not valid/, 'missing letter in order';

        ok lives {alien_sort(['a' .. 'z', '//;exit;tr/a-z'],
                'abc', 'bcd')}, 'ignore injection', $@;

        is [alien_sort([qw(z y a c b), 'd' .. 'x'], qw(ab ac yb zb))],
            [qw(zb yb ac ab)], 'alien order';

        is [alien_sort([qw(a e i o u b c d f g h j k
                    l m n p q r s t v w x y z),],
                'Oc', 'Öc', 'oc', 'öc', 'oe', 'öe', 'Oe', 'Öe')],
        ['oe', 'öe', 'Oe', 'Öe', 'Oc', 'Öc', 'oc', 'öc'], 'upper and umlauts';
    }) : pass 'skip tests';

    exit;
}
