#! /usr/bin/env perl6

unit sub MAIN (Str :$dictionary where $dictionary.IO.r = "dict-UK.txt");

my $dict = get-dictionary($dictionary);

my %count;

%count{ .comb.sort.join }++ for $dict.keys;

my $max = 0;

for %count.keys.sort( { %count{$^b} <=> %count{$^a} } )
{
  $max = %count{$_} if %count{$_} > $max;

  last if  %count{$_} < $max;
  
  say "$_: ", %count{$_};
}

sub get-dictionary ($file where $file.IO.r)
{
  return $file.IO.lines.grep(* !~~ /\W/)>>.lc.Set;
}
