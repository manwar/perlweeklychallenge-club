use v5.10; use strict; use warnings;

sub build_array { map $_[$_], @_ }

for my $test (
  { input  => [0, 2, 1, 5, 3, 4],  output => [0, 1, 2, 4, 5, 3] },
  { input  => [5, 0, 1, 2, 3, 4],  output => [4, 5, 0, 1, 2, 3] }
)
{
  say "@{[ build_array(@{ $$test{input} }) ]}"
   eq "@{                 $$test{output}    }"
    ? '✓' : '☠'
}
