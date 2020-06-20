#! /usr/bin/env raku

unit sub MAIN (Str $S = 'aabaab', :$verbose);

my @result;
my %match-with-remainder;
my $matches = 0;

for 0 .. $S.chars -2 -> $start
{
  say ":: Start at pos $start (string: '{ $S.substr($start) }')" if $verbose;

  check($S.substr($start, 2), $S.substr($start + 2));
}

sub check($string, $remainder)
{
  say ":: Check '$string' (Remainder: '$remainder')" if $verbose;

  check($string ~ $remainder.substr(0,1), $remainder.substr(1)) if $remainder.chars >= 1;

  if $string eq $string.flip
  {
    next if %match-with-remainder{$remainder.chars};
    %match-with-remainder{$remainder.chars} = True;
    @result.push: $string;
    $matches++;
    
    say ":: Match: '$string'" if $verbose;
    
    check($remainder.substr(0,2), $remainder.substr(2)) if $remainder.chars >= 2;

    if @result
    {
      say @result.map({ "'{ $_ }'" }).join(", ");
      @result = ();
    }
  }
}

say "-1" unless $matches;