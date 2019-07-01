#!/usr/bin/env perl

# Write a script to implement the Vigenère cipher. The script should
# be able encode and decode. For more information see
# https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher

use strict;
use warnings;
use feature 'say';
use Getopt::Long;

my $encrypt = 0;
my $decrypt = 0;
my $text;
my $key;

# parse command line parameters
GetOptions("encrypt" => \$encrypt,
           "decrypt" => \$decrypt,
           "text=s"  => \$text,
           "key=s"   => \$key)
    or usage();

usage() unless ($encrypt ^ $decrypt);
usage() unless $key;

my $out;
for my $i (0..length($text) - 1) { # index into $text
    my $j = $i % length($key);     # index into $key
    my $c1 = ord(substr $text, $i, 1) - ord('A');
    my $c2 = ord(substr $key, $j, 1) - ord('A');
    if ($encrypt) {
        $out .= chr(($c1 + $c2) % 26 + ord('A'));
    } else {
        $out .= chr(($c1 - $c2) % 26 + ord('A'));
    }
}
say $out;

sub usage {
    die "ch-2.pl --encrypt|--decrypt --text text --key key\n"
}
