#!/usr/bin/perl -s

use v5.24;
use Test2::V0 '!float';
use PDL;
use PDL::NiceSlice;
use PDL::Char;
use experimental 'signatures';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose]  [ROW... WORD]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    enable trace output

ROW...
    strings representing the grid's rows, e.g ABDE CBCA BAAD DBBC for example 1

WORD
    word to search for in the grid

EOS


### Input and Output

say +(qw(true false))[!find_word([map [split //], @ARGV[0..$#ARGV-1]], $ARGV[-1])];


### Implementation
#
# For details see:
# https://github.sommrey.de/the-bears-den/2024/12/13/ch-299.html#task-2

our $lvl;

sub dbg {
    say '  ' x ($lvl - 1), @_ if $verbose;
}

sub find_word ($matrix, $word) {
    local $lvl = 1;
    my $m = PDL::Char->new($matrix);
    dbg "matrix:\n", $m;
    dbg "indices:", sequence $m->long->((0));
    my $label = $m->clump(1, 2);

    my $w = PDL::Char->new([$word]);
    dbg "word: ", $w(,(0));
    my $start = ($label == $w(0))->long;;
    dbg "starting with ", $w((0)), "at ", which $start;

    my $adj4 = zeroes +($m((0))->dims) x 2;
    $adj4( 0:-2,,1:-1)->clump(0, 1)->clump(1, 2)->diagonal(0, 1) .= 1;
    $adj4(,0:-2,,1:-1)->clump(0, 1)->clump(1, 2)->diagonal(0, 1) .= 1;
    my $adj = $adj4->clump(0, 1)->clump(1, 2)->sever;
    $adj |= $adj->xchg(0, 1)->sever;

    $lvl = 0;
    find_tail($adj, $label, $start, $w(1:-1));
}

sub find_tail ($adj, $label, $start, $tail) {
    local $lvl = $lvl + 1 ;
    dbg "tail:  ", $tail(,(0));
    dbg "search ", $tail( (0)), "from ", which $start;

    my $l = ($label == $tail(0))->long;
    my $next = $l * ($adj x $start);
    dbg("fail: ", $tail((0)), "is not reachable from ", which $start),
    return 0 if !any $next;
    dbg("success with ", $tail((0)), "from ", which($start),
        " at ", which($next)),
    return 1 if $tail->dim(0) == 1;

    $start = ($start * ($adj x $next))->long->hclip(1)
        if which($start)->nelem > 1;

    my $ws = which $start;
    dbg $tail((0)), "is reachable from $ws";
    for my $v ($ws->list) {
        dbg "proceding with ", $label(,($v)), "-> ", $tail((0)), "from $v";
        my $start1 = $ws->nelem == 1 ? $next :
            $l * ($adj x zeroes($start)->set(0,$v,1));

        my $adj1 = $adj->copy;
        $adj1( $v) .= 0;
        $adj1(,$v) .= 0;
        dbg("success"),
        return 1 if find_tail($adj1, $label, $start1, $tail(1:-1));
    }
    dbg "fail";
    0;
}

### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;
        ok find_word([['A', 'B', 'D', 'E'],
                      ['C', 'B', 'C', 'A'],
                      ['B', 'A', 'A', 'D'],
                      ['D', 'B', 'B', 'C']],
                  'BDCA'), 'example 1';

        ok !find_word([['A', 'A', 'B', 'B'],
                       ['C', 'C', 'B', 'A'],
                       ['C', 'A', 'A', 'A'],
                       ['B', 'B', 'B', 'B']],
                   'ABAC'), 'example 2';

        ok find_word([['B', 'A', 'B', 'A'],
                      ['C', 'C', 'C', 'C'],
                      ['A', 'B', 'A', 'B'],
                      ['B', 'B', 'A', 'A']],
                  'CCCAA'), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        ok find_word([['B', 'A', 'B', 'A'],
                      ['C', 'C', 'C', 'C'],
                      ['A', 'B', 'A', 'B'],
                      ['B', 'B', 'A', 'A']],
                  'CCCBAA'), 'like example 3';

        ok find_word([
                [qw(D A B C)],
                [qw(C A B D)],
                [qw(B A A E)],
                [qw(A C B A)]], 'AABABCABCDABCDE'), 'helix';

        ok find_word([
                [qw(A D A)],
                [qw(A C A)],
                [qw(C B C)],
                [qw(A A A)]], 'ABCDA'), 'reduce vertex sets';
    }

    done_testing;
    exit;
}
