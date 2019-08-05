#!/usr/bin/env perl6
use v6;

grammar URL {
    token TOP      {
        ^
        <scheme> ':'
        [
            '//'
            [ <userinfo> '@' ]?
            <host>
            [ ':' <port> ]?
        ]?
        <path>
        [ '?' <query> ]?
        [ '#' <fragment> ]?
        $
    }
    token scheme   { <[A .. Z a .. z ]> <[ A .. Z a .. z 0 .. 9 . + - ]>* }
    token userinfo { <username> ':' <password> }
    token username { <[ \S ] - [ : ]>+ }
    token password { <[ \S ] - [ @ ]>* }
    token host     { <[ \S ] - [ : ? / \# ]>+ }
    token port     { <[ \S ] - [ ? / \# ]>+ }
    token path     { [ '/' <[ \S ] - [ ? \# ]>* ]? }
    token query    { <[ \S ] - [ \# ]>* }
    token fragment { \S* }
}


sub MAIN(Str:D $url) {
    my $parse = URL.parse($url);

    if ! $parse.defined {
        say "Invalid URL";
        exit;
    }

    say "Scheme:   " ~ ($parse<scheme>   // '<not defined>');
    say "Userinfo: " ~ ($parse<userinfo> // '<not defined>');
    say "Host:     " ~ ($parse<host>     // '<not defined>');
    say "Port:     " ~ ($parse<port>     // '<not defined>');
    say "Path:     " ~ ($parse<path>     // '<not defined>');
    say "Query:    " ~ ($parse<query>    // '<not defined>');
    say "Fragment: " ~ ($parse<fragment> // '<not defined>');
}

