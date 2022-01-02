#! /usr/bin/env raku

unit sub MAIN ($s is copy = 'redivider', :v(:$verbose));

my @result;
my $length = $s.chars;

for 0 .. $length -> $start
{
  @result.push: $s.substr($start,1);
  
  next if $start > $length -2;
  
  for $start +1 .. $length -1 -> $stop
  {
    my $candidate = $s.substr($start, $stop - $start +1);
    say ": [$start,$stop] $candidate" if $verbose;
    @result.push: $candidate if $candidate.flip eq $candidate;
  }
}

say @result.unique.join(" ");
