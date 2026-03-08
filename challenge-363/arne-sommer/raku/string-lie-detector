#! /usr/bin/env raku

use Lingua::NumericWordForms;

unit sub MAIN ($str where $str ~~ /<[\-—]>/,
               :a(:$all),
               :v(:$verbose) = $all);

my ($source, $desc) = $str.split(/\s*<[\-—]>\s+/);

my @sentence;

my $global-ok = True;

for $desc.words -> $word
{
  if $word eq any <vowel vowels consonant consonants>
  {
    if ! count-ok($source, @sentence.join(" "), $word)
    {
      $global-ok = False;
      @sentence  = ();
      last unless $all;
    }
    else
    {
      @sentence = ();
    }
  }
  elsif @sentence.elems == 0 && $word eq "and"
  {
    ;
  }
  else
  {
    @sentence.push: $word;
  }
}

if @sentence.elems
{
 say ": Junk '{ @sentence[] }' after last literal vowel(s)/consonant(s)" if $verbose;
 $global-ok = False;
}

say $global-ok;

sub count-ok ($source, $sentence, $type)
{
  my $number = from-numeric-word-form($sentence);

  my $count = $source.comb(
     $type ~~ /^vowels+$/
       ?? /:i <[aeiouy]>/
       !! /:i <[bcdfghjklmnpqrstvwxz]>/).elems;

  my $ok = $count == $number;

  say ": $source | $sentence = $number | $type: found $count | $ok" if $verbose;

  return $ok;
}
