#!/usr/bin/env perl6

use Digest::SHA;

#| Validate Bitcoin address
sub MAIN (
  Str $bitcoin-addr, #= A bitcoin address
  Bool :$q = False   #= Suppress output
) {

  # First verify against regex for bitcoin addresses.
  $bitcoin-addr ~~ / ^ <?before [ 1 || 3 ]>
                       <[a..z 1..9 A..Z]-[IOl]> ** 21..31
                       <[a..z A..Z 0..9]> ** 4 $ / or die q{Doesn't match address pattern};

  # Alphabet mapping for Base 58 conversion.
  my %alpha = ((1..9, 'A'..'Z', 'a'..'z') ∖ <I O l>).keys.sort.antipairs;

  # Do base 58 conversion.
  my @addrmod = ([+] %alpha{$bitcoin-addr.comb}.reverse.map({ $_ * 58 ** $++ }))\
     .polymod(256 xx 24).reverse;

  # Double SHA256 digest the address
  my $addrsha = sha256(sha256(Blob.new: @addrmod[^21]));

  # Compare digest against the checksum.
  $addrsha.subbuf(0, 4) eqv Blob.new(@addrmod[* - 4 .. *]) or die 'Checksum does not match';

  # Valid if we got this far.
  $q or say 'Valid bitcoin address.';

  # CATCH to hide errors for quiet mode.
  CATCH {
    default {
      $q and exit 1;
      die $_;
    }
  }
}
