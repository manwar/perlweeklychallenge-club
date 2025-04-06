#! /usr/bin/env raku

subset WORD where /^<[a..z A..Z]>+$/;
subset WORDS where /^<[a..z A..Z \s \. \, \- \! \;]>+$/;

unit sub MAIN (WORDS $sentence;
               WORD :f(:$first),
               WORD :s(:$second));

my @sentence   = $sentence.words>>.&de-punctuate;
my $first-word = @sentence.shift;
my @result;

while @sentence.elems
{
  if $first-word ne $first
  {
    $first-word = @sentence.shift || last;
  }
  else
  {
    my $second-word = @sentence.shift || last;

    @result.push: @sentence[0] if $second-word eq $second && @sentence.elems;

    $first-word = $second-word;
  }
}

say "({ @result.join(", ") })";

sub de-punctuate ($word is copy)
{
  $word = $word.substr(0, $word.chars -2) while $word.substr($word.chars -1) eq any(',', '.', '-');
  return $word;
}