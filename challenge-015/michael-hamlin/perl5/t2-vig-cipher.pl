#! /usr/bin/env perl

use 5.18.0;
use Vigenere;

use Getopt::Long;

my %opt;
GetOptions(\%opt,
    'key|k=s@',
    'msg|m=s',
    'help|h|?',
);
helpout() if $opt{help};

my $plaintext = $opt{msg} || 'attack at dawn';
my @keys = $opt{key} ? @{ $opt{key} } : 'lemon';

my $cipher  = vencode($plaintext, @keys);
my $decoded = vdecode($cipher, reverse @keys);

print "ciphertext: $cipher\n";
print "decoded:    $decoded\n";

sub helpout {
    print <<EOHELP;
This script demonstrates the Vigenère cipher.  Options:
  --msg|m MSG  specify the text to be encoded
  --key|k KEY  specify the text to use a key
(Default values are used for demonstration purposes.)
You may specify multiple keys (by giving multiple --key options), in 
which case multiple rounds of encoding take place.
EOHELP
    exit(0);
}
