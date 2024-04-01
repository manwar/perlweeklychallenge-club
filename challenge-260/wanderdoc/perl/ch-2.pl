#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given a word, $word. Write a script to compute the dictionary rank of the given word.

Example 1 Input: $word = 'CAT' Output: 3
All possible combinations of the letters: CAT, CTA, ATC, TCA, ACT, TAC
Arrange them in alphabetical order: ACT, ATC, CAT, CTA, TAC, TCA
CAT is the 3rd in the list. Therefore the dictionary rank of CAT is 3.


Example 2 Input: $word = 'GOOGLE' Output: 88
Example 3 Input: $word = 'SECRET' Output: 255
=cut


use Algorithm::Combinatorics qw(permutations);
# Tuples are generated in lexicographic order, except in subsets().
use Test2::V0;

is(dictionary_rank('CAT'), 3, 'Example 1');
is(dictionary_rank('GOOGLE'), 88, 'Example 2');
is(dictionary_rank('SECRET'), 255, 'Example 3');
done_testing();

sub dictionary_rank
{
     my $word = $_[0];
     my @data = sort { $a cmp $b } split(//, $word);
     my $counter = 0;
     my %seen;
     my $iter = permutations(\@data);
     while (my $c = $iter->next) 
     {
          my $tuple = join('', @$c);
          next if (exists $seen{$tuple});
          $seen{$tuple} = undef;
          $counter++;
          if ( $tuple eq $word )
          {
               return $counter;
          }
     }
}
