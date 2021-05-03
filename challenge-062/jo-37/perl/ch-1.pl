#!/usr/bin/perl -s

=head1 NAME

ch-1.pl	- sort email addresses

=head1 SYNOPSIS

ch-1.pl [-u] [-t] [file ...]

=head1 DESCRIPTION

C<ch-1.pl> sorts given email addresses, optionally suppressing
duplicates.
The email addresses are read from the given file names or
C<STDIN> if none is specified.

The given addresses are not checked for validity beyond the existence
of an C<at> sign.

=head1 OPTIONS AND ARGUMENTS

=over

=item B<-u>

print only unique entries

=item B<-t>

use example data from challenge-062 instead of I<file> or C<STDIN>

=item I<file ...>

read addresses from specified I<file>s.

=back

=cut

use strict;
use warnings;

our ($u, $t);

*ARGV = *DATA{IO} if $t;

my @addr;
while (<>) {
	chomp;
	my ($local, $domain) = split '@', $_, 2;
	die "not an email address: $_" unless $local && $domain;
	push @addr, {local => $local, domain => lc($domain), full => $_};
}
my @sorted = sort {$a->{domain} cmp $b->{domain} || 
		lc($a->{local}) cmp lc($b->{local}) ||
		$a->{local} cmp $b->{local}} @addr;

my $result;
if ($u) {
	my $last;
	my @uniq = grep {my $eq = $last &&
		$last->{domain} eq $_->{domain} &&
		$last->{local} eq $_->{local}; $last = $_; !$eq} @sorted;
	$result = \@uniq;
} else {
	$result = \@sorted;
}

print "$_\n" for map {$_->{full}} @$result;

__DATA__
name@example.org
rjt@cpan.org
Name@example.org
rjt@CPAN.org
user@alpha.example.org
