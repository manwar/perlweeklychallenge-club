#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;
use Data::Dumper;

sub permute_alphabets {
    my ($left, $right, $pos) = @_;
    my $newleft = substr ($left, $pos) . substr $left, 0, $pos;
    $newleft = substr ($newleft, 0, 1) . substr ($newleft, 2, 12)
               . substr ($newleft, 1, 1) . substr $newleft, 14;

    my $newright = substr ($right, $pos+1) . substr $right, 0, $pos+1;
    $newright = substr ($newright, 0, 2) . substr ($newright, 3, 11)
                . substr ($newright, 2, 1) . substr $newright, 14;
    return ($newleft, $newright);
}

sub run_tests {
    use Test::More; # Minimal tests for providing an example
    plan tests => 4;
    my $left  = 'HXUCZVAMDSLKPEFJRIGTWOBNYQ';
    my $right = 'PTLNBQDEOYSFAVZKGJRIHWXUMC';
    my $position = index $right, 'A';
    my ($newleft, $newright) = permute_alphabets $left, $right,
        $position;
    is $newleft, 'PFJRIGTWOBNYQEHXUCZVAMDSLK',
        "Left alphabet: $newleft";
    is $newright, 'VZGJRIHWXUMCPKTLNBQDEOYSFA',
        "Right alphabet: $newright";
    my $plaintext = "WELLDONEISBETTERTHANWELLSAID";
    my $ciphertext = encipher($plaintext, $left, $right);
    is $ciphertext, 'OAHQHCNYNXTSZJRRHJBYHQKSOUJY',
        "Testing enciphering: $ciphertext";
    my $deciphered = decipher($ciphertext, $left, $right);
    is $deciphered, $plaintext, "Roundtrip: $deciphered";
}

sub encipher {
    my ($plaintext, $left, $right) = @_;
    my $ciphertext = "";
    my @letters = split //, $plaintext;
    for my $let (@letters) {
        my $position = index $right, $let;
        $ciphertext .= substr $left, $position, 1;
        ($left, $right) = permute_alphabets ($left, $right,
            $position);
    }
    return $ciphertext;
}

sub decipher {
    my ($ciphertext, $left, $right) = @_;
    my $plaintext = "";
    my @letters = split //, $ciphertext;
    for my $let (@letters) {
        my $position = index $left, $let;
        $plaintext .= substr $right, $position, 1;
        ($left, $right) = permute_alphabets ($left, $right,
            $position);
    }
    return $plaintext;
}

if (@ARGV == 0) {
    run_tests;
} else {
    die "Invalid number of arguments: we need 4 arguments.\n"
        unless @ARGV == 4;
    my ($mode, $text, $left, $right) = @ARGV;
    if ($mode eq 'encipher') {
        say encipher($text, $left, $right);
    } elsif ($mode eq 'decipher') {
        say decipher($text, $left, $right);
    } else {
        die "Invalid mode: must be 'encipher' or 'decipher'.\n";
    }
}
