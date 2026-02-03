#! /usr/bin/env raku

unit sub MAIN (*@strings where @strings.elems > 0, :v(:$verbose));

my $max = -Inf;

for @strings -> $string
{
  my $value = $string ~~ /^ <[0..9]>+ $/
    ?? $string.Int
    !! $string.chars;

  my $is-max = $value > $max;

  $max = $value if $is-max;

  say ": String:'$string' Val:$value { $is-max ?? "new max" !! "" }" if $verbose;
}

say $max;
