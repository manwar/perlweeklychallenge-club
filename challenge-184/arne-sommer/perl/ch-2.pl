#! /usr/bin/env perl

use strict;
use warnings;
use feature 'say';
use feature 'signatures';

no warnings 'experimental::signatures';

use Perl6::Junction 'any';

my @list1 = ('a 1 2 b 0', '3 c 4 d');
my @list2 = ('1 2', 'p q r', 's 3', '4 5 t');

say split_array(@list1);
say split_array(@list2);

sub split_array (@list)
{
  my @digits;
  my @letters;

  for my $string (@list)
  {
    my @d_curr;
    my @l_curr;

    for my $char (split(" ", $string))
    {
      $char eq any(0..9) ? push(@d_curr, $char) : push(@l_curr, $char);
    }

    push(@digits,  "[" . join(",", @d_curr) . "]") if @d_curr;
    push(@letters, "[" . join(",", map { "'" . $_ . "'" } @l_curr) . "]") if @l_curr;
  }

  my @return;

  push(@return, "[" . join (", ", @digits)  . "]") if @digits;
  push(@return, "[" . join (", ", @letters) . "]") if @letters;

  return join(" and ", @return);
}
