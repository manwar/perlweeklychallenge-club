#!/usr/bin/perl
use warnings;
use strict;
use 5.010;
use English qw/ -no_match_vars /;
use Getopt::Std;

sub decrypt {
    my ($key, $keylength, $tabulaRecta, $c) = @_;
    state $i = 0;

    return
      chr(ord('A') + index($tabulaRecta->{$key->[$i++ % $keylength]}, $c));
}

sub encrypt {
    my ($key, $keylength, $tabulaRecta, $c) = @_;
    state $i = 0;

    return
      substr($tabulaRecta->{$key->[$i++ % $keylength]}, ord($c) - ord('A'), 1);
}


sub makeSquare {
    my @shifted = ('Z', 'A' .. 'Y');

    return map {
        push @shifted, shift @shifted;
        $_ => join q{}, @shifted;
    } 'A' .. 'Z';
}

sub prep {
    my ($string) = @_;

    $string = uc $string;
    $string =~ s/[^A-Z]//g;

    return $string;
}

sub usage {
    print<<"-USAGE-";
  $PROGRAM_NAME -d -k <Str> -m <Str>
  $PROGRAM_NAME -e -k <Str> -m <Str>

    -d          decrypt a message
    -e          encrypt a message
    -k <Str>    key for encryption/decryption
    -m <Str>    message to encrypt/decrypt
-USAGE-
    exit 0;
}

sub vigenere {
    my @message = split //, $_[0];
    my @key = split //, $_[1];
    my $op = $_[2];

    my %tabulaRecta = makeSquare();
    my $keylength = scalar @key;
    my $i = 0;

    return
        join q{}, map { $op->(\@key, $keylength, \%tabulaRecta, $_); } @message;
}

my %opts;
getopts('dek:m:', \%opts);

my $message = prep($opts{m} // usage());
my $key = prep($opts{k} // usage());

if (defined $opts{'d'}) {
    say vigenere($message, $key, \&decrypt);
} elsif (defined $opts{'e'}) {
    say vigenere($message, $key, \&encrypt);
} else {
    usage();
}
