#!/usr/bin/env raku
use v6;

sub divmod($x, $y) { ($x div $y, $x % $y) }

sub list_div(@list, $n) {
  return -1 if @list.elems < $n;
  my ($c, $r) = divmod(@list.elems, $n);
  my @result;
  while @list {
    my @a;
    @a.push(@list.shift) for 1..$c;
    @a.push(@list.shift) if --$r >= 0;
    @result.push(@a);
  }
  @result;
}

sub int_join(@list) {
  "(" ~ @list.join(",") ~ ")"
}
sub solution(@list, $n) {
  say 'Input: @list = (' ~ @list.join(', ') ~ '), $n = ' ~ $n;
  my @result = list_div(@list, $n);
  my $joined = @result.elems == 1 && @result[0] == -1
            ?? "-1"
            !! "(" ~ @result.map({ int_join($_) }).join(", ") ~ ")";
  say 'Output: ' ~ $joined;
}

say "Example 1:";
solution([1,2,3,4,5], 2);

say "\nExample 2:";
solution([1,2,3,4,5,6], 3);

say "\nExample 3:";
solution([1,2,3], 2);

say "\nExample 4:";
solution([1,2,3,4,5,6,7,8,9,10], 5);

say "\nExample 5:";
solution([1,2,3], 4);

say "\nExample 6:";
solution([72,57,89,55,36,84,10,95,99,35], 7);
