use strict;

use warnings;

use feature qw/say/;

use Algorithm::Permute;

use List::Util qw/uniq/;



=pod

AUTHOR: Robert DiCicco

DATE: 2022-10-24

Challenge 188 Divisible Pairs ch-01.pl ( Perl )



You are given list of integers @list of size $n and divisor $k.

Write a script to find out count of pairs in the given list that satisfies the following rules.



The pair (i, j) is eligible if and only if

a) 0 <= i < j < len(list)

b) list[i] + list[j] is divisible by k

=cut



my @n = ([4, 5, 1, 6], [1, 2, 3, 4],[1, 3, 4 ,5], [5, 1, 2, 3], [7, 2, 4, 5]);

my @ks = (2,2,3,4,4);



my $cnt = 0;

my @out;



foreach my $nd (@n) {

  say "Input: \@list = \[@$nd\], \$k = $ks[$cnt]" ;

  #say "[@$nd]";

  my $p = Algorithm::Permute->new([@{$nd}], $ks[$cnt]);

  while ( my @res = $p->next) {

    my $i = $res[0];

    my $j = $res[1];

    my $k = $ks[$cnt];

    my $sz = scalar $n[$cnt];

    if ( ($i < $j) and (($i + $j) % $k == 0)  ){

      my $val ="$i$j";

      push(@out,$val);

    }

  }

  @out=sort(@out);

  @out = uniq(@out);

  print "Output: "; say scalar @out;

    @out = ();

  say " ";

  $cnt++;

}
