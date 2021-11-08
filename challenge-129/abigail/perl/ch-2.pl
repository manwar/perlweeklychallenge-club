#!/opt/perl/bin/perl

use 5.032;

use strict;
use warnings;
no  warnings 'syntax';

use experimental 'signatures';
use experimental 'lexical_subs';

#
# See ../README.md
#

#
# Run as: perl ch-1.pl < input-file
#

#
# Linked lists? Seriously? Now, there are problems for which a linked
# list is the right datastructure, and for which using an array is a
# bad choice. Advent of Code usually manages to create at least one
# problem each year highlighting this.
#
# For this challenge, forcing to use a linked list feels as clunky as
# writing a novel with using the letter 'e'. Sure, the first guy who
# did so got some recognition, but that was a one time event. It's not
# that e-free novels are storming the top 10 reading lists.
#
# But even if you were to represent numbers as linked lists of single
# digit numbers, why on earth would you represent your number in such
# a way you have to process the linked list back to forth? You'd fail
# algorithms 101 if you ever did that in class.
#

#
# Also, what's up with the hint? Are we free to come up with our own
# unique way to deal with the task, or should we create a class representing
# a linked list, with a bunch of methods? Those two statements contradict
# each other.
#
# I can't be bothered to come with a full class which does nothing to solve
# the given problem, so I'll be ignoring anything of the hint following its
# first full stop.
#
# (Also: "a method to add new member", At the front? The back? Somewhere
# in the middle? These things matter for linked list. 
# And: "It should have methods to create a linked list given list of
# single digit positive numbers" So, you need a method which given a list,
# gives you back a list? That's a no-op, isn't it?)
#

#
# Helper functions to turn a number into a linked list,
# and a linked list back into a number:
# (If we have to bring in linked lists to add numbers, don't mind
#  me if I bring in $& and friends).
#
sub n2ll ($num) {$num =~ /./ ? [my $x = $&, n2ll ($')] : []}
sub ll2n ($ll)  {@$ll ? $$ll [0] . ll2n ($$ll [1]) : ""}

#
# Add two linked lists. We do this by flattening the lists,
# using bigint to add the numbers, then turning the result
# into a list again.
#
sub add ($ll1, $ll2) {use bigint; n2ll (0 + ll2n ($ll1) + ll2n ($ll2))}


#
# Read in the two numbers, and turn them into linked lists:
#
my $f_ll = n2ll <> =~ s/[^0-9]+//gr;
my $s_ll = n2ll <> =~ s/[^0-9]+//gr;

#
# Add them:
#
my $sum_ll = add ($f_ll, $s_ll);

#
# Pretty print the result:
#
say join " -> " => split // => ll2n $sum_ll;
