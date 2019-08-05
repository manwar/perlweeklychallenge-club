#!/usr/bin/perl

# Challenge 2: "Using only the official postal (2-letter) abbreviations
# for the 50 U.S. states, write a script to find the longest English word
# you can spell? Here is the list of U.S. states abbreviations as per
# wikipedia page. This challenge was proposed by team member Neil Bowers.
# 
# For example,
# Pennsylvania + Connecticut = PACT
# Wisconsin + North Dakota = WIND
# Maine + Alabama = MEAL
# California + Louisiana + Massachusetts + Rhode Island = Calamari
# "
# 
# My notes:
# 
# Well, at first glance that looks like an interesting search problem,
# but on second thoughts isn't that just.. a regex?
#
# After I did the basic thing, I added a "--territories" flag to include
# US territories such as "AS" for American Samoa.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;
use Getopt::Long;

my $territories = 0;
die "Usage: ch-2.pl [--territories\n" unless
	GetOptions( "territories" => \$territories ) && @ARGV == 0;

my $states = "al|ak|az|ar|ca|co|ct|de|fl|ga|hi|id|il|in|ia|ks|ky|la".
              "|me|md|ma|mi|mn|ms|mo|mt|ne|nv|nh|nj|nm|ny|nc|nd|oh|ok".
	      "|or|pa|ri|sc|sd|tn|tx|ut|vt|va|wa|wv|wi|wy";
$states .= "|as|dc|fm|gu|mh|mp|pw|pr|vi" if $territories;


#
# my %dict = readdict( $filename );
#	Read a dictionary, build a set of all words.
#	ONLY THOSE OF EVEN LENGTH.
#
fun readdict( $filename )
{
	open( my $in, '<', $filename ) || die;
	my %dict;
	while( <$in> )
	{
		chomp;
		next unless length($_) % 2 == 0;
		$dict{lc($_)}++;
	}
	close( $in );
	return %dict;
}

my %dict = readdict( "/usr/share/dict/words" );

my @result = grep { m|^($states)+$| } sort keys %dict;

#print Dumper( \@result );

my $longestw = "";
my $maxlen = 0;

foreach my $w (@result)
{
	my $l = length($w);
	if( $l > $maxlen )
	{
		$maxlen = $l;
		$longestw = $w;
	}
}

print "$maxlen letters long\n";

print "longest words made up only of US state abbreviations ";
print "and territories " if $territories;
print "are:\n";
foreach my $w (@result)
{
	print "$w\n" if length($w) == $maxlen;
}

