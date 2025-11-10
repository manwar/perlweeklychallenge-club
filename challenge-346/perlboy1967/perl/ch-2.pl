#!/bin/perl

=pod

L<https://theweeklychallenge.org/blog/perl-weekly-challenge-346#TASK2>

Author: Niels 'PerlBoy' van Dijke

Task 2: Magic Expression
Submitted by: Mohammad Sajid Anwar

You are given a string containing only digits and a target integer.

Write a script to insert binary operators +, - and * between the digits
in the given string that evaluates to target integer.

=cut

use Test2::V0 qw(-no_srand);
use exact 'v5.32', -signatures;

use Algorithm::Combinatorics qw(variations_with_repetition);

sub magicExpression ($str,$target) {
  my @d = split//,$str;
  my (@res,$eval);
  my @op = ('*','+','-','');
  my $sprintfFmt = join('%s',@d);
  for my $op (variations_with_repetition(\@op,$#d)) {
    my $s = sprintf($sprintfFmt,@$op);
    next if $s =~ m#\D[0]+\d#;
    $eval .= sprintf(qq{push(\@res,'%s') if %s == %d;\n}, $s, $s, $target);
  }
  eval $eval;
  @res;
}

is([magicExpression('123',6)],['1*2*3','1+2+3'],'Example 1');
is([magicExpression('105',5)],['1*0+5','10-5'],'Example 2');
is([magicExpression('232',8)],['2*3+2','2+3*2'],'Example 3');
is([magicExpression('1234',10)],['1*2*3+4','1+2+3+4'],'Example 4');
is([magicExpression('1001',2)],['1+0*0+1','1+0+0+1','1+0-0+1',
                                '1-0*0+1','1-0+0+1','1-0-0+1'],'Example 5');

done_testing;
