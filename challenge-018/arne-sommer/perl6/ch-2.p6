#! /usr/bin/env perl6

use lib "lib";

use PriorityQueue;

my $PQ = PriorityQueue.new;

$PQ.insert_with_priority("AA$_", (^99).pick) for ^10;

while ! $PQ.is_empty
{
  say $PQ.pull_highest_priority_element;
}