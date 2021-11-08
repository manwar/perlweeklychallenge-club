#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11802.pl
#
#        USAGE: ./11802.pl [ -v N ]
#
#  DESCRIPTION: Knight moves: hop around the board collecting the treasure
#
#      OPTIONS: -v specifies the verbosity level:
#                   0 = minimum verbosity (default)
#                   1 = debug (show target picking, etc.)
#                   2 = trace (show maths, move choices, etc.)
# REQUIREMENTS: Getopt::Std
#         BUGS: Not optimal. Code could be much neater, too.
#        NOTES: See POD for full details
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/06/21
#===============================================================================

use strict;
use warnings;

use Getopt::Std;

=head1 Knight Moves

This is a 1st-order solution to task 2 of Challenge 118 (0th order being
the brute-force visit-all-the-squares approach). It attempts to be
semi-smart in determining how and whither the knight should move.

=head2 Algorithm

A target is chosen by least square distance from the knight. This target
is pursued and will be the next acquired unless any other target is just
one move away at any point during this pursuit.

The pursuit of the target varies depending on the distance to it.
Sufficiently far-off targets (square distance > 5) are approached
directly with the larger difference of x and y getting the larger step.

When the target is closer (within 2 squares) we pick one of the 2
possible best known moves, always preferring squares we have not visited
before.

Once a treasure has been acquired it is removed from the list and the
next target chosen.

When no targets are left, the quest is complete.

The algorithm does not distinguish between equidistant objects when
choosing the next target, so starting at a8 the nearest targets are the
equidistant c4 and e6. Clearly e6 is preferable as it involves less
backtracking but the algorithm ingores this and just chooses randomly
between them. Scope for improvement.

As it stands for the given starting point and treasure distribution the
algorithm takes between 12 and 16 moves inclusive to gather all the
treasure.

=head2 Co-ordinates

Rather than faff about with letters and numbers internally we will use a
catesian grid with 0,0 at a1 and 7,7 at h8. These are converted to
chess notation on output for the benefit of the user. Debugging messages
may inlcude the internal representations.

=cut

# Do we want the verbose output?
my $DEBUG = 0;
{
	my %opts;
	$Getopt::Std::STANDARD_HELP_VERSION = 1;
	getopts ('v:', \%opts) or die "Bad options.\n";
	$DEBUG = $opts{v} if defined ($opts{v}) && $opts{v} =~ /^[012]$/;
	debug (1, "Debugging at level $DEBUG enabled.\n");
}

# Start position - alter this if you want a different puzzle
my @kpos = (0, 7); # a8

# Target positions - alter these if you want a different puzzle
my %tpos = (
	'0,1' => 1,
	'1,0' => 1,
	'1,1' => 1,
	'1,2' => 1,
	'2,3' => 1,
	'4,5' => 1,
);

# How does a knight move
my @moves = (
	[ 2, 1], [ 2, -1],
	[-2, 1], [-2, -1],
	[ 1, 2], [ 1, -2],
	[-1, 2], [-1, -2]
);

my @targets = map { [split /,/] } keys %tpos;
my $next;
my @log;
my %visited;

print "Starting at " . pstr (@kpos) . "\n";
OUTER: while (keys %tpos) {
	$visited{"@kpos"} = 1;
	# Is any target a valid jump from here? If so, snaffle it.
	for my $t (@targets) {
		my $move = [$t->[0] - $kpos[0], $t->[1] - $kpos[1]];
		if (grep { "@$_" eq "@$move" } @moves) {
			@kpos = @$t;
			print "Moved to " . pstr (@kpos) . " and snaffled treasure\n";
			push @log, [@kpos];
			delete $tpos{join ',', @$t};
			@targets = map { [split /,/] } keys %tpos;
			undef $next;
			next OUTER;
		}
	}

	# Find closest target and navigate towards it.
	my $nsqd = 0;
	unless (defined $next) {
		my @dists = map { ($_->[0] - $kpos[0]) ** 2 + ($_->[1] -$kpos[1]) ** 2 }
			@targets;
		my $ni = 0;
		for (0 .. $#dists) {
			$ni = $_ if $dists[$_] < $dists[$ni];
		}
		$next = $targets[$ni];
		$nsqd = $dists[$ni];
		debug (1, "Nearest target is at " . pstr (@$next) .
			" (sq distance = $nsqd)\n");
	} else {
		$nsqd = ($next->[0] - $kpos[0]) ** 2 + ($next->[1] - $kpos[1]) ** 2;
		debug (2, "Square distance to next target = $nsqd\n");
	}

	# Which is the way to go to now?
	if ($nsqd == 1) {
		# Get it to where it is 2 away, so 1 or 2 choices
		# Move is 1 to the target and then 2 away sideways
		# kpos = x,y targ = x + n, y + m where n,m is some combo of +-1
		# and 0. 
		debug (2, "Target is 1 lateral space away\n");
		my @opts = $next->[0] eq $kpos[0] ?
			([$kpos[0] + 2, $next->[1]], [$kpos[0] - 2, $next->[1]]) :
			([$next->[0], $kpos[1] + 2], [$next->[0], $kpos[1] - 2]);
		@kpos = @{best_choice (@opts)};
	} elsif ($nsqd == 2) {
		# Next diagonal, so up to 2 choices
		# kpos = x,y targ = x +/- 1, y +/- 1
		debug (2, "Target is 1 diagonal space away\n");
		my @opts = ([$kpos[0] + ($next->[0] - $kpos[0]) * 2,
		             $kpos[1] + ($kpos[1] - $next->[1])],
					[$kpos[0] + ($kpos[0] - $next->[0]),
					 $kpos[1] + ($next->[1] - $kpos[1]) * 2]);
		my $best = best_choice (@opts);
		# There may be no valid choices if we are hemmed in a corner
		unless (defined $best) {
			# Just pick a valid one
			$best = best_choice (
				map { [ $_->[0] + $kpos[0], $_->[1] + $kpos[1] ] }
				@moves );
		}
		@kpos = @$best;
	} elsif ($nsqd == 4) {
		# 2 away, so 1 or 2 choices
		# kpos = x,y targ = x + n, y + m where n,m is some combo of +-2
		# and 0. 
		debug (2, "Target is 2 lateral spaces away\n");
		my @opts = $next->[0] eq $kpos[0] ?
			([$kpos[0] + 2, $kpos[1] + ($next->[1] - $kpos[1]) / 2],
			 [$kpos[0] - 2, $kpos[1] + ($next->[1] - $kpos[1]) / 2]) :
			([$kpos[0] + ($next->[0] - $kpos[0]) / 2, $kpos[1] + 2],
			 [$kpos[0] + ($next->[0] - $kpos[0]) / 2, $kpos[1] - 2]);
		@kpos = @{best_choice (@opts)};
	} else {
		# Too far away to worry. Just head in the general direction
		debug (2, "Target is far away - heading towards it\n");
		my $dx = $next->[0] - $kpos[0];
		my $dy = $next->[1] - $kpos[1];
		debug (2, "dx = $dx, dy = $dy\n");
		my @move;
		if (abs ($dx) > abs ($dy)) {
			my $x = $kpos[0] + ($dx > 0 ? 2 : -2);
			my $ychange = $dy > 0 ? 1 : -1;
			@move = ([$x, $kpos[1] + $ychange], 
			         [$x, $kpos[1] - $ychange]);
		} else {
			my $y = $kpos[1] + ($dy > 0 ? 2 : -2);
			my $xchange = $dx > 0 ? 1 : -1;
			@move = ([$kpos[0] + $xchange, $y], 
			         [$kpos[0] - $xchange, $y]);
		}
		my $best = best_choice (@move);
		@kpos = @$best;
	}
	print "Moved to " . pstr (@kpos) . "\n";
	push @log, [@kpos];
}

print "\nMade " . @log . " moves visiting " . 
	(1 + keys %visited) . " squares.\n";

=head2 Subroutines

=head3 best_choice

Given an array of positions (each an arrayref) return the one arrayref
which is decided to be the "best", or undef if none are on the board.

=cut

sub best_choice {
	my @possibles = @_;

	debug (1, "Considering " . scalar @possibles . " moves\n");
	debug (2, "Possibles are: " .
		join (',', map { "($_->[0], $_->[1])" } @possibles) . "\n");
	# Rule out any impossibles
	@possibles = grep { $_->[0] < 8 && $_->[0] > -1
	                 && $_->[1] < 8 && $_->[1] > -1 } @possibles;
	return unless scalar @possibles;
	debug (1, "Have " . scalar @possibles . " valid moves\n");

	# Pick one that we've not visited before (if any)
	my ($best) = grep { ! $visited{"@$_"} } @possibles;
	return $best // $possibles[0];
}

=head3 pstr

Given the position of the knight as an array of ints, translate into
standard chess notation and return that string suitable for printing.

=cut

sub pstr {
	my ($x, $y) = @_;
	$x = chr ($x + 97);
	$y++;
	return "$x$y";
}

=head3 debug

Given a debug level (1, 2) and a string output the string if the debug
is at the relevant level.

=cut

sub debug {
	my ($l, $str) = @_;
	print $str if $DEBUG >= $l;
}
