#!/usr/bin/env perl
use strict;
use warnings;

# breadth-first search
sub bfs {
	my @ret;
	my @a = shift;
	while (@a) {
		my $v = shift @a or next;
		push @ret, $v->[0];
		push @a, @{$v}[1,2];
	}
	return @ret;
}


sub invert {
	my @ret;
	my @a = shift;
	while (@a) {
		my $v = shift @a or next;
		push @ret, $v->[0];
		push @a, @{$v}[2,1];
	}
	return @ret;
}



# Full Binary Tree
my $tree = [1,[2,[4],[5]],[3,[6],[7]]];
# my $tree = [1,[2,[4,[8],[9]],[5,[10],[11]]],[3,[6,[12],[13]],[7,[14],[15]]]];

my @bfs = bfs($tree);
print "Full Binary Tree: [@bfs]\n";
&pretty_print(\@bfs);

my @inverted = invert($tree);
print "Full Binary Tree Inverted: [@inverted]\n";
&pretty_print(\@inverted);


# Geometric series, Power of two:
sub pretty_print($) {
	my @tree = @{+shift};
	my $i = 0;
	while(1) {
		my $items = 2**$i;
		my @row = splice @tree, 0, $items;
		last unless @row;
		print "| @row\n";
		$i++;
	}
}


__END__
$ ./ch-1.pl
Full Binary Tree: [1 2 3 4 5 6 7]
| 1
| 2 3
| 4 5 6 7
Full Binary Tree Inverted: [1 3 2 7 6 5 4]
| 1
| 3 2
| 7 6 5 4
