#! /usr/bin/env raku

unit sub MAIN ($str where $str.chars > 0,
	       :v(:$verbose));

my @matches;

for 0 .. $str.chars -2 -> $start
{
  for $start +1 .. $str.chars -1 -> $stop
  {
    my $candidate = $str.substr($start, $stop - $start +1);
    my %letters   = $candidate.comb.map({ $_ => 1 });
    my $match     = %letters.keys.sort.join eq "aeiou";
    say ":[$start - $stop]: $candidate { $match ?? " is a match" !! "" }" if $verbose;
    @matches.push: $candidate if $match;
  }
}

say "(" ~ @matches.map({'"' ~ $_ ~ '"' }).join(" ,") ~ ")";