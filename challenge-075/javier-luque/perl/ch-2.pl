#!/usr/bin/perl
# Test: ./ch-2.pl
use Modern::Perl;
use List::Util qw /max/;

histogram(2, 1, 4, 5, 3, 7);
say "Output: " . largest_rect(2, 1, 4, 5, 3, 7);

say "\n";

histogram(3, 2, 3, 5, 7, 5);
say "Output: " . largest_rect(3, 2, 3, 5, 7, 5);

sub histogram {
	my @A = @_;
	my $max = max @A;

	for my $row (reverse (1 ..$max)) {
		printf ("%s ", $row);
		for my $col (@A) {
			if ($col >= $row) {
				print "# ";
			} else {
				print "  ";
			}
		}
		print "\n";
	}

	print "- " x (scalar(@A) + 1) . "\n";
	print "  " . (join ' ', @A) . "\n";
}

sub largest_rect {
	my @A = @_;

	my @stack;
	my $max_area = 0;
	my $stack_top;
	my $i = 0;

	while ($i < scalar(@A)) {
		if (!scalar(@stack) || $A[$stack[-1]] <= $A[$i]) {
			push @stack, $i++;
		} else {
			$stack_top = pop @stack;
			my $w = (scalar(@stack)) ?
				($i - $stack[-1] - 1) : $i;
			my $area = $A[$stack_top] * $w;
			$max_area = max($max_area, $area);
		}
	}

	while (@stack) {
		$stack_top = pop @stack;
		my $w = (scalar(@stack)) ?
			($i - $stack[-1] - 1) : $i;
		my $area = $A[$stack_top] * $w;
		$max_area = max($max_area, $area);
	}

	return $max_area;
}
