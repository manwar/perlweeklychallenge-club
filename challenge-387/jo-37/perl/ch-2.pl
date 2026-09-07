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

usage() unless @ARGV == 1;

sub usage {
    die <<~EOS;
    $0 - molecular formula

    usage: $0 [-examples] [-tests] [FORMULA]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    FORMULA
        a chemical formula

    EOS
}


### Input and Output

say molecular_formula(shift);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/08/21/ch-387.html#task-2

sub molecular_formula {
    # push an empty hash onto the stack and return the ref
    state sub push_h :prototype(\@) ($st) {
        push @$st, {};
        $st->[-1];
    }
    # pop the top hash from the stack and return old and new top
    state sub pop_h :prototype(\@) ($st) {
        (pop(@$st), $st->[-1]);
    }
    # multiply values in %$y by $f and add these to the values in
    # %$x
    state sub add_mult ($x, $y, $f) {
        while (my ($k, $v) = each %$y) {
            $x->{$k} += $v * $f;
        }
    }
    # format molecular formula
    state sub print_mol ($h) {
        join '',
        map +($_, $h->{$_} x ($h->{$_} > 1)),
        sort keys %$h;
    }
    my @stack;
    my $cur = push_h @stack;
    shift =~ m{
        ^
        (?<group>
            (?:
                (?<elem>\p{Lu}\p{Ll}?+)
                (?&REP)
                (?{ $cur->{$+{elem}} += $^R; })
            |
                \(
                (?{ $cur = push_h @stack; })
                (?&group)
                \)
                (?&REP)
                (?{ (my $top, $cur) = pop_h @stack;
                    add_mult($cur, $top, $^R);
                })
            )++
        )
        $
        (?(DEFINE)
            (?<REP>
                ((?:[1-9]\d*+)?+)
                (?{ $+ || 1 })
            )
        )
    }x && print_mol $cur;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name, $reason=undef) {
        my $todo = $reason ? todo $reason : undef;
        my $result = molecular_formula(@$args);
        is $result, $expected,
            "$name: (@$args) -> $expected";
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [["((N2O)3(H2O)2)2"], "H8N12O10", 'example 1'],
            [["Mg3(PO4)2"], "Mg3O8P2", 'example 2'],
            [["(((H)2)3)4"], "H24", 'example 3'],
            [["NaCl3(O2(S10)2)2Mg"], "Cl3MgNaO4S40", 'example 4'],
            [["Z2Y3(X2W)2"], "W2X4Y3Z2", 'example 5'],
        );
        plan scalar @examples;
        run_example @$_ for @examples;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 3;
        is molecular_formula("NH4NO3"), "H4N2O3",
            'ammonium nitrate';
        is molecular_formula("(NH4)2HPO4"), "H9N2O4P",
            'diammonium hydrogen phosphate';
        is molecular_formula("NH(CH2)6NHCO(CH2)4CO"), "C12H22N2O2",
            'polyamid monomere'
    }) : pass 'skip tests';

    exit;
}
