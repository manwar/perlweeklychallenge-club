#!/usr/bin/env perl6
use v6;
use NativeCall;

my %*SUB-MAIN-OPTS =
  :named-anywhere,
;

#| http://man7.org/linux/man-pages/man2/getrandom.2.html
sub MAIN (
  UInt  $bytes = 8, #= Number of random bytes (defaults to 8)
  UInt :$flags = 0,
  --> Nil
) {
  given Buf.allocate: $bytes {
    given .&getrandom: $bytes, $flags {
      when -1 {
        die sub strerror( int32 --> Str ) is native {*}(
          cglobal |( 'c', v6; 'errno'; int32 ) );
      }
      when * < $bytes { die 'got fewer bytes than requested' }
    }
    .say;
  }
}

sub getrandom ( Buf, size_t, uint32 --> ssize_t ) is native {*}
