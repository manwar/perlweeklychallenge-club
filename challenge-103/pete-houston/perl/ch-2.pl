#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 10302.pl
#
#        USAGE: ./10302.pl STARTTIME [ NOW ] FILE
#
#  DESCRIPTION: What's playing now?
#
#      OPTIONS: If the 2nd arg is omitted, uses the current time.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 08/03/21
#===============================================================================

use strict;
use warnings;

my ($start, $now, $file) = get_args ();

my @tracks     = load_tracks ($file);
my $duration   = (1000 * ($now - $start)) % $tracks[-1]->{finish};
my $trackstart = 0;

for my $track (@tracks) {
	if ($track->{finish} < $duration) {
		$trackstart = $track->{finish};
		next;
	}
	output ($track->{title}, $duration - $trackstart);
	last;
}

sub load_tracks {
	my $fname = shift;
	open my $fh, '<', $fname or die "Cannot open $fname for reading: $!";
	my ($fin, @t) = 0;
	while (my $line = <$fh>) {
		my ($len, $name) = split /,/, $line, 2;
		$fin += $len;
		push @t, { finish => $fin, title => $name };
	}
	return @t;
}

sub get_args {
	if (3 == @ARGV) {
		return @ARGV;
	} elsif (2 == @ARGV) {
		return ($ARGV[0], time, $ARGV[1]);
	} else {
		die "Usage: $0 STARTTIME [ NOW ] FILE\n\n";
	}
}

sub output {
	my ($t, $s) = @_;
	$s /= 1000;
	printf "%s%2.2i:%2.2i:%2.2i\n", $t, $s / 3600, ($s / 60 % 60), $s % 60;
}
