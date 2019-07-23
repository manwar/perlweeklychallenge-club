#!/usr/bin/env perl
# vi:et:sw=4 ts=4 ft=perl

use strict;
use warnings;
use utf8;
use feature qw(say);
use URI::Fast qw(uri);

my $uri = uri q|jdbc://user:password@localhost:3306/pwc?profile=true#h1|;
say 'scheme', ':', $uri->scheme;
say 'userinfo', ':', $uri->usr, ':', $uri->pwd;
say 'host', ':', $uri->host;
say 'port', ':', $uri->port;
say 'path', ':', $uri->path;
say 'query', ':', scalar $uri->query;
say 'fragment', ':', $uri->frag;

1;

__END__
$ perl ch-2.pl
scheme:jdbc
userinfo:user:password
host:localhost
port:3306
path:pwc
query:profile=true
fragment:h1
