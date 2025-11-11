#!/usr/bin/env raku
use v6;

sub targetMatch($target, $str) {
  my $result;
  use MONKEY-SEE-NO-EVAL;
  EVAL "\$result = $str";
  $result == $target;
}

multi magicExpression($op, $target, @digits, @ops is copy, $pos,
                      %found) {
  @ops[$pos] = $op;
  my $str = (@digits Z~ (@ops,"").flat).join("");
  %found{$str} = 1 if $str !~~ /\D0\d+/
                   && targetMatch($target, $str);
  magicExpression($target, @digits, @ops, $pos+1, %found);
}

multi magicExpression($target, @digits, @ops, $pos, %found) {
  return if $pos > @ops.end; # terminate recusrion

  magicExpression("",  $target, @digits, @ops, $pos, %found);
  magicExpression("+", $target, @digits, @ops, $pos, %found);
  magicExpression("-", $target, @digits, @ops, $pos, %found);
  magicExpression("*", $target, @digits, @ops, $pos, %found);
}

multi magicExpression($target, $str) {
  my %found;
  my @digits = $str.comb;
  magicExpression($target, @digits, "" xx @digits.end, 0, %found);
  return %found.keys;
}

sub solution($str, $target) {
  say qq{Input: \$str = "$str", \$target = $target};
  say 'Output: (' ~
    magicExpression($target, $str).map({qq{"$_"}}).join(', ') ~
  ')';
}

say "Example 1:";
solution("123", 6);

say "\nExample 2:";
solution("105", 5);

say "\nExample 3:";
solution("232", 8);

say "\nExample 4:";
solution("1234", 10);

say "\nExample 5:";
solution("1001", 2);
