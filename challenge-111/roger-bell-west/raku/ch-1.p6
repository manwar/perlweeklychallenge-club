#! /usr/bin/perl6

use Test;
plan 2;

is(sm(([  1,  2,  3,  5,  7 ],
       [  9, 11, 15, 19, 20 ],
       [ 23, 24, 25, 29, 31 ],
       [ 32, 33, 39, 40, 42 ],
       [ 45, 47, 48, 49, 50 ]),35),0,'example 1');

is(sm(([  1,  2,  3,  5,  7 ],
       [  9, 11, 15, 19, 20 ],
       [ 23, 24, 25, 29, 31 ],
       [ 32, 33, 39, 40, 42 ],
       [ 45, 47, 48, 49, 50 ]),39),1,'example 2');

sub sm(@matrix,$search) {
  my $f=0;
  for (@matrix) -> @row {
    if (@row[0] <= $search) {
      if (@row[*-1] >= $search) {
        if ($search ∈ @row) {
          $f=1;
        }
        last;
      }
    } else {
      last;
    }
  }
  return $f;
}

