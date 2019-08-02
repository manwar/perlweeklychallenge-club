#!/bin/env perl6

# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
grammar URL {
    token TOP { ^
        <scheme> ':' 
        [ '//'
            [ <userinfo> '@' ]?
            <host>
            [ ':' <port> ]?
        ]?
        <path>
        [ '?' <queries> ]?
        [ '#' <fragment> ]?
    $ }

    token       scheme { <id> }

    token     userinfo { <user> [ ':' <password> ]? }
    token         user { <id> }
    token     password { \w+ }

    token         host { [ <IPv4-address> | <domain-name> ] }
    token IPv4-address { [\d ** 1..3] ** 4 % '.' }
    token        dname { <[a..zA..Z]> <[-a..zA..Z0..9]>* }
    token  domain-name { <dname>+ % '.' }

    token         port { \d+ }

    token         path { '/' [<[a..zA..Z0..9]>+] *%% '/' }

    token          key { <id> }
    token        value { \w+ }
    token        query { <key> '=' <value> }
    token      queries { <query> +% '&' }

    token     fragment { <id> }

    token           id { <[a..zA..Z]> <[-+.a..zA..Z0..9]>* }
}

sub MAIN(Str $url = 'jdbc://user:password@localhost:3306/pwc?profile=true#h1') {
    my $m = URL.parse($url);
    if $m {
        say 'scheme:   ', ~$m<scheme>;
        say 'userinfo: ', ~$m<userinfo> if $m<userinfo>;
        say 'host:     ', ~$m<host>     if $m<host>;
        say 'port:     ', ~$m<port>     if $m<port>;
        say 'path:     ', ~$m<path>;
        say 'query:    ', ~$m<queries>  if $m<queries>;
        say 'fragment: ', ~$m<fragment> if $m<fragment>;
    }
}
