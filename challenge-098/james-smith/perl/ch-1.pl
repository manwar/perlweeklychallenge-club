#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;

my %handles;

is( readN( 'bob.txt',   4 ), 'abcd' );
is( readN( 'input.txt', 4 ), '1234' );
is( readN( 'bob.txt',   4 ), 'efgh' );
is( readN( 'input.txt', 4 ), '5678' );
is( readN( 'bob.txt',   4 ), 'ijkl' );
is( readN( 'bob.txt',   4 ), 'mnop' );
is( readN( 'input.txt', 4 ), '90'   );
is( readN( 'bob.txt',   4 ), ''     );
is( readN( 'input.txt', 4 ), ''     );
is( readN( 'bob.txt',   4 ), ''     );
is( readN( 'bob.txt',   4 ), ''     );

## Ignore this bit checking clean up works!
done_testing();
                    print "Open @{[ show_open() ]}\n";
my $t = $handles{'bob.txt'};
cleanup('fred.txt');
cleanup('bob.txt'); print "Open @{[ show_open() ]}\n";
<$t>; ## This will warn - prove that file handle has been closed
cleanup();          print "Open @{[ show_open() ]}\n";
## End of bit to ignore..

sub readN {
  my( $fn, $bytes ) = @_;

  ## Create a file handle if we don't already have one
  unless( exists $handles{$fn} ) {
    open $handles{$fn}, '<', $fn;
  }

  ## Create a buffer for the return value
  my $t = '';

  ## Use "read" to read the $bytes bytes - these are put into 2nd parameter
  ## If read returns undef it means it has reached the end of the file...
  warn "Reached end of file $fn\n" unless read ${$handles{$fn}}, $t, $bytes;

  ## Return string
  return $t;
}

sub cleanup {
  ## For neatness close all handles
  ## delete returns the value of the has deleted
  ## if filenames are passed then only those are cleaned up
  close delete $handles{$_} foreach @_ ? grep { exists $handles{$_} } @_ : keys %handles;
}

sub show_open {
  ## Return a list of open filenames
  return keys %handles;
}
