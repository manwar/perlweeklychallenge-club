#!/usr/bin/env perl
#
# ch-2.pl - Playfair Cipher
#
# 2022 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';
use Test::More;
use List::Util qw< pairmap >;

use constant {
    playfair_encrypt => +1,
    playfair_decrypt => -1,
};

is encrypt("playfair example", "hide the gold in the tree stump"),
    "bmodzbxdnabekudmuixmmouvif";

is decrypt("perl and raku", "siderwrdulfipaarkcrw"),
    "thewexeklychallengex";

done_testing;

# Encryption and decryption functions
sub encrypt { __playfair($_[0], $_[1], playfair_encrypt) }
sub decrypt { __playfair($_[0], $_[1], playfair_decrypt) }

# Main Playfair encrypt/decrypt. Supply key and plaintext, and $ed
# is one of the playfair_encrypt or playfair_decrypt constants.
# End users should not call this function directly
sub __playfair {
    my ($key, $plaintext, $ed) = @_;

    my @sq = __gen_square($key, 'j');

    my %coords; # Coordinates of each letter within @sq
    for my $x (0..4) {
        $coords{$sq[$_][$x]} = [$x, $_] for 0..4;
    }

    # Munge $plaintext into only letters, and insert x between repeated chars
    $plaintext =~ s/[^a-z]//g;
    $plaintext =~ s/^((?:..)*?)(\w)\2/$1$2x$2/g;
    $plaintext .= 'x' if length($plaintext) % 2; # Enforce even length

    return join '', pairmap {
        my ($xa, $ya) = @{$coords{$a} // $coords{i}};
        my ($xb, $yb) = @{$coords{$b} // $coords{i}};

        ($xa, $ya, $xb, $yb) = 
            $xa == $xb ? ( $xa,      ($ya+$ed)%5,$xb,      ($yb+$ed)%5)
          : $ya == $yb ? (($xa+$ed)%5,$ya,      ($xb+$ed)%5,$yb       )
                       : ( $xb,       $ya,       $xa,       $yb       );

        $sq[$ya][$xa] . $sq[$yb][$xb];
    } split //, $plaintext;
}

# Generate the 5x5 square with the keyphrase
#   $key - Keyphrase
#   $int - Interchangeable letter (usually J or Q), will be removed
sub __gen_square {
    my ($key, $int) = @_;

    my %left = map { $_ => 1 } 'a'..'z';
    delete $left{$int};
    my @rows = ([]);

    # We'll need this twice, so make it a sub
    my $push = sub {
        push @rows, [] if @{$rows[-1]} == 5;
        push @{$rows[-1]}, $_[0];
    };

    for (split //, $key) {
        next unless $left{$_};
        delete $left{$_};
        $push->($_);
    }

    $push->($_) for sort keys %left;

    @rows;
}

