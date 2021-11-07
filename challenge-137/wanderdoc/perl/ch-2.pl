#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a number, 10 <= $n <= 1000. Write a script to find out if the given number is Lychrel number. To keep the task simple, we impose the following rules:
a. Stop if the number of iterations reached 500.
b. Stop if you end up with number >= 10_000_000.
According to wikipedia:
    A Lychrel number is a natural number that cannot form a palindrome through the iterative process of repeatedly reversing its digits and adding the resulting numbers.
=cut






use bigint accuracy => 50;
sub lychrel
{
     my $num = $_[0]; 
     $num += 0;
     my $palindrome = scalar reverse $num;
     return $num + $palindrome;
}


sub is_palindrome
{
     return ($_[0] eq scalar reverse $_[0]) ? 1 : 0;
}

my @candidates;

for my $i ( 10 .. 1_000 )
{
     print "$i "; # , $/;
     print "is palindrome itself.$/" and next if (is_palindrome($i));


     my $counter;
     my $break_flag = 0;
     my $num = $i;

     while ( not is_palindrome($num) )
     {
          $num = lychrel($num);
          $counter++;

          if (500 == $counter)  { $break_flag = 1; last; };
          if (1e50 <= $num) { $break_flag = 2; last; };
     }

     my $statement = $break_flag > 0 ? ": stopped after " : ": palindrome $num after ";
     $statement .= $break_flag == 1 ? "the number reached  $num." : 
               "$counter iterations.";
     print $statement, $/;

     if ( not is_palindrome($num) ) { push @candidates, [$i, $counter, $num]; }
}

for my $cand ( @candidates )
{
     print join(' ', $cand->[0], 'is Lychrel-candidate after', $cand->[1], 'iterations:', $cand->[2]), $/;
}