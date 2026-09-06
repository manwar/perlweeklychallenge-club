#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use experimental 'signatures';


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV == 3;

sub usage {
    die <<~EOS;
    $0 - reorder notes

    usage: $0 [-examples] [-tests] [COMP NOTES PERM]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    COMP
        a string, name of composer

    NOTES
        blank separated list of notes

    PERM
        blank separated permutation

    EOS
}


### Input and Output

say reorder_notes([$ARGV[0], map [split], @ARGV[1,2]]);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/09/04/ch-389.html#task-1

sub reorder_notes {
    my ($composer, $notes, $perm) = shift()->@*;
    (\my @ordered)->@[@$perm] = @$notes;
    shift @ordered unless defined $ordered[0];

    "@{[uc $composer]} => @ordered";
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = reorder_notes(@$args);
        my ($composer, $notes, $perm) = $args->[0]->@*;
        is $result, $expected,
            "$name: ($composer, [@$notes], [@$perm]) ->  $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        no warnings 'qw';
        my @examples = (
            [[['Bach', [qw(C D E F# G A B)], [7, 1, 6, 2, 5, 3, 4]]],
                'BACH => D F# A B G E C', 'example 1'],
            [[['Beethoven', [qw(C D F# G Ab)], [1, 3, 5, 2, 4]]],
                'BEETHOVEN => C G D Ab F#', 'example 2'],
            [[[ 'Brahms', [qw(C Db Eb F G Ab Bb C D)],
                        [9, 3, 7, 1, 8, 5, 2, 6, 4] ]],
                'BRAHMS => F Bb Db D Ab C Eb G C', 'example 3'],
            [[[ 'Bruckner', [qw(G F# Bb C D Eb F)],
                        [4, 7, 2, 6, 1, 5, 3] ]],
                'BRUCKNER => D Bb F G Eb C F#', 'example 4'],
            [[['Berg', [qw(C#)], [1]]],
                'BERG => C#', 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        no warnings 'qw';
        plan 1;
        is reorder_notes(['Bach', [qw(C D E F# G A B)],
                [6, 0, 5, 1, 4, 2, 3]]),
                'BACH => D F# A B G E C', 'zero-based';
    }) : pass 'skip tests';

    exit;
}
