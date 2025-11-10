#!/usr/bin/env perl
use v5.40;

use List::AllUtils qw( zip );

sub targetMatch($target, $str) {
  my $result;
  eval "\$result = $str";
  $result == $target;
}

sub magicExpression3($op, $target, $digits, $ops, $pos, $found) {
  $ops->[$pos] = $op;
  my $str = join("", zip(@$digits, @{[@$ops,""]}));

  $found->{$str} = 1 if $str !~ /\D0\d+/
                   && targetMatch($target, $str);
  magicExpression2($target, $digits, $ops, $pos+1, $found);
}

sub magicExpression2($target, $digits, $ops, $pos, $found) {
  return if $pos >= @$ops; # terminate recusrion

  magicExpression3("",  $target, $digits, $ops, $pos, $found);
  magicExpression3("+", $target, $digits, $ops, $pos, $found);
  magicExpression3("-", $target, $digits, $ops, $pos, $found);
  magicExpression3("*", $target, $digits, $ops, $pos, $found);
}

sub magicExpression($target, $str) {
  my %found;
  my $digits = [ split //, $str ];
  my $ops = [ map { "" } 1 .. length($str)-1 ];
  magicExpression2($target, $digits, $ops, 0, \%found);
  return keys %found;
}

sub solution($str, $target) {
  say qq{Input: \$str = "$str", \$target = $target};
  say 'Output: (' .
    join(', ', map { qq{"$_"} } magicExpression($target, $str)) .
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
