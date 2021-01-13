#! /usr/bin/env raku

unit sub MAIN (Str $A where $A.chars > 0, Str $B where $B.chars > 0, :v(:$verbose));

die "Different characters in A and B"
  unless $A.comb.unique.sort.join eq $B.comb.unique.sort.join;

my $a = $A.chars;
my $b = $B.chars;

my $unique = $A.comb.unique.elems;

my @cbs;

for $unique .. min($a, $b) -> $length
{
  my $c = $A.substr(0, $length);
  say ": Length: $length -> $c" if $verbose;

  @cbs.push: $c if $c x ($a / $length) eq $A && $c x ($b / $length) eq $B;
}

say '(' ~ @cbs.map({ '"' ~ $_ ~ '"' }).join(", ") ~ ')' if @cbs;
