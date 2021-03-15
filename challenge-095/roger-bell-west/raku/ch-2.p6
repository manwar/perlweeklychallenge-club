#! /usr/bin/perl6

class Local::Stack {
  has @!stack;

  method push($op) {
    @!stack.push($op);
  }

  method pop {
    if (@!stack.elems == 0) {
      die "insufficient elements for pop\n";
    }
    return @!stack.pop;
  }

  method top {
    if (@!stack.elems == 0) {
      die "insufficient elements for top\n";
    }
    return @!stack[@!stack.end];
  }

  method min {
    if (@!stack.elems == 0) {
      die "insufficient elements for min\n";
    }
    return min(@!stack);
  }

}

use Test;

plan 3;

my $stack=Local::Stack.new();
$stack.push(2);
$stack.push(-1);
$stack.push(0);
is($stack.pop,0,'test 1');       # removes 0
is($stack.top,-1,'test 2'); # prints -1
$stack.push(0);
is($stack.min,-1,'test 3'); # prints -1
