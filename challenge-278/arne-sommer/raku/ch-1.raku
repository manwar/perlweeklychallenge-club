#! /usr/bin/env raku

unit sub MAIN ($str, :v(:$verbose));

my @new;

for $str.words -> $shuffle
{
  $shuffle ~~ /(.*?)(\d+)$/;
  my $word  = $0;
  my $index = $1;

  say ":Word '$word' at index $index { @new[$index].defined ?? 'REDEFINED' !! ''}" if $verbose;

  @new[$index] = $word;
}

say @new[1 .. *].join(" ");
# say @new.grep( *.defined ).join(" ");
