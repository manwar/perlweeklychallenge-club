use v6;

################################################################################
=begin comment

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

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

use URI::Split:from<Perl5> <uri_split>;

my Sub $uri-split := &URI::Split::uri_split;

my Str constant $DEFAULT-URL =
                'jdbc://user:password@localhost:3306/pwc?profile=true#h1';

sub MAIN(Str:D $url = $DEFAULT-URL)
{
    my ($scheme, $authority, Str $path, $query, $fragment) = $uri-split($url);

    die 'Empty scheme' unless $scheme;
    validate-scheme($scheme);

    my ($userinfo, $host, $port);
       ($userinfo, $host, $port) = parse-authority($authority) if $authority;

    $authority //= '';
    $_         //= '(none)' for $userinfo, $host, $port, $query, $fragment;
    $path      ||= '(empty)';

    display-url($url,  $scheme, $authority, $userinfo, $host,
                $port, $path,   $query,     $fragment);

    CATCH
    {
        default
        {
            $*ERR.say: "\nError parsing URL \"$url\":";
            $*ERR.say: .message;
        }
    }
}

sub validate-scheme(Str:D $scheme)
{
    if $scheme ~~ / ^ ( <-[A..Za..z]> ) /
    {
        die "Invalid initial character \"$0\" in scheme \"$scheme\"";
    }

    if $scheme ~~ /   ( <-[A..Za..z0..9+.-]> ) /
    {
        die "Invalid character \"$0\" in scheme \"$scheme\"";
    }
}

sub parse-authority(Str:D $authority is rw --> List)
{
    my ($userinfo, $host, $port);

    if $authority
    {
        $authority ~~ s{ ^ \/\/ } = '';

        # USERINFO: An optional userinfo subcomponent that may consist of a user
        # name and an optional password preceded by a colon (:), followed by an
        # at symbol (@). Use of the format username:password in the userinfo
        # subcomponent is deprecated for security reasons. Applications should
        # not render as clear text any data after the first colon (:) found
        # within a userinfo subcomponent unless the data after the colon is the
        # empty string (indicating no password).

        if ($authority ~~ /\@/)
        {
            ($userinfo, $authority) = split /\@/, $authority, 2;

            if ($userinfo ~~ /\:/)
            {
                my ($username, $password) = split /\:/, $userinfo, 2;

                $userinfo = $username ~ ':' ~ '*' x $password.chars;
            }
        }

        # PORT: An optional port subcomponent preceded by a colon (:).

        if ($authority ~~ /\:/)
        {
            ($host, $port) = split /\:/, $authority, 2;
        }
        else
        {
            $host = $authority;
        }
    }

    return ($userinfo, $host, $port);
}

sub display-url
(
    Str:D $url,
    Str:D $scheme,
    Str:D $authority,
    Str:D $userinfo,
    Str:D $host,
    Str:D $port,
    Str:D $path,
    Str:D $query,
    Str:D $fragment
)
{
    say "\nURL: $url\n" ~
        "\nScheme:     $scheme";

    if ($authority)
    {
        say "Authority:\n"            ~
            "  Userinfo: $userinfo\n" ~
            "  Host:     $host\n"     ~
            "  Port:     $port";
    }
    else
    {
        say "Authority:  (none)";
    }

    say "Path:       $path\n"  ~
        "Query:      $query\n" ~
        "Fragment:   $fragment";
}

################################################################################
