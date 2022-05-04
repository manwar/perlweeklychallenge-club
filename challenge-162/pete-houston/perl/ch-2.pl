#!/usr/bin/env perl
#===============================================================================
#
#         FILE: 16202.pl
#
#        USAGE: ./16202.pl [ -d ] -k KEYSTRING [ -t TEXT | INFILE ] 
#
#  DESCRIPTION: Encrypt/decrypt usng the Wheatstone-Playfair cipher 
#
#      OPTIONS: Use -d to decrypt (default is to encrypt)
#      OPTIONS: Use -t to provide a text string as an argument
#               without -t, use the argument as the filename to read from
#               with no argument at all, read from STDIN
# REQUIREMENTS: Getopt::Long::Modern
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 26/04/22
#===============================================================================

use strict;
use warnings;

package ACME::Crypt::Playfair;

sub new {
	my ($class, $key, $opts) = @_;

	my $self = {
		key        => $key,
		split_char => $opts->{split_char} // 'x',
	};
	bless $self, $class;
	$self->build;
	return $self;
}

sub build {
	my $self = shift;

	# Normalise the key;
	my $key = lc $self->{key};
	$key =~ s/[^a-z]//g;

	my %seen;
	my $i = 0;
	my $j = 0;
	my @grid;
	my @chars = (split (//, $key), grep { $_ ne 'j' } map { chr } 97 .. 122);
	for my $c (@chars) {
		$c = 'i' if $c eq 'j';
		next if exists $seen{$c};
		push @grid, $c;
		$seen{$c} = [ $j, $i ];
		$i++;
		$j++, $i = 0 if $i > 4;
	}
	{
		my $kc = scalar keys %seen;
		die "letter count is $kc! Should be 25.\n" unless $kc == 25;
	}

	# Construct the 5x5 grid
	$self->{grid} = [];
	for my $x (0 .. 4) {
		$self->{grid}[$x] = [@grid[(5 * $x) .. (5 * $x + 4)]];
	}
	$self->{pos} = \%seen;
	return;
}

sub encrypt {
	my ($self, $in) = @_;
	$self->crypto ($in, 1, [0, 1]);
}

sub decrypt {
	my ($self, $in) = @_;
	$self->crypto ($in, -1, [1, 0]);
}

sub crypto {
	my ($self, $in, $dir, $order) = @_;

	my $out = '';
	$in = lc $in;
	$in =~ tr /a-z//cd;
	$in =~ tr/j/i/;
	while (length $in) {
		my $buf = substr $in, 0, 2, '';
		my @bc = split //, $buf;
		$bc[1] //= $self->{split_char};
		if ($bc[0] eq $bc[1]) {
			$in = $bc[1] . $in;
			$bc[1] = $self->{split_char};
		}

		if ($self->{pos}{$bc[0]}[0] == $self->{pos}{$bc[1]}[0]) {
			# Same row
			my $r = $self->{grid}[$self->{pos}{$bc[0]}[0]];
			$bc[$_] = $r->[($self->{pos}{$bc[$_]}[1] + $dir) % 5] for 0, 1;
		} elsif ($self->{pos}{$bc[0]}[1] == $self->{pos}{$bc[1]}[1]) {
			# Same col
			my $cn = $self->{pos}{$bc[0]}[1];
			$bc[$_] = $self->{grid}[($self->{pos}{$bc[$_]}[0] + $dir) % 5][$cn]
				for 0, 1;
		} else {
			# Copy the old one to avoid clobbering
			my @obc = @bc;
			$bc[$_] = $self->{grid}[
				$self->{pos}{$obc[$_]   }[0]]
				[$self->{pos}{$obc[1 - $_]}[1]] for @$order;
		}
		$out .= $bc[0] . $bc[1];
	}
	return $out;
}

################################################################################

package main;

use Getopt::Long::Modern;

GetOptions (
	'd|decrypt'   => \my $decrypt,
	'k|key=s'     => \my $key,
	't|text=s'    => \my $text
);

my $action = defined ($decrypt) ? 'decrypt' : 'encrypt';
unless (defined $text) {
	my $fh = \*STDIN;
	if (defined $_[0]) {
		open $fh, '<', $_[0] or die "Cannot open $_[0]: $!";
	}
	local $/ = undef;
	$text = <$fh>;
}

my $engine = ACME::Crypt::Playfair->new ($key);
my $output = $engine->$action ($text);
print "$output\n";
