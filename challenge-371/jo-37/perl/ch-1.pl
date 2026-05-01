#!/usr/bin/perl

use v5.26;
use Test2::V0 qw(!float -no_srand);
use Test2::Tools::Subtest 'subtest_streamed';
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
    $0 - missing letter

    usage: $0 [-examples] [-tests] [C...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    C...
        list of characters (or strings that will be split)

    EOS
}


### Input and Output

say "@{[missing_letter(map split(//), @ARGV)]}";


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/05/01/ch-371.html#task-1

sub missing_letter {
    # difference between the elements of a two-value ndarray
    state sub pdiff {inner long(-1, 1), shift}

    # convert to code point and set question marks to BAD
    # get a mask of good values and create a sequence in the length of
    # $l
    my $l = long(map ord, @_)->setvaltobad(ord('?'));
    my $good = $l->isgood;
    my $seq = sequence $l;

    # sum of good indices mod 2, must not be zero or number of good
    # values.  Find a congruent pair mod 2.
    my $sum = ($seq->copybad($l) % 2)->sum;
    die "underdetermined" if $l->ngood < 3 || $sum == 0 || $sum == $l->ngood;
    my $sel = ($seq + ($sum > 1)) % 2;
    my $pair = which($good & !$sel)->(0:1);
    my $pair0 = $pair((0));

    # value diff and index diffs for the pair, find the step size
    my $vdiff = pdiff($l($pair));
    my $idiff = pdiff($pair) / 2;
    die "not integer" if $vdiff % $idiff;
    $vdiff /= $idiff;

    # find an index not congruent mod 2 to the pair
    my $other = which($good & $sel)->((0));

    # assign reference indices for all index positions, generate
    # the two lines and check consistency
    my $indx = indx($pair0, $other)->($sel);
    my $gen = $l($indx) + $vdiff * ($seq - $indx) / 2;
    die "conflict" if any $gen($good;?) != $l($good;?);

    # range check
    my ($min, $max) = minmax $gen;
    die "out of range" if $min < ord('a') || $max > ord('z');

    # back-transformation
    map chr, $gen(!$good;?)->list;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my @result = missing_letter(@$args);
        is \@result, $expected,
            "$name: (@$args) -> @$expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[qw(a c ? g i)], ['e'], 'example 1'],
            [[qw(a d ? j m)], ['g'], 'example 2'],
            [[qw(a e ? m q)], ['i'], 'example 3'],
            [[qw(a c f ? k)], ['h'], 'example 4'],
            [[qw(b e g ? l)], ['j'], 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 12;
        like dies {missing_letter(qw(a c ? ?))}, qr/underdetermined/,
            'no pair / even';
        like dies {missing_letter(qw(? b d ? ?))}, qr/underdetermined/,
            'no pair / odd';
        like dies {missing_letter(qw(a ? c ? d))}, qr/underdetermined/,
            'no other / even';
        like dies {missing_letter(qw(? b ? d ? f))}, qr/underdetermined/,
            'no other / odd';
        like dies {missing_letter(qw(a b ? ? f))}, qr/integer/, 'not integer';
        like dies {missing_letter(qw(a b c ? f))}, qr/conflict/, 'conflict';
        like dies {missing_letter(qw(x y z ?))}, qr/range/, 'out of range';
        like dies {missing_letter(qw(c b a ?))}, qr/range/, 'out of range';
        is [missing_letter(qw(a ? ? ? k ? ? q))], [qw(b f g l p)],
            'distant letters'; 
        is [missing_letter(qw(a c f ? ?))], [qw(h k)], 'like example 4';
        is [missing_letter(qw(? c f ? k))], [qw(a h)], 'like example 4';
        is [missing_letter(qw(a c f h k))], [], 'consistency check';
    }) : pass 'skip tests';

    exit;
}
