#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-017/
# Task #2
# Create a script to parse URL and print the components of URL. According to Wiki page, the URL syntax is as below:
# https://en.wikipedia.org/wiki/URL
# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
#
# For example: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
#
#  scheme:   jdbc:mysql
#  userinfo: user:password
#  host:     localhost
#  port:     3306
#  path:     /pwc
#  query:    profile=true
#  fragment: h1

use strict;
use warnings;

my $uri = shift || 'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1';

my ($scheme, $auth, $path, $query, $frag, $userinfo, $host, $port);

($scheme, $auth, $path, $query, $frag) = uri_split($uri);
($userinfo, $host, $port) = auth_split($auth) if $auth;

show('scheme',$scheme);
show('userinfo',$userinfo);
show('host',$host);
show('port',$port);
show('path',$path);
show('query',$query);
show('fragment',$frag);

#based on URI::Split
sub uri_split {
     return $_[0] =~ m|
                        ^                       # string start
                        ([^/?\#]+) :            # scheme
                        (?: // ([^/?\#]*) )?    # authority (optional)
                        ([^?\#]*)               # path
                        (?: \? ([^\#]*) )?      # query (optional)
                        (?: \# (.*) )?          # fragment (optional)
                        $                       # string end
                    |x;
}

sub auth_split {
     return $_[0] =~ m|
                        (?: ([^@]+) @ )?        # userinfo (optional)
                        ([^:/?\#]+)             # host
                        (?: : (\d+) )?          # port (optional)
                    |x;
}

sub show {
    my $name = shift . ':';
    my $value = shift || '';
    print sprintf("%-10s%s\n",$name,$value);
}
