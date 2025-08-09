#!/usr/bin/env perl

# jared still - jkstill@gmail.com

=head1 Perl Weekly Challenge 333

 Task 1: Straight Line

 Determine if a set of points are collinear.

 There is a well known algorithm that uses the cross product of three points to determine if they are collinear.

 So, I use that, and then extended it to work with an abitrary number of points.

 Flip the $useChallengeList from 1 to 0 to use the extended data.

=cut

use strict;
use warnings;
use Data::Dumper;
$Data::Dumper::Indent = 0;
$Data::Dumper::Terse = 1;

my @expectedResults;
my @list;

my $useChallengeList = 0; # set to 1 to use the challenge list, 0 to use the custom list

if ($useChallengeList) {

@list = (
	[[2, 1], [2, 3], [2, 5]], # collinear
	[[1, 4], [3, 4], [10, 4]], # collinear
	[[0, 0], [1, 1], [2, 3]], # not collinear
	[[1, 1], [1, 1], [1, 1]], # collinear
	[[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]] # collinear
);

 @expectedResults = (
	1, # collinear
	1, # collinear
	0, # not collinear
	1, # collinear
	1  # collinear
);

} else {

	# head1 custom list

	@list = (
		[[1,1]],
		[[0,0], [6,7]],
		[[2, 1], [2, 3], [2, 5]],
		[[0, 0], [1, 1], [2, 3], [3,4]],
		[[1, 2], [3, 4], [5, 6]],
		[[1, 1], [2, 2], [3, 3]],
		[[0, 0], [0, 0], [0, 0]],
		[[1, 2], [3, 4], [5, 6]],
		[[1000000, 1000000], [2000000, 2000000], [3000000, 3000000]] ,

		# Collinear
		[[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [8,8]],

		# Non-Collinear
		[[0,0], [1,1], [2,2], [3,3], [4,4], [5,4], [6,6], [7,7], [8,8]],
		
		#Collinear 
		[[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [8,8], [9,9]],

		# Non-Collinear 
		[[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7], [8,8], [9,9],[10,11]],
		
		# Non-Collinear
		[[0,0], [1,1], [2,2], [3,3], [4,2], [5,1], [5,2], [6,3], [7,4]]
	);

	# 1: collinear
	# 0: not collinear
	@expectedResults = (
		1,
		1,
		1,
		0,
		1,
		1,
		1,
		1,
		1,
		1,
		0,
		1,
		0,
		0,
	);

}

print '@list = ( ' . Dumper(\@list) . " )\n\n";

# Calculate the cross product of three points at a time.
# Advance through the list of points, checking three at a time.
# If the number of points <= 2, they are collinear.

my $e = 0;

foreach my $chkListRef (@list) {

	print "Checking points: " . Dumper($chkListRef) . "\n";

	my $numberOfPoints = scalar(@$chkListRef);
	my $remainder = $numberOfPoints % 3;
	my $isCollinear = 1;

	# walk the list of lists of points, advancing 1 point at a time
	for ( my $i = 0; $i <= scalar(@$chkListRef) - 3; $i++ ) {

		my $p1 = defined $chkListRef->[$i] ? $chkListRef->[$i] : undef;
		my $p2 = defined $chkListRef->[$i + 1] ? $chkListRef->[$i + 1] : undef;
		my $p3 = defined $chkListRef->[$i + 2] ? $chkListRef->[$i + 2] : undef;

		$isCollinear = crossProduct( $p1, $p2, $p3 ) ? 1 : 0;
		last unless $isCollinear;

	}

	print "expected:results $expectedResults[$e]:$isCollinear \n";
	print "\n";

	$e++;

}

# Check if the points are collinear.
# check three points at a time
# If the cross product is zero, the points are collinear.
sub crossProduct {
	my ( $p1, $p2, $p3 ) = @_;
	# if less than 3 points, they are collinear
	return 1 if ( !defined $p3 );
	return ( ( $p2->[0] - $p1->[0] ) * ( $p3->[1] - $p1->[1] ) - ( $p2->[1] - $p1->[1] ) * ( $p3->[0] - $p1->[0] ) ) == 0;
}


