#! /usr/bin/env perl6

unit sub MAIN (Int $limit where 2 <= $limit <= 100000 = 10, :$verbose = False, :$test = False);

my @van-eck = (0);

my %seen;

for ^($limit -1) -> $pos
{
  %seen{@van-eck[*-1]}.defined
   ?? @van-eck.push: $pos - %seen{@van-eck[*-1]}
   !! @van-eck.push: 0;

  %seen{@van-eck[*-2]} = $pos;
}

if $test
{
  use LWP::Simple;
 
  my $ok    = 0;
  my $error = 0;
  my $index = 1;

  for LWP::Simple.get('https://oeis.org/A181391/b181391.txt').lines -> $line
  {
    last if $index > $limit;
    
    my $my  = @van-eck[$index -1];
    my $def = $line.words[1];

    if $my == $def
    {
      say "$index: $my == $def (OK)";
      $ok++;
    }
    else
    {
      say "$index: $my != $def (Error)";
      $error++;
    }
    
    $index++;
  }

  say "\nOK: $ok";
  say "Error: $error";
}

elsif $verbose
{
  my $count = 1;
  say "{ $count++ }: $_" for @van-eck;
}

else
{
  say @van-eck.join(", ");
}
