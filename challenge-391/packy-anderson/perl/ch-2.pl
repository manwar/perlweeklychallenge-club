#!/usr/bin/env perl
use v5.44;

sub arrangeBoxes(@boxes) {
  @boxes = sort { $a->[0] <=> $b->[0] ||
                  $a->[1] <=> $b->[1] } @boxes;
  my @box_stack = shift @boxes; # put the smallest box in first
  while (my $next = shift @boxes) {
    my $box = $box_stack[-1];
    if ($box->[0] < $next->[0] && $box->[1] < $next->[1]) {
      push @box_stack, $next;
    }
  }
  return (scalar(@box_stack), @box_stack);
}

sub boxSize($box) {
  sprintf '[%d, %d]', $box->[0], $box->[1];
}

sub solution($boxes) {
  my $boxlist = join ', ', map { boxSize($_) } @$boxes;
  say 'Input: @boxes = (' . $boxlist . ')';
  my ($output, @box_stack) = arrangeBoxes(@$boxes);
  say 'Output: ' . $output;
  say "\n" . join(', ', map { boxSize($_) } @box_stack);
}

say "Example 1:";
solution([[1, 3], [3, 5], [6, 8], [2, 4]]);

say "\nExample 2:";
solution([[4, 5], [4, 6], [6, 7], [2, 3], [4, 3]]);

say "\nExample 3:";
solution([[5, 5], [5, 5], [5, 5]]);

say "\nExample 4:";
solution([[2, 100], [3, 200], [4, 300], [5, 50], [5, 400]]);

say "\nExample 5:";
solution([[10, 20], [15, 10], [20, 30], [12, 18], [16, 25]]);

