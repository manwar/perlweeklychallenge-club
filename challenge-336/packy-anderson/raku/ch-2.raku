#!/usr/bin/env raku
use v6;

sub finalScore(@scores) {
  my (@stack, $rounds, $count);
  for @scores -> $action {
    my $previous = @stack[*-1];
    given $action {
      when "+" { @stack.push( @stack[*-1] + @stack[*-2] ) }
      when "C" { @stack.pop() }
      when "D" { @stack.push( @stack[*-1] * 2 ) }
      default  { @stack.push($action) }
    }
    $rounds ~= sprintf "Round %2d: ", ++$count;
    $rounds ~= @stack.map({$_ < 0 ?? "($_)" !! $_}).join(" + ");
    $rounds ~= " (sum of previous two scores)"
      if $action eq "+";
    $rounds ~= " (double the previous score $previous)"
      if $action eq "D";
    $rounds ~= " (invalidate the previous score $previous)"
      if $action eq "C";
    $rounds ~= "\n";
  }
  my $sum = sum(@stack);
  $rounds ~= "\nTotal Scores: $sum";
  return ($sum, $rounds);
}

sub solution(@scores) {
  my $list = @scores.map({ qq{"$_"} }).join(', ');
  say "Input: \@scores = ($list)";
  my ($output, $rounds) = finalScore(@scores);
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
