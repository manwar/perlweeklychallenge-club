#! /usr/bin/perl

use strict;
use warnings;

use Encode::Base58::GMP;
use Math::GMPz qw(:mpz);
use Digest::SHA qw(sha256 sha256_hex);

foreach my $address (@ARGV) {
  unless ($address =~ /^[1-9A-HJ-NP-Za-km-z]*$/) {
    warn "$address\ninvalid characters\n";
    next;
  }
  my $a=decode_base58($address,'bitcoin');
  my $ah=Rmpz_get_str($a,16);
  if (length($ah)%2==1) {
    $ah='0'.$ah;
  }
  my @e=($ah =~ /(..)/g);
  while (scalar @e < 25) {
    unshift @e,'00';
  }
  my $cksum=join('',splice(@e,-4));
  my $raw=pack('C*',map {hex($_)} @e);
  my $digest=substr(sha256_hex(sha256($raw)),0,8);
  if ($digest eq $cksum) {
    print join('',@e),"\n";
  } else {
    warn "$address\nCalculated $digest does not match stored $cksum\n";
  }
}
