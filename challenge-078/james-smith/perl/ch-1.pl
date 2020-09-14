#!/usr/local/bin/perl
use strict;
use warnings;

print "@{[ leader( qw(9 10 7 5 6 1) ) ]}\n"; ## Example from challenge
print "@{[ leader( qw(3 4 5)        ) ]}\n"; ## Example from challenge
print "@{[ leader( qw()             ) ]}\n"; ## Null condition to return (0) from challenge

sub leader {
  ## Most efficient way is to work backwards on this rather than forwards...
  return 0 unless @_;                   ## If nothing passed return 0 as requested.
  my @R = my $max = pop @_;             ## Last one will always be a "leader"...
  foreach ( reverse @_ ) {              ## Work forward and unshift the value if it is now a leader
    unshift @R, $max = $_ if $max < $_; ## greater than max value (and update max at the same time)
  }
  return @R;                            ## Return array of leaders...
}
