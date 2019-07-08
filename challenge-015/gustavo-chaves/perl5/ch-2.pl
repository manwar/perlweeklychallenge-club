#!/usr/bin/env perl

# Write a script to implement Vigenère cipher. The script should be able encode
# and decode. Checkout wiki (https://en.wikipedia.org/wiki/Vigen%C3%A8re_cipher)
# page for more information.

use 5.026;
use strict;
use autodie;
use warnings;

my $usage = "Usage: $0 [decrypt|encrypt] KEY\n";

my $command = shift or die $usage;

my $key = shift or die $usage;

my %op = (
    decrypt => sub { return $_[0] - $_[1] },
    encrypt => sub { return $_[0] + $_[1] },
);

exists $op{$command} or die "Invalid COMMAND: '$command'\n";

$key =~ /^[A-Z]+$/ or die "The KEY must consist of uppercase letters only.\n";

my $index = 0;

while (my $char = getc()) {
    if ($char =~ /^[A-Z]$/) {
        $char = chr($op{$command}->(ord($char) - ord('A'), ord(substr($key, $index, 1)) - ord('A')) % 26 + ord('A'));
        $index += 1;
        $index %= length $key;
    }
    print $char;
}
