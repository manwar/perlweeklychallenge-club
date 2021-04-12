#!/usr/bin/perl
# 
# Task 2: "List Methods
# 
# Write a script to list methods of a package/class.
# 
# Example
# 
# package Calc;
# 
# use strict;
# use warnings;
# 
# sub new { bless {}, shift; }
# sub add { }
# sub mul { }
# sub div { }
# 
# 1;
# 
# Output
# 
# BEGIN
# mul
# div
# new
# add
# "
# 
# My notes: hmm, introspection.  I genuinely can't remember how to do this
# without a but of googling.  Isn't there a symbol table hash per package,
# that Memoize manipulates?  Ah yes: the stash containing typeglobs.  For
# some reason I can't get BEGIN to appear, so I cheat and add it manually:-)
# 

use strict;
use warnings;
use feature 'say';
use Function::Parameters;
use Getopt::Long;
use Data::Dumper;

my $debug = 0;
die "Usage: subs [--debug] Module\n"
	unless GetOptions("debug"=>\$debug) && @ARGV==1;

my $module = shift;

use lib qw(.);

eval "require $module" || die "can't require $module\n";

my @sub = findsubs( $module );
say for @sub;
exit 0;


#
# my @subs = findsubs( $module );
#	Find all the subroutines inside $module. Return a list of them.
#	Couldn't get BEGIN to appear (although perlmod suggested it would)
#	so added it explicitly:-)
#
fun findsubs( $module )
{
	my @result = ("BEGIN");
	our %stash;
	no strict 'refs';
	*stash = *{"${module}::"};
	while( my( $symbol,$glob) = each %stash )
	{
		#say "symbol=$symbol, glob=",Dumper($glob);
		push @result, $symbol if defined *{$glob}{CODE};
	}
	use strict 'refs';
	return @result;
}
