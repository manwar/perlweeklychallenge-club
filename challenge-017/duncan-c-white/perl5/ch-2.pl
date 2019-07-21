#!/usr/bin/perl

# Challenge 2: "Create a script to parse URL and print the components of
# URL. According to the Wiki page https://en.wikipedia.org/wiki/URL, the URL
# syntax is as below:
# 
#     scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
# 
# eg.  jdbc://user:password@localhost:3306/pwc?profile=true#h1
# 
#       scheme:   jdbc
#       userinfo: user:password
#       host:     localhost
#       port:     3306
#       path:     /pwc
#       query:    profile=true
#       fragment: h1
# 
# My notes: sounds pretty trivial for regexes, if the lexical syntax of
# each component is defined clearly.  Ok, reading the above wiki page
# doesn't make it 100% clear, but let's hack it up, that's probably good
# enough for most cases.

use strict;
use warnings;
use Function::Parameters;
use Data::Dumper;

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



#die "Usage: ch-2.pl URL*\n";
push @ARGV, 'jdbc://user:password@localhost:3306/pwc?profile=true#h1'
	unless @ARGV;
foreach my $url (@ARGV)
{
	my %info = parse_url($url);
	print "$url:\n". Dumper(\%info);
}
