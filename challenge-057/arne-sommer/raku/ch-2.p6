#! /usr/bin/env raku

unit sub MAIN (Str $words = "alphabet book carpet cadmium cadeau alpine", :$verbose);

my @words = $words.words;

class Letter
{
  has $.letter;
  has $.count  is rw;
  has %.next   is rw;
}

my %top;

for @words.unique -> $word
{
  my @letters = $word.comb;

  my $current = @letters.shift;
  my $pointer;
  
  if ! %top{$current}.defined
  {
    %top{$current} = Letter.new(letter => $current);
  }
  
  $pointer = %top{$current};

  $pointer.count++;
 
  for @letters -> $next
  {
    if ! $pointer.next{$next}.defined
    {
      $pointer.next{$next} = Letter.new(letter => $next);
    }
    $pointer = $pointer.next{$next};
    $pointer.count++;
  }
}

if $verbose
{
  for %top.keys -> $key
  {
    say ":: Top $key -> " ~ %top{$key}.count;
  }
}

say "::" ~  %top.raku if $verbose;

print "[ ";
print '"' ~ look-up($_) ~ '" ' for @words;
say "]";

sub look-up($word)
{
  my @letters  = $word.comb;
  my $letter   = @letters.shift;
  my $shortest = $letter;
  my $pointer  = %top{$letter};

  for @letters -> $letter
  {
    last if $pointer.count == 1;
    $pointer = $pointer.next{$letter};
    $shortest ~= $letter;
  }

  return $shortest;
}

