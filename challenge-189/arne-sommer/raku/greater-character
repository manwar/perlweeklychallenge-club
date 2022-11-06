#! /usr/bin/env raku

unit sub MAIN (:v(:$verbose));

say greater_character( qw/e m u g/, 'b');
say greater_character( qw/d c e f/, 'a');
say greater_character( qw/j a r/,   'o');
say greater_character( qw/d c a f/, 'a');
say greater_character( qw/t g a l/, 'v');

sub greater_character (@array, $target)
{
  my @greater = @array.grep( * gt $target );

  say ":A:[{ @array.join(",") }] T:$target F:[{ @greater.join(", ") }] S:[{ @greater.sort.join(", ") }]" if $verbose;

  return @greater.sort.first // $target
}
