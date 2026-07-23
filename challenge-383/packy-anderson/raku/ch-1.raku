#!/usr/bin/env raku
use v6;

sub similar(@list1 is copy, @list2 is copy, @list3) {
  # are the lists the same length?
  return False unless @list1 == @list2;

  # eliminate identical words
  for @list1 -> $word {
    next unless $word eq @list2.any;
    @list1 = [ @list1.grep({ $_ ne $word }) ];
    @list2 = [ @list2.grep({ $_ ne $word }) ];
  }

  # eliminate "similar" words using list3
  for @list1 -> $word {
    for @list3 -> @sublist {
      next unless $word eq @sublist.any;
      next unless my $word2 = @sublist.grep(any @list2);
      @list1 = [ @list1.grep({ $_ ne $word  }) ];
      @list2 = [ @list2.grep({ $_ ne $word2 }) ];
    }
  }

  return @list1 == @list2 == 0;
}

sub solution(@list1, @list2, @list3) {
  say 'Input: $list1 = (' ~ @list1.map({qq/"$_"/}).join(', ') ~ ')';
  say '       $list2 = (' ~ @list2.map({qq/"$_"/}).join(', ') ~ ')';
  my @L3 = @list3.map({ '[' ~ $_.map({qq/"$_"/}).join(', ') ~ ']'});
  say '       $list3 = (' ~ @L3.join(', ') ~ ')';
  say 'Output: ' ~ similar(@list1, @list2, @list3);
}

say "Example 1:";
solution(["great", "acting"], ["fine", "drama"],
         [["great", "fine"], ["acting", "drama"]]);

say "\nExample 2:";
solution(["apple", "pie"], ["banana", "pie"],
         [["apple", "peach"], ["peach", "banana"]]);

say "\nExample 3:";
solution(["perl4", "python"], ["raku", "python"],
         [["perl4", "perl5", "raku"], ]);

say "\nExample 4:";
solution(["enjoy", "challenge"], ["love", "weekly", "challenge"],
         [["enjoy", "love"], ]);

say "\nExample 5:";
solution(["fast", "car"], ["quick", "vehicle"],
         [["quick", "fast"], ["vehicle", "car"]]);
