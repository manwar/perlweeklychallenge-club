#! /usr/bin/env perl

use 5.18.0;
use Vigenere;

use Getopt::Long;

my %opt;
GetOptions(\%opt,
    'key|k=s@',
    'msg|m=s',
);

my $plaintext = $opt{msg} || 'attack at dawn';
my @keys = $opt{key} ? @{ $opt{key} } : 'lemon';

my $cipher  = vencode($plaintext, @keys);
my $decoded = vdecode($cipher, reverse @keys);

print "ciphertext: $cipher\n";
print "decoded:    $decoded\n";

