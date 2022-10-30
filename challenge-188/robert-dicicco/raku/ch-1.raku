use v6;



=begin comment

AUTHOR: Robert DiCicco

DATE: 2022-10-24

Challenge 188 Divisible Pairs  ( Raku )



You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the following rules.



The pair (i, j) is eligible if and only if

a) 0 <= i < j < len(list)

b) list[i] + list[j] is divisible by k

=end comment



my @arr = ((4, 5, 1, 6), (1, 2, 3, 4),(1, 3, 4 ,5), (5, 1, 2, 3), (7, 2, 4, 5));

my $ks  =  (2,2,3,4,4) ;

my $cnt = 0;



my @out = ();



for (@arr) -> $ref {

  print "Input: \@list = \($ref\), k = $ks[$cnt]\n" ;

  for ($ref.permutations) -> $pr {

      my $i = $pr[0];

      my $j = $pr[1];

      my $k = $ks[$cnt];

      my $sz = $ref.elems;

      if ( ($i < $j) && (($i + $j) % $k == 0)  )  {

        @out.push: "$i$j$k$sz";

      }

  }

  print "Output: ";

  say @out.unique.elems;

  say " ";

  @out = ();

  $cnt++;

}
