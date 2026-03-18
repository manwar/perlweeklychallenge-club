#! /usr/bin/env raku

unit sub MAIN ($str, :v(:$verbose));

my $valid = 0;

for $str.words -> $word
{
  given $word
  {
    when /\d/
    {
      say ": $word -> invalid (digit)" if $verbose;
    }
    when /<[.,!]>./
    {
      say ": $word -> invalid (punctuation not at end)" if $verbose;
    }
    when /"-" .* "-"/
    {
      say ": $word -> invalid (more than one hyphen)" if $verbose;
    }
    when /<[a..z]> "-" <[a..z]>/
    {
      say ": $word -> valid (one hyphen between letters)" if $verbose;
      $valid++;
    }
    when / "-" /
    {
      say ": $word -> invalid (hyphen not between letters)" if $verbose;
    }
    default
    {
      say ": $word -> valid" if $verbose;
      $valid++;
    }
  }
}

say $valid;
