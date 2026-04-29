#!/usr/bin/env raku
use v6;

sub missing(@seq) {
  my @diff;
  # determine the differences we know
  for 0..3 -> $i {
    next if @seq[$i] eq '?' || @seq[$i+1] eq '?';
    @diff[$i] = @seq[$i+1].ord - @seq[$i].ord;
  }
  # fill in the missing differences
  for 0..3 -> $i {
    @diff[$i] = @diff[($i +2) mod 4] unless @diff[$i].defined;
  }
  # special case: the first letter is missing
  if (@seq[0] eq '?') {
    return (@seq[1].ord - @diff[0]).chr;
  }
  # calculate the missing letter
  for 1..4 -> $i {
    next unless @seq[$i] eq '?';
    return (@seq[$i-1].ord + @diff[$i-1]).chr;
  }
}

sub solution(@seq) {
  say 'Input: @arr = qw(' ~ @seq.join(' ') ~ ')';
  say 'Output: ' ~ missing(@seq);
}

say "Example 1:";
solution(["a", "c", "?", "g", "i"]);

say "\nExample 2:";
solution(["a", "d", "?", "j" ,"m"]);

say "\nExample 3:";
solution(["a", "e", "?", "m", "q"]);

say "\nExample 4:";
solution(["a", "c", "f", "?", "k"]);

say "\nExample 5:";
solution(["b", "e", "g", "?", "l"]);

say "\nExample 6:";
solution(["?", "t", "v", "x", "z"]);

say "\nExample 7:";
solution(["l", "m", "o", "p", "?"]);
