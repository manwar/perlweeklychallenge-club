#!/usr/bin/env perl
# Create a script to parse URL and print the components of URL.
# https://en.wikipedia.org/wiki/URL
# According to Wiki page, the URL syntax is as below:
# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
# For example: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
#   scheme:   jdbc:mysql
#   userinfo: user:password
#   host:     localhost
#   port:     3306
#   path:     /pwc
#   query:    profile=true
#   fragment: h1
#
# usage: $ perl ch-2.pl "jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1"

use strict;
use warnings;
use feature qw/ say /;

# I tried to write something which would work with optional components but it
# is beyond me at the moment.  This is my first attempt which works with a
# url containing all the components i.e. the example.

my $url = $ARGV[0];

$url =~ /^(.+):\/\/(.+)@(.+):(\d+)(\/.+)[?](.+)#(.+)/;

say "scheme:    $1";
say "userinfo:  $2";
say "host:      $3";
say "port:      $4";
say "path:      $5";
say "query:     $6";
say "fragment:  $7";
