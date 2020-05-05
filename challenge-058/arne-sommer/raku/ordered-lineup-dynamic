#! /usr/bin/env raku

unit sub MAIN (:$H, :$T, :$A = "", :$verbose, :$verbose2);

my @H = $H.words>>.Int;
my @T = $T.words>>.Int;
my @A = $A.words>>.Int;

# die "Repeated heights" if @H.repeated;
die "H and T have different sizes" if @H.elems != @T.elems;
die "A have different size than H and T" if @A && @A.elems != @H.elems;

class Lineup
{
  has Int $.height;
  has Int $.taller;
}

my @list;

for ^@H -> $index
{
  @list.push: Lineup.new(height => @H[$index], taller => @T[$index]);
}

my @result;

for @list.sort({ $^b.height <=> $^a.height }) -> $elem
{
  my $taller = $elem.taller;

  say ": H:{ $elem.height } -> T:{ $elem.taller }" if $verbose;

  if (@result[$taller].defined)
  {
    @result.splice($taller, 1, $elem, @result[$taller]);
  }
  else
  {
    die "Not enough taller persons in front of { $elem.height }: { @result.elems } (should have been $taller)"
      if  @result.elems != $taller;
      
    @result.push: $elem;
  }
}

say ": " ~ @result.raku if $verbose;

say @result>>.height.join(", ");

say @result.map({ ": " ~ ++$ ~ ": " ~ $_.height ~ "[<" ~ $_.taller ~ "]"}).join("\n") if $verbose2;

say @result>>.height eqv @A if @A;
