# Create a script to parse URL and print the components of URL.
# According to Wiki page, the URL syntax is as below:

# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

# For example: jdbc://user:password@localhost:3306/pwc?profile=true#h1

#   scheme:   jdbc
#   userinfo: user:password
#   host:     localhost
#   port:     3306
#   path:     /pwc
#   query:    profile=true
#   fragment: h1

use strict;
use warnings;
use v5.10;

my $url = shift;
die "Usage: perl $0 <url>" unless $url;

my ( $scheme, $userinfo, $host, $port, $path, $query, $fragment );

# instead of using a big regex, we will try to match every part of
# URIs definition in https://en.wikipedia.org/wiki/URL
#
my $remaining = $url;

# first we extract the scheme part:

die "missing scheme in $url" unless $remaining =~ s/^([a-z][a-z\d+\.\-]*)://;
$scheme = $1;

# note that $remaining here will not have the scheme part anymore

# now we extract the optional authority component preceded by
# two slashes (//), and followed by an optional slash (/):
# so we capture all consecutive non slash characters on $1,
# and then extract userinfo, host and port:

if ( $remaining =~ s/^\/\/([^\/]*)// ) {
    my $remaining_authority = $1;
    $userinfo = $1 if $remaining_authority =~ s/(.*?)\@//;
    ( $host, $port ) = split /:/, $remaining_authority;
}

# now we extract path as all consecutive non '?' nor '#' character
# starting at begining of $remaining:

$path = $1 if ( $remaining =~ s/^([^\?#]*)// );

# now we extract query as all consecutive non '#' chars starting after
# initial "?" char

$query = $1 if ( $remaining =~ s/^\?([^#]*)// );

# and the rest (excluding initial '#' char if any), is fragment:

$fragment = $1 if $remaining =~ /^#(.*)/;

# now we just print every existing component:

say "scheme: $scheme";
say "userinfo: $userinfo" if $userinfo;
say "host: $host"         if $host;
say "port: $port"         if $port;
say "path: $path"         if $path;
say "query: $query"       if $query;
say "fragment: $fragment" if $fragment;
