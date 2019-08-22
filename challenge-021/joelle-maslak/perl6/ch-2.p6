#!/usr/bin/env perl6
use v6;

# We only do the opertions gauranteed to preserve semantics.

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
    my $normalized = normalize($url);

    say $normalized;
}

sub normalize($url -->Str:D) {
    my $parse = URL.parse($url);
    die "Invalid URL" unless $parse.defined;

    my $str = $parse<scheme>.lc ~ ":";

    $str ~= "//" if $parse<host>:exists;
    $str ~= $parse<userinfo> ~ '@' if $parse<userinfo>:exists ;
    $str ~= normalize-percent($parse<host>.lc) if $parse<host>:exists;

    if $parse<scheme>.lc eq 'http' and $parse<port>:exists {
        $str ~= ":" ~ $parse<port> if $parse<port> ≠ 80;
    } elsif $parse<scheme>.lc eq 'https' and $parse<port>:exists {
        $str ~= ":" ~ $parse<port> if $parse<port> ≠ 443;
    } elsif $parse<port>:exists {
        $str ~= ":" ~ $parse<port>;
    }

    $str ~= normalize-percent($parse<path>) if $parse<path>:exists;
    $str ~= normalize-percent($parse<query>) if $parse<query>:exists;
    $str ~= normalize-percent($parse<fragment>) if $parse<fragment>:exists;

    return $str;
}

sub normalize-percent($part) {
    my $remainder = $part;
    my $output    = '';

    while $remainder.chars {
        my $beginning = S/ ( <-[ % ]>* ) .*$/$0/ with $remainder;
        my $end       = S/ <-[ % ]>*//           with $remainder;

        $output ~= $beginning // '';

        if ($end // '').chars {
            if $end !~~ m:i/^ '%' ( <[ a..f 0..9 ]> ** 2..2 )/ {
                die("Invalid percent encoding");
            }
            my $encoding = :16($end.substr(1, 2));
            if 0x41 ≤ $encoding ≤ 0x5a { # Upper case
                $output ~= $encoding.chr;
            } elsif 0x61 ≤ $encoding ≤ 0x7a { # Lower case
                $output ~= $encoding.chr;
            } elsif 0x30 ≤ $encoding ≤ 0x39 { # Digits
                $output ~= $encoding.chr;
            } elsif $encoding == 0x2d { # Hyphen
                $output ~= $encoding.chr;
            } elsif $encoding == 0x2e { # Period
                $output ~= $encoding.chr;
            } elsif $encoding == 0x5f { # Underscore
                $output ~= $encoding.chr;
            } elsif $encoding == 0x7e { # Tilde
                $output ~= $encoding.chr;
            } else {
                $output ~= "%" ~ $encoding.fmt("%02x");
            }

            $remainder = $end.substr(3);
        } else {
            # No defined end
            $remainder = '';
        }
    }

    return $output;
}

