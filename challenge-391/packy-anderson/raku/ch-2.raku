#!/usr/bin/env raku
use v6;

sub arrangeBoxes(@boxes is copy) {
  @boxes = @boxes.sort({$^a[0] cmp $^b[0] || $^a[1] cmp $^b[1]});
  my @box_stack = @boxes.shift; # put the smallest box in first
  while (my $next = @boxes.shift) {
    my $box = @box_stack[*-1];
    if ($box[0] < $next[0] && $box[1] < $next[1]) {
      @box_stack.push($next);
    }
  }
  return (@box_stack.elems, @box_stack);
}

sub solution(@boxes) {
  my $boxlist = @boxes.map({ "[$_[0], $_[1]]" }).join(', ');
  say 'Input: @boxes = (' ~ $boxlist ~ ')';
  my ($output, $box_stack) = arrangeBoxes(@boxes);
  say 'Output: ' ~ $output;
  say "\n" ~ $box_stack.map({ "[$_[0], $_[1]]" }).join(', ');
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
