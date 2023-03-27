#!/usr/bin/perl
#
# Task 2: Merge Account
# 
# You are given an array of accounts i.e. name with list of email addresses.
# 
# Write a script to merge the accounts where possible. The accounts can
# only be merged if they have at least one email address in common.
# 
# Example 1:
# 
#   Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                        ["B", "b1@b.com"],
#                        ["A", "a3@a.com", "a1@a.com"] ]
#                      ]
# 
#   Output: [ ["A", "a1@a.com", "a2@a.com", "a3@a.com"],
#             ["B", "b1@b.com"] ]
# 
# Example 2:
# 
#   Input: @accounts = [ ["A", "a1@a.com", "a2@a.com"],
#                        ["B", "b1@b.com"],
#                        ["A", "a3@a.com"],
#                        ["B", "b2@b.com", "b1@b.com"] ]
# 
#   Output: [ ["A", "a1@a.com", "a2@a.com"],
#             ["A", "a3@a.com"],
#             ["B", "b1@b.com", "b2@b.com"] ]
# 
# MY NOTES: fiddly and rather inelegant, especially only being allowed to
# merge two entries if the intersection of the email lists is non empty.
# Will also need to choose an input format, how about a list of words of the
# form A,a1@a.com,a2@a.com, B,b1@b.com, A,a3@a.com and B,b2@b.com,b1@b.com
# 
# (TODO) GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl into C
# (TODO) (look in the C directory for that)
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Data::Dumper;

my $debug=0;
die "Usage: merge-accounts [--debug] name,emails+\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV > 0;

my @input = map {
	my @x = split( /,/ );
	\@x;
} @ARGV;

#say "input: ", Dumper(\@input) if $debug;

my %names = map { $_->[0] => 1 } @input;
my @names = sort keys %names;
#say "names: ", Dumper(\@names) if $debug;


#
# my @out = merge( $name, @input );
#	Take $name, and @input, all the $name->email-set rules
#	and merge as many as possible of the email-sets, returning
#	one or more name,email-set results.
#
sub merge
{
	my( $name, @input ) = @_;
	@input = map { my @m = @$_; shift @m; \@m } @input;
	say "name $name: ", Dumper(\@input) if $debug;
	my @result;
	for( my $i=0; $i<@input; $i++ )
	{
		my $aref = $input[$i];
		say "i $i, name $name: ", Dumper($aref) if $debug;
		my %mem = map { $_ => 1 } @$aref;

		# ok, check through all later inputs, trying to merge
		# them into $aref (deleting them from @input) if we manage.
		for( my $j=$i+1; $j<@input; $j++ )
		{
			my $bref = $input[$j];
			say "j $j, name $name: ", Dumper($bref) if $debug;
			if( grep { $mem{$_} } @$bref )	# can merge
			{
				map { $mem{$_}++ } @$bref;
				splice( @input, $j, 1 );	# remove this
				say "merged j $j into i $i" if $debug;
			}
		}

		# turn %mem back into a list
		my @list = sort keys %mem;

		push @result, [ $name, @list ];
	}
	return @result;
}


my @output = map {
		my $name = $_;
		merge( $name, grep { $_->[0] eq $name } @input );
	} @names;

print "output: [ ";
print join( ', ',
	map { "[" .
	  join( ', ',
		map { qq("$_") } @$_
	  ). "]"; } @output );
say " ]";
