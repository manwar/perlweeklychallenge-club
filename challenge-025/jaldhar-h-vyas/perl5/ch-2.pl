#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;
use Getopt::Std;

sub decrypt {
    my @message = split //, $_[0];
    my $left_key = $_[1];
    my $right_key = $_[2];
    my @decrypted;

    for my $letter (@message) {
        my $i = index $left_key, $letter;
        my $ciphertext = substr $right_key, $i, 1;
        push @decrypted, $ciphertext;
        $left_key = permute_left($left_key, $letter);
        $right_key = permute_right($right_key, $ciphertext);
    }

    return join q{}, @decrypted;        
}

sub encrypt {
    my @message = split //, $_[0];
    my $left_key = $_[1];
    my $right_key = $_[2];
    my @encrypted;

    for my $letter (@message) {
        my $i = index $right_key, $letter;
        my $ciphertext = substr $left_key, $i, 1;
        push @encrypted, $ciphertext;
        $left_key = permute_left($left_key, $ciphertext);
        $right_key = permute_right($right_key, $letter);
    }

    return join q{}, @encrypted;        
}

sub permute_left {
    my @left_key = split //, $_[0];
    my $text = $_[1];

    while($left_key[0] ne $text) {
        push @left_key, shift @left_key;
    }

    splice @left_key, 1, 13, @left_key[2 .. 13, 1];

    return join q{}, @left_key;
}

sub permute_right {
    my @right_key = split //, $_[0];
    my $text = $_[1];

    while($right_key[0] ne $text) {
        push @right_key, shift @right_key;
    }
    push @right_key, shift @right_key;

    splice @right_key, 2, 12, @right_key[3 .. 13, 2];

    return join q{}, @right_key;
}

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME -d -l <Str> -r <Str> -m <Str>
  $PROGRAM_NAME -e -l <Str> -r <Str> -m <Str>

    -d          decrypt a message
    -e          encrypt a message
    -l <Str>    left key for encryption/decryption
    -e <Str>    right key for encryption/decryption
    -m <Str>    message to encrypt/decrypt
-USAGE-
    exit 0;
}

my %opts;
getopts('del:r:m:', \%opts);

my $message = $opts{m} // usage();
my $left_key = $opts{l} // usage();
my $right_key = $opts{r} // usage();

if (defined $opts{'d'}) {
    say decrypt($message, $left_key, $right_key);
} elsif (defined $opts{'e'}) {
    say encrypt($message, $left_key, $right_key);
} else {
    usage();
}
