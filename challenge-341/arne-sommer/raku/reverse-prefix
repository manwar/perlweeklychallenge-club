#! /usr/bin/env raku

unit sub MAIN (:s($str)  where $str.chars > 0,
               :c($char) where $char.chars == 1,
               :v(:$verbose));

my $index = $str.index($char);

if $index
{
  my $pre     = $str.substr(0, $index +1);
  my $flipped = $pre.flip;
  my $post    = $str.substr($index +1);

  if $verbose
  {
    say ": Index: $index";
    say ": Pre: '$pre'";
    say ": Flipped: '$flipped'";
    say ": Post: '$post'"; 
  }

  say $flipped ~ $post; 
}
else
{
  say $str;
}

