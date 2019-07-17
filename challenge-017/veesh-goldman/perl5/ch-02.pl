#! /usr/bin/env perl
use v5.22;
use Mojo::URL;

my $url = Mojo::URL->new(shift);
say <<"ANSWER"
scheme:   ${\$url->scheme}
userinfo: ${\$url->userinfo}
host:     ${\$url->host}
port:     ${\$url->port}
path:     ${\$url->path}
query:    ${\$url->query}
fragment: ${\$url->fragment}
ANSWER
