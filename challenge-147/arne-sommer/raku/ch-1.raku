#! /usr/bin/env raku

unit sub MAIN ($limit = 20, :v(:$verbose));

my $seq = (2 .. Inf).grep(*.&is-left-trunc);

say $seq[^$limit].join(", ");

sub is-left-trunc ($prime)
{
  return False if $prime.contains: '0';

  for ^$prime.chars -> $start
  {
    say ": Checking $prime -> { $prime.substr($start) } - { $prime.substr($start).is-prime ?? "prime" !! "not prime" }" if $verbose;
    return False unless $prime.substr($start).is-prime;
  }

  return True;
}
