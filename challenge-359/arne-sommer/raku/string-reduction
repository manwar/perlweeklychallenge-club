#! /usr/bin/env raku

unit sub MAIN ($word is copy where $word ~~ /^ <[a..z A..Z]>+ $/,
               :v(:$verbose));

while $word ~~ /(.)$0/
{
  my $remove = "$0$0";
  my $new    = $word.subst($remove); ## ~~ S/$0$0//;


  say ": $word - $remove = $new" if $verbose;

  $word = $new;
}

say $word;
