#!/usr/bin/perl
#
# Challenge 3: "Write a script to use Random Poems API:
# https://www.poemist.com/api/v1/randompoems
# This is the easiset API, I have come across so far. You don't need API
# key for this. They have only route to work with (GET). The API task is
# optional but we would love to see your solution."
# 
# My notes: ok, even I can't argue that obtaining an API key for an API
# I will literally never use again is too much hassle - when I don't need
# an API key, and the whole program appears to be an LWP::Simple get, and
# a bit of JSON decoding magic.
#
# Once I had the array of random poems decoded (an array of hashes), I
# wondered what to do with them all, so I decided to show you a list of
# title, poet, and content length for each poem, and let you choose which
# poem to see (or quit).
#
# However, a few of the poems seem to be in Unicode and utterly screw up my
# terminal, and I'm not sure how to handle Unicode.  As a quick hack I've run
# the whole content through Encode's decode('UTF-8'..) first.  That didn't
# remove all the weird high-bytes that screw up my terminal, so I wrote a
# sanitize() routine to delete all high-bytes.  For some random Chinese
# poem, there's basically nothing left, but at least my terminal survives.
# 

use v5.10;	# to get "say"
use strict;
use warnings;
use LWP::Simple;
use JSON;
use Encode;
use Function::Parameters;
#use Data::Dumper;


die "Usage: ch-3.pl\n" unless @ARGV==0;
my $content = decode( 'UTF-8',
	get( "https://www.poemist.com/api/v1/randompoems" ) );
my $list = decode_json( $content );

my @poems = map { sanitize($_->{content}); } (@$list);

listpoems( $list );

my $n = @poems;
while(1)
{
	print "\nShow poem 1..$n (or list, or quit)? ";
	my $input = <STDIN>;
	chomp $input;

last if $input =~ /^q/i;

	if( $input =~ /^l/i )
	{
		listpoems( $list );
		next;
	}
	if( $input >= 1 && $input <= @poems )
	{
		my $content = $poems[$input-1];
		say "\n$content\n";
	} else
	{
		print "bad poem number $input\n";
	}
}


#
# listpoems( $list );
#	List all the titles of the poems
#
fun listpoems( $list )
{
	my $n = 1;
	foreach my $poem (@$list)
	{
		my $url = $poem->{url};
		my $poet = $poem->{poet}->{name};
		my $poeturl = $poem->{poet}->{url};
		my $title = sanitize( $poem->{title} );
		my $content = sanitize( $poem->{content} );

		# count the number of lines in the content..
		my $nlines = ($content =~ tr/\n//) + 1;

		print "\n$n: $title ($url) by $poet ($poeturl) - length $nlines\n";
		$n++;
	}
}

#
# my $str = sanitize( $input );
#	In a desperate attempt to avoid displaying Unicode messages
#	screwing up my terminal, let's simply: delete all bytes > 127
#
fun sanitize( $input )
{
	my $result = "";
	foreach my $ch (split(//,$input))
	{
		$result .= $ch if ord($ch)<128;
	}
	return $result;
}


