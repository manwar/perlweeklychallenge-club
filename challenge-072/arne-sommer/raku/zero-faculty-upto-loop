#! /usr/bin/env raku

subset PosInt of Int where * >= 1;

unit sub MAIN (PosInt $N, :v(:$verbose), :u(:$upto));

my $faculty = 1;

for 1 .. $N -> $value
{
  $faculty *= $value;
  
  if $upto || $value == $N
  {
    say ": $value Faculty: $faculty" if $verbose;
    $faculty ~~ /(0*)$/;
    say $0.chars;
  }
}
