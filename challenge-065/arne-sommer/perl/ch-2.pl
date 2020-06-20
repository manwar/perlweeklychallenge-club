#! /usr/bin/env perl

use feature 'say';
use feature 'signatures';
no warnings qw(experimental::signatures);

my $verbose = 0;

if ($ARGV[0] eq "--verbose")
{
  $verbose++;
  shift @ARGV;
}

my $S = shift @ARGV || 'aabaab';

my @result;
my %match_with_remainder;
my $matches = 0;

for my $start (0 .. length($S) -2)
{
  say ":: Start at pos $start (string: '" . substr($S, $start) . "')" if $verbose;

  check(substr($S, $start, 2), substr($S, $start + 2));
}

sub check($string, $remainder)
{
  say ":: Check '$string' (Remainder: '$remainder')" if $verbose;

  check($string . substr($remainder, 0,1), substr($remainder, 1)) if length $remainder >= 1;

  if ($string eq reverse $string)
  {
    next if $match_with_remainder{length $remainder};
    $match_with_remainder{length $remainder} = 1;
    push(@result, $string);
    $matches++;
    
    say ":: Match: '$string'" if $verbose;
    
    check(substr($remainder,0,2), substr($remainder,2)) if length $remainder >= 2;

    if (@result)
    {
      say join(", ", map { "'$_'" } @result);
      @result = ();
    }
  }
}

say "-1" unless $matches;
