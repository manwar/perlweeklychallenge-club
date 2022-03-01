#!/usr/bin/env raku
use v6;

=begin pod
=begin CHALLENGE

TASK #2: Padovan Prime

Write a script to compute first 10 distinct Padovan Primes.

=end CHALLENGE
=end pod

sub MAIN ( Int $howmany = 10 ) {

  my %prime;

  my @padovan;
  while %prime.keys.elems < $howmany {
    @padovan.push( next_padovan( @padovan ) );
    my $last = @padovan[*-1];
    if $last.is-prime {
      $last.say unless %prime{$last}++;
    }
  }

}

sub next_padovan( @sofar ) returns Int {
  if ( @sofar.elems < 3 ) {
    return 1;
  }
  else {
    return @sofar[*-3] +  @sofar[*-2];
  }
}

