#!/usr/bin/env raku
use v6;

sub formation(@source is copy, @target) {
  @source = @source.map({ $_.join('') });
  my $target = @target.join('');
  for @source.permutations -> @perm {
    return 'true' if @perm.join('') eq $target;
  }
  return 'false';
}

sub solution(@source, @target) {
  my @arr = @source.map({ '[' ~ $_.join(',') ~ ']'});
  say 'Input: @source = (' ~ @arr.join(', ') ~ ')';
  say '       @target = (' ~ @target.join(', ') ~ ')';
  say 'Output: ' ~ formation(@source, @target);
}

say "Example 1:";
solution([[2,3], [1], [4]], [1, 2, 3, 4]);

say "\nExample 2:";
solution([[1,3], [2,4]], [1, 2, 3, 4]);

say "\nExample 3:";
solution([[9,1], [5,8], [2]], [5, 8, 2, 9, 1]);

say "\nExample 4:";
solution([[1], [3]], [1, 2, 3]);

say "\nExample 5:";
solution([[7,4,6]], [7,4,6]);
