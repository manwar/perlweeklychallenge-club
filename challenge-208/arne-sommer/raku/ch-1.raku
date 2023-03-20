#! /usr/bin/env raku

unit sub MAIN ($list1 = "Perl Raku Love", $list2 = "Raku Perl Hate", :v($verbose));

my @list1 = $list1.words;
my @list2 = $list2.words;

die "Repetitions in list1" if @list1.elems != @list1.unique.elems;
die "Repetitions in list2" if @list2.elems != @list2.unique.elems;

my $mis   = Inf;
my @common;

for ^@list1.elems -> $i
{
  next unless @list1[$i] eq any(@list2);
  
  for ^@list2.elems -> $j
  {
    if @list1[$i] eq @list2[$j]
    {
      my $sum = $i + $j;
      say ": Index sum of \"@list1[$i]\": $i + $j = $sum" if $verbose;

      next if $sum > $mis;

      @common = () if $sum < $mis;
      $mis    = $sum;

      @common.push: @list1[$i];

    }
  }
}

say @common.elems
 ?? "(" ~ @common.map({ "\"$_\"" }).join(", ") ~ ")" 
 !! "()";

