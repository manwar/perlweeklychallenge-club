#! /usr/bin/env raku

unit sub MAIN (*@array where @array.elems && all(@array) ~~ /^<[0..9]>*$/, :v(:$verbose));

my @slices;

for 0 .. @array.end - 2 -> $i
{
  for $i + 2 .. @array.end -> $j
  {
    my $is-arislice = is-arislice(@array[$i..$j]);
    
    say ": \@array[$i, $j] -> @array[$i..$j] { " -> arithmetic slice" if $is-arislice }" if $verbose;
    
    @slices.push: "({ @array[$i..$j].join(",") })" if $is-arislice;
    
    last unless $is-arislice;
  }
}

say @slices ?? @slices.join(", ") !! "()";

sub is-arislice(@array)
{
  my $diff = @array[1] - @array[0];

  for 1 .. @array.end -1 -> $i
  {
    return False unless @array[$i+1] - @array[$i] == $diff;
  }

  return True;
}
