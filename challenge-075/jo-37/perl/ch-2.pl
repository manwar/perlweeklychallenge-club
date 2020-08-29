#!/usr/bin/perl


# A tailor-made class for this task.
package Rectangle;

use strict;
use warnings;
use List::Util qw(min);
use overload
	'<=>' => \&cmp_rect,	# compare by size
	'.=' => \&position,		# set position
	'""' => \&show;			# stringify

# Create a new rectangle over the full length of
# the given (partial) histogram and with maximum height.
sub new {
	my $class = shift;

	bless {height => min(@_) // 0,
		length => scalar @_,
		position => -1}, $class;
}

# Compare two rectangles by size.
sub cmp_rect {
	my ($self, $other) = @_;

	$self->{length} * $self->{height} <=> $other->{length} * $other->{height};
}

# Set (end) position.
sub position {
	my ($self, $pos) = @_;

	$self->{position} = $pos;
	$self;
}

# String representation.
sub show {
	my $self = shift;

	sprintf "size=%d, length=%d, position=%d, height=%d",
		$self->{length} * $self->{height}, $self->{length},
		$self->{position}, $self->{height};
}

# Check if point is contained in rectangle.
sub contains {
	my ($self, $ix, $height) = @_;

	$ix >= $self->{position} - $self->{length} + 1 &&
		$ix <= $self->{position} && $height <= $self->{height};
}

package main;

use strict;
use warnings;
use List::Util qw(max reduce);

# Find the largest rectangle inside a histogram.
# The Rectangle constructor, comparator and assignment operator
# are specifically designed to offer a terse implementation here.
sub max_rect {

	# Slide over all elements seeking for the maximum rectangle
	reduce {
		my $pos = $b;
		# Slide over all windows ending at the selected position.
		reduce {
			# Get the maximum rectangle over the full window length.
			my $rect = Rectangle->new(@_[$b .. $pos]);
			# If the new rectangle is larger than the current maximum,
			# set the position and use it as the new maximum.
			$rect > $a ? $rect .= $pos : $a;
		} $a, 0 .. $b;
	} Rectangle->new, 0 .. $#_;
}

# Create the histogram row data at the given height:
# - empty, if height is above the value
# - asterisk, if the point is inside the maximum rectangle
# - hash otherwise.
sub hist_chars {
	my ($max, $height) = (shift, shift);

	map $_[$_] >= $height ?
		$max->contains($_, $height) ?
		'*' : '#' : '', 0 .. $#_;
}

# Generate a format string. Produces $size + 1 items of equal
# length $len that are separated by one blank. The first item has
# conversion $first, the rest have conversion $rest.
sub gen_fmt ($$$$) {
	my ($len, $first, $rest, $size) = @_;

	"%${len}${first}" . " %${len}${rest}" x $size . "\n";
}

# Print the histogram.
sub print_hist {
	my $max = shift;

	my $height = max @_;
	my $len = length $height;

	my $fmt = gen_fmt $len, 'd', 's', @_;
	do {
		printf $fmt, $height, hist_chars $max, $height, @_
	} while --$height;
	printf gen_fmt($len, 's', 's', @_), ('-') x (@_ + 1);
	printf gen_fmt($len, 's', 'd', @_), '', @_;
}

# main

for my $hist ([2, 1, 4, 5, 3, 7], [3, 2, 3, 5, 7, 5, 2]) {
	my $max = max_rect @$hist;
	print_hist $max, @$hist;
	print "max rectangle: $max\n\n";
}
