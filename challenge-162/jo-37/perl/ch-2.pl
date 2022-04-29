#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util 'todigits';
use experimental qw(signatures postderef);

our ($tests, $examples, $decrypt);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV == 2;
usage: $0 [-examples] [-tests] [-decrypt] [KEY TEXT]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-decrypt
    decrypt given text instead of encrypting it.

KEY
    Passphrase to be used as encryption key.

TEXT
    Text to be encrypted or decrypted.

EOS


### Input and Output

say playfair($ARGV[1], gen_table($ARGV[0]), $decrypt);


### Implementation

# Build the encryption table and a reverse lookup map from the provided
# passphrase.
sub gen_table ($key) {
    # Append all letters to the passphrase as required.
    my @key = canonify($key . join '', 'a' .. 'z');
    my %backw;
    my @forw;
    # Process unseen letters until the table is filled.
    while (keys %backw < 25) {
        my $letter;
        do {
            $letter = shift @key;
        } while exists $backw{$letter};
        my ($row, $col) = todigits scalar keys %backw, 5, 2;
        $backw{$letter} = [$row, $col];
        $forw[$row][$col] = $letter;
    }
    \(@forw, %backw);
}

sub playfair ($text, $forw, $backw, $decrypt) {
    # Encryption and decryption are almost symmetric, they differ in the
    # lookup direction for same-row or same-column pairs only.
    my $shift = $decrypt ? -1 : 1;
    my @text = canonify($text);
    # Build letter pairs and apply rule 1.
    my @pairs;
    while (@text) {
        my $x = shift @text;
        push @pairs, [$x, (!@text || $x eq $text[0] ? 'x' : shift @text)];
    }
    # Encrypt or decrypt the letter pairs (x, y).  The coordinates of a
    # letter in the encryption table are stored in the reverse lookup
    # map.
    my $coded;
    for my $pair (@pairs) {
        # Unconditionally apply rule 4.
        my ($rx, $cy, $ry, $cx) = map $backw->{$pair->[$_]}->@*, 0, 1;
        # Modify the result in case of rule 2.
        ($cy, $cx) = map {($_ + $shift) % 5} $cx, $cy if $rx == $ry;
        # Modify the result in case of rule 3.
        ($rx, $ry) = map {($_ + $shift) % 5} $rx, $ry if $cx == $cy;
        # Collect the encrypted/decrypted letter pair.
        $coded .= $forw->[$rx][$cx] . $forw->[$ry][$cy];
    }
    $coded;
}

# Convert the text to lower case, transform j into i, remove all
# non-letters, squash multiple consecutive x's and split the result
# into single letters.
sub canonify ($text) {
    split //, lc($text) =~ tr/j/i/r =~ tr/a-z//cdr =~ tr/x//sr;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        my ($fw, $bw) = gen_table('playfair example');
        is playfair('hide the gold in the tree stump', $fw, $bw, 0),
            'bmodzbxdnabekudmuixmmouvif', 'example 1';

        ($fw, $bw) = gen_table('perl and raku');
        is playfair('siderwrdulfipaarkcrw', $fw, $bw, 1),
            'thewexeklychallengex', 'example 2';
    }

    SKIP: {
        skip "tests" unless $tests;

        my ($fw, $bw) = gen_table('');
        is playfair('aaa', $fw, $bw, 0), 'cvcvcv', 'repeated letter';
        is playfair('xxa', $fw, $bw, 0), 'vc', 'repeated x';

        # The behavior for an x-only text is not specified by the rules.
        # Here it is trimmed to a single x that gets a second x as its
        # pair, thus encoding a double x.  Now we have an unexpected
        # same-row-same-column situation that results in a shift in both
        # row and column and leads to an illegal encryption that cannot
        # be decrypted correctly.
        is playfair('xx', $fw, $bw, 0), 'dd', 'double x';
	}

    done_testing;
    exit;
}
