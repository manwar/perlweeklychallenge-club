#!/usr/bin/perl -s

use v5.24;
use Test2::V0;
use autodie;
use List::UtilsBy qw(count_by nmax_by);
use experimental qw(signatures refaliasing);

our ($solve, $examples, $verbose);

run_tests() if $solve || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-solve] [FILE]

-examples
    run the examples from the challenge
 
-solve
    solve the task

FILE
    filename containing text to be decoded. Use '-' for STDIN

EOS


### Input and Output

say decode(\*ARGV);


### Implementation

# Taking the most frequent character at each position.

sub decode ($fh) {
    # Read matrix
    my @words;
    while (<$fh>) {
        push @words, [split /\s+/, $_];
    }

    # Transpose matrix
	my @pos = map {
        \my $p = \$_;
        [map $words[$_][$p], 0 .. $#words]
    } 0 .. $words[0]->$#*;

    # Find the frequency of characters at each position and select the
    # most frequent.
    my $decrypt;
    for my $pos (@pos) {
        my %freq = count_by {$_} @$pos;
        $decrypt .= nmax_by {$freq{$_}} keys %freq;
    }
    $decrypt;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my $data = <<'EOD';
H x l 4 !
c e - l o
z e 6 l g
H W l v R
q 9 m # o
EOD
        open my $fh, '<', \$data;
        is decode($fh), 'Hello', 'Example';
    }

    SKIP: {
        skip "solve" unless $solve;

        my $data = <<'EOD';
P + 2 l ! a t o
1 e 8 0 R $ 4 u
5 - r ] + a > /
P x w l b 3 k \
2 e 3 5 R 8 y u
< ! r ^ ( ) k 0
EOD
        open my $fh, '<', \$data;
        say decode($fh);
	}

    done_testing;
    exit;
}
