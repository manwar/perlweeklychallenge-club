#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

use Mojo::URL;

# Create a script to parse URL and print the components of URL.
# According to Wiki page, the URL syntax is as below:

# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

my @list;
push @list, 'ftp://ftp.cerias.purdue.edu/pub/dict/README.txt';
push @list, 'http://slashdot.org/';
push @list, 'https://en.wikipedia.org/wiki/URL';
push @list, 'https://github.com/manwar/perlweeklychallenge-club/pulse';
push @list, 'https://mail.google.com/mail/u/0/#inbox/FMfcg';
push @list, 'https://perlweeklychallenge.org/blog/perl-weekly-challenge-017/';
push @list, 'https://practimer.me:443/#5m0s';
push @list, 'https://www.perlmonks.org/?node_id=818843';
push @list, 'mysql://user:password@localhost:3306/pwc?profile=true#h1';

# Mojo::URL does NOT like the example URL
push @list, 'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1';

@list = @ARGV if scalar @ARGV;    # replace test list if anything is entered

for my $url ( sort @list ) {
    my $mojo     = Mojo::URL->new($url);
    my $scheme   = $mojo->scheme || '';
    my $userinfo = $mojo->userinfo || '';
    my $host     = $mojo->host || '';
    my $port     = $mojo->port || '';
    my $path     = $mojo->path || '';
    my $query    = $mojo->query || '';
    my $fragment = $mojo->fragment || '';

    say <<"END";
    URL         $url
    scheme      $scheme
    userinfo    $userinfo
    host        $host
    port        $port
    path        $path
    query       $query
    fragment    $fragment
END
}

__DATA__
