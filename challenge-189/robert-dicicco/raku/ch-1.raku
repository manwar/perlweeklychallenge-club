use v6;

=begin comment

AUTHOR: Robert DiCicco

DATE: 2022-10-31

Challenge 189 Greater Character ( Raku )



You are given an array of characters (a..z) and a target character.

Write a script to find out the smallest character in the given array

lexicographically greater than the target character.



=end comment



my @arr =  (["e", "m", "u", "g"], ["d", "c", "e", "f"], ["j","a","r"], ["d", "c", "a", "f"], ["t", "g", "a", "l"]) ;

my @target = qw[b a o a v ];



sub TestValues( $a, $tv ) {

  my $x;

  print "Input: \@array = qw\(@$a\), target = $tv\n";

  my @out = ();

  loop ($x = 0; $x < @$a.elems; $x++) {

    if (@$a[$x] gt $tv)  {

      push(@out, @$a[$x]);

    }

  }

  @out.elems > 0 ?? say @out.sort[0] !! say $tv;

  say " ";

}



sub main {

  my $cnt = 0;

  for (@arr) -> $p {

    TestValues($p,@target[$cnt++]);

  }

}



main();



=begin comment

-------------------------------------------------------

SAMPLE OUTPUT

PS G:\Projects\Perl\Challenges> raku .\GreaterChar.rk

Input: @array = qw(@e m u g), target = b

e



Input: @array = qw(@d c e f), target = a

c



Input: @array = qw(@j a r), target = o

r



Input: @array = qw(@d c a f), target = a

c



Input: @array = qw(@t g a l), target = v

v



=end comment
