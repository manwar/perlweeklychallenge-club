#!/usr/bin/env raku
use v6;

=begin pod

=head1 Challenge-154 Padovan Primes

TASK #2: Padovan Prime

Write a script to compute first 10 distinct Padovan Primes.

=begin SYNOPSIS
=begin code

  ./ch-2
  # 2
  # 3
  # 5
  # 7
  # 37
  # 151
  # 3329
  # 23833
  # 13091204281
  # 3093215881333057

  ./ch-2.raku 12
  # 2
  # 3
  # 5
  # 7
  # 37
  # 151
  # 3329
  # 23833
  # 13091204281
  # 3093215881333057
  # 1363005552434666078217421284621279933627102780881053358473
  # 1558877695141608507751098941899265975115403618621811951868598809164180630185566719

=end code
=end SYNOPSIS

=begin CAVEATS

=item1  Get's big quickly
=item1  Uses Raku ``.is-prime`` approximation to determine primeness.

=end CAVEATS

=AUTHOR
Solutions by git:jaguart Jeff Armstrong.

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

