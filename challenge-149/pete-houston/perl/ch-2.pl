#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 14902.pl
#
#        USAGE: ./14902.pl N
#
#  DESCRIPTION: Given a base N find the largest perfect square in that
#               base with no repeated digits
#
#      OPTIONS: N defaults to 10 if missing
# REQUIREMENTS: Perl 5.9.5 for Module::Load::Conditional, Convert::AnyBase,
#               either List::Util 1.44 or List::MoreUtils or
#               List::SomeUtils
#         BUGS: Going to take a long time for large N
#        NOTES: Convert::AnyBase uses Moose, so this will be quite heavy.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 24/01/22
#===============================================================================

use strict;
use warnings;
use 5.009_005;
use bigint;

use Convert::AnyBase;
use Module::Load::Conditional qw/check_install can_load/;

BEGIN {
	my @list = (
		{
			module => 'List::Util',
			version => '1.44'
		},
		{
			module => 'List::MoreUtils'
		},
		{
			module => 'List::SomeUtils'
		}
	);
	my $ok = 0;
	for my $mod (@list) {
		my $this = check_install (%$mod) or next;
		next unless $this->{uptodate};
		$ok = can_load (modules => {$mod->{module} => $mod->{version}});
		$mod->{module}->import ('uniq');
		last;
	}
	die "Need one of the List::* modules for uniq\n" unless $ok;
}

my $n = shift // 10;
die "Run out of symbols\n" if $n > 36;

my $set = substr ('0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ', 0, $n);
my $cab = Convert::AnyBase->new (set => $set);

# Start with the largest possible number
my $start = reverse $set;
my $dec = $cab->decode ($start);
my $root = sqrt ($dec);
exit 1 - print "$start\n" if $root == int $root;

# Unlikely to be that lucky, so on down we go ...
$root = int $root;
my $sqb;
do {
	$sqb = $cab->encode ($root * $root);
	$root--;
} until $root < 0 || unique_digits ($sqb);
print "$sqb\n";

sub unique_digits {
	my @x = split //, shift;
	return @x == uniq @x;
}
