#!/usr/bin/env perl

use 5.026;
use strict;
use autodie;
use warnings;

=encoding utf8

=head1

I know that:

    32℉ =   0℃
   212℉ = 100℃

I also know the formula to convert ℉ to ℃ is linear. So:

  ℃*x + y = ℉

So, I can express the two equalities above as a system of linear equations:

    0*x + y =  32
  100*x + y = 212

I could do it by hand, but let's use some Perl L<not to say that I haven't
spoken about the
flowers|https://en.wikipedia.org/wiki/Pra_n%C3%A3o_dizer_que_n%C3%A3o_falei_das_flores>.

Searching CPAN I found a bunch of Math modules that could help me solve the
linear system above for x and y. I use the L<Math::MatrixReal> module below to
solve a system in vector form:

  Matrix * vector = solution

=cut

use Math::MatrixReal;

my $Matrix = Math::MatrixReal->new_from_cols([[0, 100], [1, 1]]);

my $vector = Math::MatrixReal->new_from_cols([[32, 212]]);

my $LR = $Matrix->decompose_LR();

my ($dimension, $solution, $base_matrix) = $LR->solve_LR($vector);

my ($x, $y) = $solution->as_list();

=pod

Now that we have found x and y we can make ℉ = ℃ = T to find the equal numeric
temperature:

  ℃*x + y = ℉
   T*x + y = T
   y = T*(1 - x)
   T = y / (1 - x)

=cut

my $T = $y / (1 - $x);

print "$T℃  = $T℉\n";
