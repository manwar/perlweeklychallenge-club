#!/usr/bin/env perl

use v5.24;
use strict;
use warnings;
use feature qw(signatures);
no warnings "experimental::signatures";
use Carp;
use utf8;
use open ':std', ':encoding(UTF-8)';

=for comment

Create a script to parse URL and print the components of URL. According to Wiki page, the URL syntax is as below:

scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

For example: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1

  scheme:   jdbc:mysql
  userinfo: user:password
  host:     localhost
  port:     3306
  path:     /pwc
  query:    profile=true
  fragment: h1

=cut

sub parse_url_regex($url) {
    my %parsed;

    while ($url) {
        if ( !exists $parsed{scheme} ) {
            $url =~ s!^((?:[[:alnum:]]+:)?[[:alnum:]]+):!!;

            # MUST start with the scheme, format: "scheme:"
            croak "Invalid format: url must start with scheme." unless $1;
            $parsed{scheme} = $1;

            return \%parsed unless $url =~ s!^//!!;
        }
        elsif ( !exists( $parsed{host} )
            && $url
            =~ s!^(?:((?:[\d\w]+:)?(?:[\d\w]+)?)@)?([\d\w\.]+)(?::([\d]+))?!!u
            )
        {
            $parsed{userinfo} = $1 // "";
            $parsed{host} = $2 // "";
            $parsed{port} = $3 // "";
        }
        elsif ( !exists( $parsed{path} )
            && $url =~ s!^/((?:[\d\w\.\/]*)+)!!u )
        {
            $parsed{path} = "/" . ( $1 // "" );
        }
        elsif ( !exists( $parsed{query} )
            && $url =~ s!^\?((?:[\d\w\[\]%\"\']+)=(?:[\d\w\[\]%\"\']+))*!!u )
        {
            $parsed{query} = $1 // "";
        }
        elsif ( !exists( $parsed{fragment} )
            && $url =~ s!^#([\d\w\[\]%\"\']+)!!u )
        {
            $parsed{fragment} = $1 // "";
        }
        else {
            croak "Error: Invalid URL? $url";
        }
    }

    return \%parsed;
}

sub print_parsed ($url_hash_ref) {
    for my $part (qw(scheme userinfo host port path query fragment)) {
        say "$part:\t" . $url_hash_ref->{$part}
            if exists $url_hash_ref->{$part}
            && defined $url_hash_ref->{$part};
    }
    say "";
}

print_parsed(
    parse_url_regex(
        q"jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1")
);
print_parsed(
    parse_url_regex(q"http://sri:foo@example.com:3000/foo?foo=bar#23") );
print_parsed( parse_url_regex(q"https://example.com/") );
print_parsed(
    parse_url_regex(
        q"http://JP納豆.例.jp:80/dir1/引き割り.html?q=クエリ#メイン"
    )
);

use Mojo::URL;
use Mojo::Util qw(decode url_unescape);

use Test::More tests => 7;
my $parsed_regex
    = parse_url_regex(
    q"http://JP納豆.例.jp:80/dir1/引き割り.html?q=クエリ#メイン"
    );
my $parsed_mojo
    = Mojo::URL->new(
    q"http://JP納豆.例.jp:80/dir1/引き割り.html?q=クエリ#メイン"
    );
is( $parsed_mojo->scheme,
    $parsed_regex->{scheme},
    "Mojo and regex sub agree on 'scheme'"
);
is( $parsed_mojo->userinfo // '',
    $parsed_regex->{userinfo},
    "Mojo and regex sub agree on 'userinfo'"
);
is( $parsed_mojo->host, $parsed_regex->{host},
    "Mojo and regex sub agree on 'host'" );
is( $parsed_mojo->port, $parsed_regex->{port},
    "Mojo and regex sub agree on 'port'" );
is( decode( 'UTF-8', url_unescape( $parsed_mojo->path ) ),
    $parsed_regex->{path}, "Mojo and regex sub agree on 'path'" );
is( decode( 'UTF-8', url_unescape( $parsed_mojo->query ) ),
    $parsed_regex->{query},
    "Mojo and regex sub agree on 'query'"
);
is( $parsed_mojo->fragment,
    $parsed_regex->{fragment},
    "Mojo and regex sub agree on 'fragment'"
);

use Benchmark::Forking qw(cmpthese);

cmpthese(
    -2,
    {   from_scratch_regex => sub {
            parse_url_regex(
                q"http://JP納豆.例.jp:80/dir1/引き割り.html?q=クエリ#メイン"
            );
        },
        mojo => sub {
            Mojo::URL->new(
                parse_url_regex(
                    q"http://JP納豆.例.jp:80/dir1/引き割り.html?q=クエリ#メイン"
                )
            );
        }
    }
);

=for comment

                       Rate               mojo from_scratch_regex
mojo                31204/s                 --               -72%
from_scratch_regex 110892/s               255%                 --

=cut
