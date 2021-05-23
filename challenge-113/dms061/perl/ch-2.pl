=pod

=head1 Question 2

You are given a Binary Tree.

Write a script to replace each node of the tree with the sum of all the remaining nodes.

Example
Input Binary Tree

        1
       / \
      2   3
     /   / \
    4   5   6
     \
      7

Output Binary Tree

        27
       /  \
      26  25
     /   /  \
    24  23  22
     \
     21

NOTE: the example output has the new values as the total_sum - node_value, so remaining nodes in the
question does not mean nodes in the subtrees, it means all the other nodes in the tree

=head1 Approach

Do a preorder iteration, summing values to get the sum
Then do another preorder iteration, and update values (sum - node val) -> done!

Issue: how should we encode the tree? 
(val, ref_branch1, ref_branch2)?
or should we try working with objects in perl?
Going to use references to hashes to build a quick tree out of references (and make it look like an object XD)

=cut

use strict;
use warnings;

#sub preorder (&@);

sub new {
	my ($val, $lref, $rref) = @_;
	my $node = {val => $val, left => $lref, right => $rref};
	return $node;
}

sub preorder (&@) {
	my ($expr, $node) = @_;
	$_ = $node->{"val"};
	$node->{"val"} = &$expr;
	# the & forces it to run without the prototype
	# important because we switch from asking for an anon-block
	# to a code ref (which encapsulates that block)
	&preorder ($expr, $node->{"left"}) if $node->{"left"};
	&preorder ($expr, $node->{"right"}) if $node->{"right"};
}

sub print_tree {
	my $node = shift;
	preorder {print "Val: $_\n"; $_;} $node;
}

my $test = new 1, new (2, new (4, , new(7))), new (3, new (5), new (6));
#$test->{"left"} = new 2;
#$test->{"right"} = new 3;

print "(Preorder) Original:\n";
print_tree $test;
my $sum = 0;
preorder {$sum += $_; $_;} $test;
preorder {$sum - $_} $test;
print "(Preorder) Modified:\n";
print_tree $test;

#preorder &print, $test;
# experiment with function prototypes to make something similar to map for trees :)
#sub call_ref (&@) {
#	my ($f, $x) = @_;
#	$_ = $x;
#	print "test?\n";
#	return $f->($x);
#}

#print (call_ref {print "$_\n"; $_;} 10);

