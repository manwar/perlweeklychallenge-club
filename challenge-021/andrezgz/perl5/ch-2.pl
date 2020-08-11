#!/usr/bin/perl

# https://perlweeklychallenge.org/blog/perl-weekly-challenge-021/
# Task #2
# Write a script for URL normalization based on rfc3986. This task was shared by Anonymous Contributor.
# https://en.wikipedia.org/wiki/URL_normalization
# According to Wikipedia, URL normalization is the process by which URLs are modified and standardized
# in a consistent manner. The goal of the normalization process is to transform a URL into a normalized URL
# so it is possible to determine if two syntactically different URLs may be equivalent.

use strict;
use warnings;

my $url_in = $ARGV[0]
  || 'HTTPS://www.Example.com:443/a%c2%b1b/%7Eandrezgz/bar.html?pi=3%2e14#hi%2Dthere';

print 'Original:'.$/;
print $url_in.$/.$/;

my ($scheme, $auth, $path, $query, $frag, $userinfo, $host, $port);

($scheme, $auth, $path, $query, $frag) = uri_split($url_in);
($userinfo, $host, $port) = auth_split($auth) if $auth;

# Normalizations that preserve semantics

## Converts the scheme and host to lower case.
($scheme, $host) = map { lc $_ } ($scheme, $host);

## Capitalizes letters in escape sequences.
## Decodes percent-encoded octets of unreserved characters.
($path, $query, $frag) =
    map { my $comp = $_;
          $comp =~ s{%([A-Fa-f0-9]{2})}
                    { my $chr = chr(hex($1));
                      $chr =~ /^[A-Za-z0-9\-_\.~]$/ ? $chr : '%'.uc $1;
                    }ge if $comp;
          $comp;
        } ($path, $query, $frag);

## Removes the default port (port 80 for http).
my %default_ports = (
    ftp     => 21,    gopher  => 70,    http    => 80,    https   => 443,
    ldap    => 389,   ldaps   => 636,   mms     => 1755,  news    => 119,
    pop     => 110,   rlogin  => 513,   rsync   => 873,   rtsp    => 554,
    rstpu   => 554,   sip     => 5060,  sips    => 5061,  snews   => 563,
    ssh     => 22,    telnet  => 23,    tn3270  => 23,
);
$port = '' if ($port == $default_ports{$scheme});

print 'Normalized:'.$/;
print uri_join($scheme, $userinfo, $host, $port, $path, $query, $frag).$/;


sub uri_join {
  my ($scheme, $userinfo, $host, $port, $path, $query, $frag) = @_;

  my $uri = $scheme . ':';
  if ($host) {
    $uri .= '//';
    $uri .= $userinfo . '@' if ($userinfo);
    $uri .= $host;
    $uri .= ':' . $port if ($port);
  }
  $uri .= $path;
  $uri .= '?' . $query if ($query);
  $uri .= '#' . $frag if ($frag);

  return $uri;
}


# functions created in challenge-017/andrezgz/perl5/ch-2.pl
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
