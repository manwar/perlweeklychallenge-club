#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( sum );

sub finalScore(@scores) {
  my (@stack, $rounds, $count);
  foreach my $action ( @scores ) {
    my $previous = $stack[-1];
    foreach ($action) {
      /\+/ && do { push @stack, $stack[-1] + $stack[-2]; last };
      /C/  && do { pop  @stack; last; };
      /D/  && do { push @stack, $stack[-1] * 2; last; };
      push @stack, $action;
    }
    $rounds .= sprintf "Round %2d: ", ++$count;
    $rounds .= join(" + ", map {$_ < 0 ? "($_)" : $_} @stack);
    $rounds .= " (sum of previous two scores)"
      if $action eq "+";
    $rounds .= " (double the previous score $previous)"
      if $action eq "D";
    $rounds .= " (invalidate the previous score $previous)"
      if $action eq "C";
    $rounds .= "\n";
  }
  my $sum = sum(@stack);
  $rounds .= "\nTotal Scores: $sum";
  return ($sum, $rounds);
}

sub solution($scores) {
  my $list = join(', ', map { qq{"$_"} } @$scores);
  say "Input: \@scores = ($list)";
  my ($output, $rounds) = finalScore(@$scores);
  say "Output: $output\n\n$rounds";
}

say "Example 1:";
solution(["5","2","C","D","+"]);

say "\nExample 2:";
solution(["5","-2","4","C","D","9","+","+"]);

say "\nExample 3:";
solution(["7","D","D","C","+","3"]);

say "\nExample 4:";
solution(["-5","-10","+","D","C","+"]);

say "\nExample 5:";
solution(["3","6","+","D","C","8","+","D","-2","C","+"]);

