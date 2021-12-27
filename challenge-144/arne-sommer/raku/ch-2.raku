#! /usr/bin/env raku

subset PosInt of Int where * > 0;

unit sub MAIN (PosInt $u, PosInt $v where $v > $u, :l(:$limit) = 10, :v(:$verbose));

my $size = $limit.chars;

my $ulam := gather
{
  my @ulam  = ($u.Int, $v.Int);
  my $index = 1;
  
  say ": { indent(1, $size) }: @ulam[0]" if $verbose;
  take @ulam[0];
  
  say ": { indent(2, $size) }: @ulam[1]" if $verbose;
  take @ulam[1];

  loop
  {
    my @sum = @ulam.combinations(2)>>.sum.grep( * > @ulam[$index] );
    say ": { indent($index + 2, $size) }: { @sum.sort.join(", ") } (with duplicates)" if $verbose;
    
    my @bag = @sum.Bag.grep( *.value == 1 ).map( *.key ).sort;
    say ": { ' ' x $size }  { @bag.join(", ") } (no duplicates)" if $verbose;

    my $min = @bag.min;
    @ulam[++$index] = $min;

    take $min;
  }
}

say $ulam[^$limit].join(", ");

sub indent ($number, $size)
{
  return $number.fmt('%' ~ $size ~ 'd');
}
