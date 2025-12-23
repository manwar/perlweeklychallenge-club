#!/usr/bin/env raku
use v6;

sub wordCount($sentence) {
  $sentence.split(/\s+/).elems;
}

sub maxWords(@sentences) {
  @sentences.map({ wordCount($_) }).max;
}

sub solution(@sentences) {
  my $joined = @sentences.map({ qq{"$_"}}).join(', ');
  say 'Input: @sentences = (' ~ $joined ~ ')';
  say 'Output: ' ~ maxWords(@sentences);
}

say "Example 1:";
solution(["Hello world", "This is a test", "Perl is great"]);

say "\nExample 2:";
solution(["Single"]);

say "\nExample 3:";
solution(["Short", "This song's just six words long",
          "A B C", "Just four words here"]);

say "\nExample 4:";
solution(["One", "Two parts", "Three part phrase", ""]);

say "\nExample 5:";
solution(["The quick brown fox jumps over the lazy dog", "A",
          "She sells seashells by the seashore",
          "To be or not to be that is the question"]);
