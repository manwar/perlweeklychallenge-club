#!perl

################################################################################
=comment

Perl Weekly Challenge 017
=========================

Task #2
-------

Create a script to parse URL and print the components of URL. According to
[ https://en.wikipedia.org/wiki/URL |Wiki page], the URL syntax is as below:

  scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

For example: jdbc://user:password@localhost:3306/pwc?profile=true#h1

  scheme:   jdbc
  userinfo: user:password
  host:     localhost
  port:     3306
  path:     /pwc
  query:    profile=true
  fragment: h1

=cut
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use strict;
use warnings;
use Const::Fast;
use Try::Tiny;
use URI::Split qw( uri_split );

const my $DEFAULT_URL =>
         'jdbc://user:password@localhost:3306/pwc?profile=true#h1';

MAIN:
{
    my $url = $ARGV[0] // $DEFAULT_URL;

    try
    {
        my ($scheme, $authority, $path, $query, $fragment) = uri_split($url);

        validate_scheme($scheme);

        my ($userinfo, $host, $port) = parse_authority($authority);

        display_url($url,  $scheme, $authority, $userinfo, $host,
                    $port, $path,   $query,     $fragment);
    }
    catch
    {
        warn "\nError parsing URL \"$url\":\n$_";
    }
}

# SCHEME: A non-empty scheme component followed by a colon (:), consisting of a
# sequence of characters beginning with a letter and followed by any combination
# of letters, digits, plus (+), period (.), or hyphen (-).

sub validate_scheme
{
    my ($scheme) = @_;

    $scheme
        or  die "Empty scheme\n";

    $scheme =~ / ^ ( [^A-Za-z] ) /x
        and die "Invalid initial character \"$1\" in scheme \"$scheme\"\n";

    $scheme =~ /   ( [^A-Za-z0-9+.-] ) /x
        and die "Invalid character \"$1\" in scheme \"$scheme\"\n";
}

# AUTHORITY: An optional authority component preceded by two slashes (//)...

sub parse_authority
{
    my ($authority) = @_;
    my ($userinfo, $host, $port);

    if ($authority)
    {
        $authority =~ s{ ^ // }{}x;

        # USERINFO: An optional userinfo subcomponent that may consist of a user
        # name and an optional password preceded by a colon (:), followed by an
        # at symbol (@). Use of the format username:password in the userinfo
        # subcomponent is deprecated for security reasons. Applications should
        # not render as clear text any data after the first colon (:) found
        # within a userinfo subcomponent unless the data after the colon is the
        # empty string (indicating no password).
        
        if ($authority =~ /@/)
        {
            ($userinfo, $authority) = split /@/, $authority, 2;

            if ($userinfo =~ /:/)
            {
                my ($username, $password) = split /:/, $userinfo, 2;

                $userinfo = $username . ':' . '*' x length($password);
            }
        }

        # PORT: An optional port subcomponent preceded by a colon (:).

        if ($authority =~ /:/)
        {
            ($host, $port) = split /:/, $authority, 2;
        }
        else
        {
            $host = $authority;
        }
    }

    return ($userinfo, $host, $port);
}

sub display_url
{
    my ($url,  $scheme, $authority, $userinfo, $host,
        $port, $path,   $query,     $fragment) = @_;

    $_    //= '(none)' for ($userinfo, $host, $port, $query, $fragment);
    $path ||= '(empty)';

    print "\nURL: $url\n" .
          "\nScheme:     $scheme";

    if ($authority)
    {
        print "\nAuthority:"            .
              "\n  Userinfo: $userinfo" .
              "\n  Host:     $host"     .
              "\n  Port:     $port";
    }
    else
    {
        print "\nAuthority:  (none)";
    }

    print "\nPath:       $path"  .
          "\nQuery:      $query" .
          "\nFragment:   $fragment\n";
}

################################################################################
