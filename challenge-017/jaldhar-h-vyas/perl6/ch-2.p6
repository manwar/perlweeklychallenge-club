#!/usr/bin/perl6

grammar URL {
    token TOP {
        <Scheme>
        ':'
        [
            '//'?
            [ <Userinfo> '@' ]?
            <Host>
            [ ':' <Port> ]?
        ]?
        <Path>?
        [ '?' <Query> ]?
        [ '#' <Fragment> ]?
    }

    token Scheme { <SchemeChar>+ }
    token Userinfo { <UserinfoChar>+ }
    token Host { <IPv4> | <Unreserved>+ }
    token Port { \d+ }
    token Path { <PathChar>+ }
    token Query { <QueryOrFragment>+ }
    token Fragment { <QueryOrFragment>+ }

    token SchemeChar { <[ A..Z a..z 0..9 + \- . ]> }
    token DecOctet { \d | <[1..9]>\d | 1\d\d | 2<[0..4]>\d | 25<[0..5]> }
    token HexOctet { <[ 0..9 A..F a..f ]> ** 2 }
    token IPv4 { <DecOctet> \. <DecOctet> \. <DecOctet> \. <DecOctet> }
    token PChar { <UserinfoChar> | '@' }
    token PathChar { <PChar> | '/' }
    token PctEncoded { \% <HexOctet> }
    token QueryOrFragment { <PChar> | \/ | \? }
    token SubDelim { <[ \! $ & \' \( \) * \+ \, \; \= ]> }
    token Unreserved { <[ A..Z a..z 0..9 \- . _ \~ ]> }
    token UserinfoChar { <Unreserved> | <PctEncoded> | <SubDelim> | ':' }
}

class URLAction {

    method Scheme($/) {
        say 'Scheme: ', $/.Str;
    }

    method Userinfo($/) {
        say 'Userinfo: ', $/.Str;
    }

    method Host($/) {
        say 'Host: ', $/.Str;
    }

    method Port($/) {
        say 'Port: ', $/.Str;
    }
    method Path($/) {
        say 'Path: ', $/.Str;
    }

    method Query($/) {
        say 'Query: ', $/.Str;
    }

    method Fragment($/) {
        say 'Fragment: ', $/.Str;
    }

}

multi sub MAIN($url) {
    URL.parse($url, actions => URLAction.new);
}