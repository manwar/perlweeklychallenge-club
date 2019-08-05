#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-015/
# Challenge #2
# Write a script to implement Vigenère cipher.
# The script should be able encode and decode.
# Checkout wiki page for more information.
# https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher

use strict;
use warnings;

die "Usage: $0 <-e plaintext|-d ciphertext> <key>" unless (@ARGV == 3);

my $action = $ARGV[0];
if ($action eq '-e') {
    print encode($ARGV[1],$ARGV[2]);
}
elsif ($action eq '-d') {
    print decode($ARGV[1],$ARGV[2]);
}
else {
    print "Valid actions are: -e (encode) or -d (decode)\n";
}

sub encode { vigenere(@_, 1)  }
sub decode { vigenere(@_,-1) }

sub vigenere {
    my $text = clean(shift);
    my $key  = clean(shift);
    my $sign = shift;

    my $repeat = int(length($text)/length($key))+1;
    my $keyext = $key x $repeat; # repeat key string up to text length

    my @letters = 'A' .. 'Z';
    my %charcode = map { $letters[$_] => $_ } 0 .. 25;

    my $plain = '';
    foreach my $i (0 .. length($text)-1) {
        # the magic begins: Vigenère algebraically applied
        $plain .= $letters[
                    ( $charcode{substr($text,$i,1)}
                      + $sign * $charcode{substr($keyext,$i,1)}
                    ) % 26
                  ];
    }
    return $plain;
}

sub clean {
    my $text = shift;
    $text =~ s/[^a-z]//gi;  # remove non-alphabetic characters
    return (uc $text);      # uppercase characters
}
