#!/usr/bin/env raku

unit sub MAIN(UInt $first, UInt $second);

say "Ethiopian multiplication of $first and $second\n";

multi operate(@items where *.tail.head == 1) { @items }
multi operate(@items) { operate (|@items, (@items.tail.head div 2, @items.tail.tail * 2)) }

my @steps = operate (($first.Int, $second.Int),);
say 'Steps:';
.say for @steps;

say "\nKepp odd numbers:";
my @odd = @steps.grep: *.head % 2;
.say for @odd;

say "\nKeep right values:";
my @right = @odd.map: *.tail;
.say for @right;

say "\nAdd the numbers:";
say @right.sum;
