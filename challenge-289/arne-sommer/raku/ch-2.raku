#! /usr/bin/env raku

unit sub MAIN ($file = "unjumbled.txt", :v(:$verbose));

for (slurp $file).lines -> $line
{
  say $line.split(" ").map({ scramble($_) }).join(" ");
}

sub scramble ($word is copy)
{
  my @letters = $word.comb.grep({ /\w/ });

  if @letters.elems <= 3
  {
    say ": [$word] -> $word" if $verbose;
    return $word;
  }

  print ": [$word -> " if $verbose;

  my $first = @letters.shift;  
  my $last  = @letters.pop;

  my @random = @letters.pick(*);
  
  @random.unshift: $first;
  @random.push:    $last;

  print "F:$first L:$last]" if $verbose; 

  my $return;

  for $word.comb -> $letter
  {
    $letter ~~ /\w/
      ?? ( $return ~= @random.shift )
      !! ( $return ~= $letter );
   }

  say " -> $return" if $verbose;
  
  return $return;
}
