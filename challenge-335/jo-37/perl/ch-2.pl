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
    $0 - Tic Tac Toe

    usage: $0 [-examples] [-tests] [-verbose] [MOVE...]

    -examples
        run the examples from the challenge
     
    -tests
        run some tests

    -verbose
        print filled board

    MOVE...
        list of moves in a form like '[x, y],...' or 'x,y;...'

    EOS
}


### Input and Output

say tictactoe("@ARGV");


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2025/08/22/ch-335.html#task-2

use constant N => 3;
use Constant::Generate {A => 1, B => N + 1}, dualvar => 1;

{
    my $lines;

    BEGIN {
        my $rows = ndcoords indx, N, N;
        $lines = $rows->glue(2, $rows(-1:0)->sever,
            $rows->diagonal(1, 2)->sever,
            $rows(,-1:0)->diagonal(1, 2)->sever);
    }

    sub tictactoe {
        my $moves = indx @_;
        my $board = zeroes long, N, N;
        $board->indexND($moves) .= long(A, B)->range(0, $moves->dim(1), 'p');
        say $board if $verbose;
        die "overwritten" if which($board)->nelem < $moves->dim(1);
        my $winner = setops(
            $board->indexND($lines)->sumover, 'AND', N * long(A, B)
        ) / N;
        die "post-final move" if $winner->nelem > 1;
        return $board->all ? "Draw" : "Pending" if $winner->isempty;
        $winner == A ? A : B; # return dual-valued constant
    }
}


### Examples and Tests

sub run_tests ($examples, $tests) {
    return unless $examples || $tests;

    state sub run_example ($args, $expected, $name) {
        my $result = tictactoe(@$args);
        is $result, $expected,
            qq{$name: (@{[map "[@$_]", @$args]}) -> $expected};
    }

    plan 2;

    $examples ? subtest_streamed(examples => sub {
        my @examples = (
            [[[0,0],[2,0],[1,1],[2,1],[2,2]], A, 'example 1'],
            [[[0,0],[1,1],[0,1],[0,2],[1,0],[2,0]], B, 'example 2'],
            [[[0,0],[1,1],[2,0],[1,0],[1,2],[2,1],[0,1],[0,2],[2,2]],
                "Draw", 'example 3'],
            [[[0,0],[1,1]], "Pending", 'example 4'],
            [[[1,1],[0,0],[2,2],[0,1],[1,0],[0,2]], B, 'example 5'],
        );
        plan scalar @examples;
        for (@examples) {
            run_example @$_;
        }
    }) : pass 'skip examples';

    $tests ? subtest_streamed(tests => sub {
        plan 4;
        like dies {tictactoe([1, 1], [1, 1])}, qr/overwritten/, 'overwritten';
        like dies {tictactoe([1,1],[0,0],[2,2],[0,1],[1,0],[0,2],[1,2])},
            qr/post-final/, 'post-final move';
        like dies {tictactoe([0, 0], [0, N])}, qr/out-of-bounds/,
            'out of bounds';
        is tictactoe([0,1],[1,1],[1,0],[1,2],[2,0],[2,1],[0,2],[2,2],[0,0]),
            A, 'double win';
    }) : pass 'skip tests';

    exit;
}
