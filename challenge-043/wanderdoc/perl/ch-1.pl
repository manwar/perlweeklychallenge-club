#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
There are 5 rings in the Olympic Logo as shown below. They are color coded as in Blue, Black, Red, Yellow and Green. We have allocated some numbers to these rings as below: Blue: 8, Yellow: 7, Green: 5, Red: 9. The Black ring is empty currently. You are given the numbers 1, 2, 3, 4 and 6. Write a script to place these numbers in the rings so that the sum of numbers in each ring is exactly 11.
=cut


use constant { BLUE => 8, YELLOW => 7, GREEN => 5, RED => 9, SUM => 11};
use List::Util qw(reduce all);
use Algorithm::Combinatorics qw(permutations);


my %var;
my @col2search = qw(red_green green_black black black_yellow yellow_blue);
@var{@col2search} = (undef) x 5;
my @red     = (RED,                \$var{red_green});
my @green   = (GREEN,              \$var{red_green},     \$var{green_black});
my @black   = (\$var{green_black}, \$var{black},         \$var{black_yellow});
my @yellow  = (YELLOW,             \$var{black_yellow},  \$var{yellow_blue});
my @blue    = (BLUE, \$var{yellow_blue});

my @olympic = ( \@red, \@green, \@black, \@yellow, \@blue );

my @numbers = (1, 2, 3, 4, 6);


my $iter = permutations(\@numbers);

while (my $i = $iter->next())
{
     @var{@col2search} = @$i;

     next unless ( all { is_valid($_) } @olympic );
     print join(' => ', $_, $var{$_}), $/ for @col2search; 
}



sub ring_sum
{
     my @ring = @{$_[0]};

     my $sum = reduce { ('SCALAR' eq ref $a ? $$a : $a) + ('SCALAR' eq ref $b ? $$b : $b) } @ring;
     return $sum;
}


sub is_valid
{
     return SUM == ring_sum($_[0]);
}

