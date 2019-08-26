#!/usr/bin/perl
#
# Challenge 2: "Write a script for URL normalization based on rfc3986.
#
# According to Wikipedia, URL normalization is the process by which URLs
# are modified and standardized in a consistent manner. The goal of the
# normalization process is to transform a URL into a normalized URL so
# it is possible to determine if two syntactically different URLs may
# be equivalent.
# 
# My notes: The RFC link points to a long list of regex-syle changes,
# not all of which have to be implemented.  Easy to implement most.
# Later thought: many of the changes only apply to parts of the URL,
# so I'll reuse part of my solution to challenge 017, part 2.. url splitting
#
# ./ch-2.pl HTTP://ed@mit.edu:800/../%7e%64%75%6e%63%61%6e/%5d%20%ff/a/../../b/../c/../default.asp
# normalized url is http://ed@mit.edu:800/~duncan/
# 

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

die "Usage: ch-2.pl URL\n" unless @ARGV==1;
my $url = shift;

$url = normalize( $url );
print "normalized url is $url\n";

#
# my %info = parse_url($url);
#	Parse URL $url. Return a hash of the pieces.  If parsing
#	fails, return an empty hash.
#	     scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
#	eg. jdbc://user:password@localhost:3306/pwc?profile=true#h1
#
#	parses to:
#        scheme:   jdbc
#        userinfo: user:password
#        host:     localhost
#        port:     3306
#        path:     /pwc
#        query:    profile=true
#        fragment: h1
#
fun parse_url( $url )
{
	$url =~ s/^([^:]+):// || return ();

	my %hash;
	$hash{scheme} = $1;
	if( $url =~ s|^//|| )
	{
		$hash{userinfo} = $1 if $url =~ s|^(.+)@||;
		return () unless $url =~ s|^([\w\.]+)||;
		$hash{host} = $1;
		$hash{port} = $1 if $url =~ s/^:(\d+)//;
		$hash{fragment} = $1 if $url =~ s/#([^#]+)$//;
		$hash{query} = $1 if $url =~ s/\?([^\?]+)$//;
		$hash{path} = $url;
	}
	return %hash;
}


#
# $path = sanitize_path( $path );
#	remove '' and '.' path elements, and process '..' as if
#	we were descending a directory tree, and also remove trailing
#	inde.html and similar entries.
#
fun sanitize_path( $path )
{
	my @x = split( m|/|, $path );

	# traverse the path elements, ignoring '.' and '' elements,
	# pushing any element but a '..' on a stack,
	# and popping the top element when you see a '..'
	my @p;
	foreach (@x)
	{
		next if $_ eq '.' || $_ eq '';
		if( $_ eq '..' )
		{
			pop @p;
		} else
		{
			push @p, $_;
		}
	}

	my $path = '/'. join('/', @p );

	# remove trailing index.htm[l]? if present
	$path =~ s|/index.html?$|/|;

	# remove trailing default.jsp if present
	$path =~ s|/default.asp$|/|;

	# add trailing slash if missing - no, don't, bad idea
	#$path =~ s|([^/])$|$1/|;

	return $path;
}


#
# my $normalizedurl = normalize( $url );
#	Normalize $url according to RFC3986
#
fun normalize( $url )
{
	# 1. lowercase whole url
	$url = lc($url);

	# 2. uppercase %hh triples
	$url =~ s/(%[0-9a-f][0-9a-f])/\U$1/g;

	# 3. decode unnecessary %HH triples, viz:
	# "ALPHA (%41-%5A and %61-%7A), DIGIT (%30-%39), hyphen (%2D),
	#  period (%2E), underscore (%5F), or tilde (%7E)"
	$url =~
	s/%(4[0-9A-F]|5[0-9A]|6[0-9A-F]|7[0-9A]|3[0-9]|2D|2E|5F|7E)/chr(hex("0x".$1))/eg;

	# now parse url into parts..
	my %info = parse_url($url);

	# 4. remove default port
	delete $info{port} if $info{port} eq "80";

	my $path = $info{path};

	# 5. sanitize path in various ways, eg remove '', '.'and '..' elements
	$path = sanitize_path( $path );

	# finally, merge bits back together
	$url = $info{scheme}."://";
	$url .= $info{userinfo}."@" if $info{userinfo};
	$url .= $info{host};
	$url .= ":".$info{port} if $info{port};
	$url .= $path;
	$url .= "?".$info{query} if $info{query};
	$url .= "#".$info{fragment} if $info{fragment};
	return $url;
}
