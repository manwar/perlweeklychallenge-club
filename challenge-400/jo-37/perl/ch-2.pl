#!/usr/bin/perl

use v5.26;
use Test2::V0 -no_srand;
use Test2::Tools::Subtest 'subtest_streamed';
use Getopt::Long;
use JSON ();
use File::Basename ();
use constant EXMP => File::Basename::dirname(__FILE__) . 
    '/../../examples/json/ch-2.json';
use experimental 'signatures';

use feature 'bitwise';
use Graph::Undirected;


### Options and Arguments

my ($tests, $examples, $verbose);
GetOptions(
    'examples!' => \$examples,
    'tests!'    => \$tests,
    'verbose!'  => \$verbose,
) or usage();

run_tests($examples, $tests);	# tests do not return

usage() unless @ARGV > 2;

sub usage {
    die <<~EOS;
    $0 - minimum genetic mutation

    usage: $0 [-examples] [-tests] [-verbose] [--] [S E B...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    S
        start gene

    E
        end gene

    B...
        genes included in the gene bank

    EOS
}


### Input and Output

say mgm(@ARGV[0, 1], [@ARGV[2..$#ARGV]]);


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2026/11/20/ch-400.html#task-2

sub mgm ($start, $end, $b) {
    my @b = ($start, @$b);
    my $g = Graph::Undirected->new(vertices => [$end, @$b]);
    while (my $x = shift @b) {
        1 == grep $_, unpack 'c*', $x ^. $_ and $g->add_edge($x, $_) for @b;
    }

    @{[$g->SP_Dijkstra($start, $end)]} - 1;
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    use Data::Dump 'pp';
    return unless $examples || $tests;

    state sub fa {
        [join ', ', map(pp($_), @_)];
    }

    state sub run_example ($args, $expected, $name) {
        my $result = [mgm(@$args)];

        is $result, $expected,
            "$name: (@{fa(@$args)}) -> @{fa(@$expected)}";
    }

    plan 2;
    my $exmp = do {
        use autodie;
        local $/;
        open my $xfh, '<', EXMP;
        my $ex = JSON->new->utf8->boolean_values(0, 1)->decode(<$xfh>);
        close $xfh;
        $ex; 
    };

    $examples ? subtest_streamed($exmp->{challenge}{name} => sub {
        plan scalar $exmp->{examples}->@*;
        run_example $_->{in}, $_->{out}, $_->{name}
            for $exmp->{examples}->@*;
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 1;
        pass 'no tests';
    }) : pass 'skip tests';

    exit;
}
