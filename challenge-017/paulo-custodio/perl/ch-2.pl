#!/usr/bin/perl

# Challenge 017
#
# Task #2
# Create a script to parse URL and print the components of URL. According to
# Wiki page, the URL syntax is as below:
#
# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
#
# For example: jdbc://user:password@localhost:3306/pwc?profile=true#h1
#
#   scheme:   jdbc
#   userinfo: user:password
#   host:     localhost
#   port:     3306
#   path:     /pwc
#   query:    profile=true
#   fragment: h1

use strict;
use warnings;
use 5.030;

my $url = shift;
my $word = qr{ [a-z_] [a-z_0-9+.-]* }ix;
my $path = qr{ (?: $word | / )+ }ix;
$url =~ m{^             (?<scheme>      $word   ) [:]
            (?:
                //
                (?:     (?<userinfo>    $word   (?: [:] .*? )? ) [@] )?
                        (?<host>        $word   )
                (?: [:] (?<port>        \d+     )       )?
            )?
                        (?<path>        $path   )
            (?: [?]     (?<query>       .*?     )       )?
            (?: [#]     (?<fragment>    .*?     )       )?
          $}ix
    or die "Invalid URL $url\n";

say "scheme:   ", $+{scheme}    // "";
say "userinfo: ", $+{userinfo}  // "";
say "host:     ", $+{host}      // "";
say "port:     ", $+{port}      // "";
say "path:     ", $+{path}      // "";
say "query:    ", $+{query}     // "";
say "fragment: ", $+{fragment}  // "";
