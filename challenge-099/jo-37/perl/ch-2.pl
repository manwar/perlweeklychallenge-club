#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use experimental 'signatures';
use charnames ':full';

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-verbose] [string sequence]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    show subsequence in string

string
    string to examine

sequence
    sequence of chars to search for in <string>

EOS


### Input and Output

say matchseq($ARGV[0], $ARGV[1]);


### Implementation

# Count occurences of a character sequence within a string.
sub matchseq ($str, $seq) {

    # Create a regex that matches the character sequence and captures
    # all of its characters individually.
    # Example transformation chain:
    # 'x*' -> ('x', '*') -> ('x', '\\*') -> (?:(x).*?(\*))
    my $seqmatch = sub {
        local $" = ').*?(';
        qr{(@_)};
    }->(map quotemeta, split //, $seq);

    # Find all sequence matches and collect the character match offsets.
    my @match;
    $str =~ m{ $seqmatch (?{push @match, [@-]}) (*FAIL) }x;

    explainseq($str, $seq, $seqmatch, \@match) if $verbose;

    # Return the number of matches.
    scalar @match;
}

# Show the locations of the character sequence within the string.
sub explainseq ($str, $seq, $re, $matches) {

    say "sequence: '$seq'";
    say "matcher:  $re";
    say $str;

    for my $match (@$matches) {

        # Discard match offset, keeping submatches only. (See @-)
        shift @$match;

        # Prepare a string having the same length as $str.
        my $seqloc = "\N{MIDDLE DOT}" x length $str;

        # Overwrite the string at match offsets with chars from the
        # sequence.
        while (my ($idx, $offs) = each @$match) {
            substr($seqloc, $offs, 1) = substr($seq, $idx, 1);
        }
        say $seqloc;
    }
}

### Examples and tests

sub run_tests {
SKIP: {
    skip "examples" unless $examples;
    is matchseq('littleit', 'lit'), 5, 'example 1';
    is matchseq('london', 'lon'), 3, 'example 2';
}

SKIP: {
    skip "tests" unless $tests;
    is matchseq('xxaxxbxxcxx', 'abc'), 1, 'unique sequence';
    is matchseq('aaaaa', 'a'), 5, 'repetition';
    is matchseq('ihgfedcba', 'def'), 0, 'not found';
    is matchseq('a.b*c[d0e-f9g]h', '.*[0-9]'), 1, 'meta characters';
        is matchseq('aa1', '.*[0-9]'), 0, 'not matching "regex"';
        is matchseq('a.b.c', '.'), 2, 'matching literal dot'
	}

    done_testing;
    exit;
}
