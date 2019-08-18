#!/usr/bin/perl6
use v6;

use Test;

#use Grammar::Tracer;

# 21.2 Write a script for URL normalization based on (rfc3986)[https://en.wikipedia.org/wiki/URL_normalization]
# Normalization https://tools.ietf.org/html/rfc3986#page-38

#| URL normalization
multi MAIN( $url ) {
    my $m=urlParse($url);
    say $url;
    say stringifyURL($m.made);
    say stringifyURL(normalise($m.made));
    say normalise_URL($url);
}

#| Run tests
multi MAIN ( "test" ) {

    ok urlParse("http:/a/path"),"1 scheme and path test";
    ok urlParse("http:/path"),"2 scheme and path test";
    ok urlParse("http:/path/"),"2.1 scheme and path test";
#     ok urlParse("http:/path:/"),"2.2 scheme and path test";
    ok urlParse("http://example.com/"),"2.3 scheme, authority and trailing slash test";

    ok urlParse("http://localhost/path"),"3 scheme, authority and path test";
    ok urlParse("http://example.com/path"),"4 scheme, authority and path test";
    ok urlParse("http://example.co.uk/path"),"5 scheme, authority and path test";
    ok urlParse("http://example.co.uk/path/"),"5.1 scheme, authority and path test training slash";
    ok urlParse("http://example.co.uk:1234/path"),"6 scheme, authority and path test";
    ok urlParse("http://1.1.1.1/path"),"7 scheme, authority and path test";
    ok urlParse('http://kevin@example.co.uk/path'),"8 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk/path'),"9 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/path'),"10 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a'),"10.1 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/'),"10.1 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path'),"11 scheme, authority and path test";
    todo "can't get trailing slashes to work yet";
#     ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path/'),"11.1 scheme, authority and path test (trailing slash)";
#    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/long/very/path/'),"11.1 scheme, authority and path test (trailing slash)";

    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true'),"12 s,a,p, and query test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true;black=white;up=down'),"13 s,a,p, multi q test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true&black=white&up=down'),"14 s,a,p, multi q test";

    todo "can't get trailing delims to work yet";
    #ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true&black=white&up=down&'),"14 s,a,p, multi q test with trailing delim";

    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path#m1'),"15 s,a,p, and fragment test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true#m1'),"16 s,a,p,q and fragment test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true;black=white;up=down#m1'),"17 s,a,p, multi q and fragment test";

    ok urlParse("jdbc:mysql://1.1.1.1/path"),"7.1 double scheme, authority and path test";

    my $url='jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1';
    ok urlParse($url), "$url parses ok";

    my $m=urlParse($url);
    is ~$m.made<scheme>   , 'jdbc:mysql'   ,'testing <scheme>   is made correctly';
    is ~$m.made<userinfo> , 'user:password','testing <userinfo> is made correctly';
    is ~$m.made<host>     , 'localhost'    ,'testing <host>     is made correctly';
    is ~$m.made<port>     , '3306'         ,'testing <port>     is made correctly';
    is ~$m.made<path>     , '/pwc'         ,'testing <path>     is made correctly';
    is ~$m.made<query>    , 'profile=true' ,'testing <query>    is made correctly';
    is ~$m.made<fragment> , 'h1'           ,'testing <fragment> is made correctly';

    $m=urlParse("hTTp://eXample.com:80/path/");
    my $s=stringifyURL(normalise($m.made));
    is $s, "http://example.com/path/", "normalise case and port ok";

    $m=urlParse("hTTp://127.0.0.1:80/path/");
    $s=stringifyURL(normalise($m.made));
    is $s, "http://localhost/path/", "normalise dotted quad localhost";

    $s=stringifyURL(normalise(urlParse("hTTp://127.0.0.1:80/path/").made));
    is $s, "http://localhost/path/", "normalise dotted quad localhost";

    is normalise_dotted_quad({host => "127.0.0.1"})<host>,"localhost","normalise d q localhost";
    is normalise_dotted_quad({host => "not dotted quad"})<host>,"not dotted quad","normalise d q not dotted quad";
    is normalise_dotted_quad({host => "8.8.8.8.8"})<host>,"8.8.8.8.8","normalise d q not dotted quad 2";
    is normalise_dotted_quad({host => "8.8.8.8"})<host>,"dns.google","normalise d q not nslookup ok";

    $s=stringifyURL(normalise(urlParse("hTTp://8.8.8.8:80/path/").made));
    is $s, "http://dns.google/path/", "normalise dotted quad localhost";
    is normalise_percent_encoding("abc%3aabc"),"abc%3Aabc","percent encoding - uppercasing";

    is normalise_percent_encoding("%41"),"A","unreserved words reduced";
    is normalise_percent_encoding("%63"),"c","unreserved words reduced";
    is normalise_percent_encoding("%7b"),'%7B',"reserved words ignored";


    is normalise_path_segment(normalise_percent_encoding("//a/./b/../b/%63/%7bfoo%7d")),"//a/b/c/%7Bfoo%7D", "normalise path segment";
    is normalise_path_segment(normalise_percent_encoding("/../c/d/../../a/b/../b/c")),"/a/b/c", "normalise path segment";

    # WIKIPEDIA TESTS - NORMALIZATIONS THAT PRESERVE SEMANTICS
    is normalise_URL("HTTP://www.Example.com/"),"http://www.example.com/","Converting the scheme and host to lower case.";

    is normalise_URL("http://www.example.com/a%c2%b1b"),"http://www.example.com/a%C2%B1b", "Capitalizing letters in escape sequences.";
    # All letters within a percent-encoding triplet (e.g., "%3A") are case-insensitive, and should be capitalized.

    is normalise_URL("http://www.example.com/%7Eusername/"),"http://www.example.com/~username/", "Decoding percent-encoded octets of unreserved characters.";
    # For consistency, percent-encoded octets in the ranges of ALPHA (%41–%5A and %61–%7A), DIGIT (%30–%39), hyphen (%2D), period (%2E), underscore (%5F), or tilde (%7E) should not be created by URI producers and, when found in a URI, should be decoded to their corresponding unreserved characters by URI normalizers.[2] Example:

    is normalise_URL("http://www.example.com:80/bar.html"),"http://www.example.com/bar.html","Removing the default port.";
    # The default port (port 80 for the “http” scheme) may be removed from (or added to) a URL. Example:

    # WIKIPEDIA TESTS - NORMALIZATIONS THAT **USUALLY** PRESERVE SEMANTICS
    is normalise_URL("http://www.example.com/../a/b/../c/./d.html"),"http://www.example.com/a/c/d.html", "Removing dot-segments. The segments";
    # “..” and “.” can be removed from a URL according to the algorithm described in RFC 3986 (or a similar algorithm). Example:

    done-testing;
}

my regex unreserved   { <[ A..Z a..z 0..9 _ \- \. ~]> };

grammar URL {
    token TOP {
        <scheme>
        <authority>?
        <path>?
        <query>?
        <fragment>?
    }
    # A non-empty scheme component followed by a colon (:), consisting of a sequence of characters beginning with a letter and followed by any combination of letters, digits, plus (+), period (.), or hyphen (-)
    token allowedchars {
        <alnum> |  '+' | '.' | '-' # does alpha include _? does Alnum?
    }
    token scheme_text {
        <alpha>  <allowedchars>*
    }
    token scheme {
       #| <scheme_text>
       [ <scheme_text> ':' ] ** 1..2
       #| <scheme_text> ':' <scheme_text>
    }
    #A path component, consisting of a sequence of path segments separated by a slash (/). A path is always defined for a URI, though the defined path may be empty (zero length). A segment may also be empty, resulting in two consecutive slashes (//) in the path component. A path component may resemble or map exactly to a file system path, but does not always imply a relation to one. If an authority component is present, then the path component must either be empty or begin with a slash (/). If an authority component is absent, then the path cannot begin with an empty segment, that is with two slashes (//), as the following characters would be interpreted as an authority component.[18] The final segment of the path may be referred to as a 'slug'.
    token authority {
        '//'
        <userinfo>?
        <host>
        [':' <port>]?
    }
    token slug {
        <alnum> | '_' | '-' | '.' | '~' | '%'
    }
    token slash {
        '/'
    }
    token userinfo {
        | <alnum>+ '@'
        | <alnum>+ ':' <alnum>+ '@'
    }
    token host {
        <alnum>+ ['.' <alnum>+]*
    }
    token port {
        <digit>+
    }
    token path {
        | <slash> [ <slug>+ <slash> ]* <slug>+ <slash>?
        | <slash>  <slug>+ <slash>?
        | <slash>
    }
    # An optional query component preceded by a question mark (?), containing a query string of non-hierarchical data. Its syntax is not well defined, but by convention is most often a sequence of attribute–value pairs separated by a delimiter. (& or ;)
    token query {
        '?' [<attrib-value> <delim>]* <attrib-value> <delim>?
    }
    token attrib-value {
        <slug>+ '=' <slug>+
    }
    token delim {
        ';' | '&'
    }
    token fragment {
        '#' <slug>+
    }
}

class URL-actions {
    method TOP ($/) {
        make {
            scheme =>   $<scheme>.subst(/\: $$/,""),
            userinfo => $<authority><userinfo>.subst(/\@/,""),
            host     => $<authority><host>.Str,
            port     => $<authority><port>.Str,
            path     => $<path>.Str,
            query    => $<query>.subst(/^^  '?' /,""),
            fragment => $<fragment>.subst(/^^  '#' /,""),
        }
    }
}

sub urlParse($url) {
    my $m=quietly URL.parse($url, actions => URL-actions.new);
    die "parse failed on [$url]" unless $m;
    return $m;
}

sub normalise ($m) {
    my %url = $m.kv;# normalise case
    %url<scheme> =  $m<scheme>.lc;
    %url<host> =    $m<host>.lc;

    %url =          normalise_default_port(%url);

    %url =          normalise_dotted_quad(%url);

    %url<path> =    normalise_percent_encoding(%url<path>);
    %url<query> =   normalise_percent_encoding(%url<query>);
    %url<fragment>= normalise_percent_encoding(%url<fragment>);

    %url<path> =    normalise_path_segment(%url<path>);
    return %url;
}

sub normalise_default_port(%url) {
    my %sp =    "http" => 80,
                "ipp" => 631,
                "ssh" => 22,
                "ftp" => 23,
                "https" => 443,
    ;
    %url<port> = "" if %sp{%url<scheme>}==%url<port>;
    return %url;
};

sub normalise_dotted_quad(%url) {
    %url<host> = "localhost" if %url<host> eq "127.0.0.1";
    return %url unless %url<host> ~~ /^ \d+ \. \d+ \. \d+ \. \d+ $/;
    my $shell = qq:x/nslookup %url<host>/.lines[0];    #:
    $shell ~~ m/^ .* 'name' \s '=' \s (.*) \. $/;
    %url<host> = $0;
    return %url;
};

sub normalise_percent_encoding($s is copy) {
    #  reserved  = ! ALPHA / DIGIT / "-" / "." / "_" / "~"
    $s ~~ s:g/ (\% \w \w) /&percent_encoding_unreserve($0)/; #
    return $s;
}

sub normalise_path_segment($p is copy) {
    # regex remove /./ => /
    $p ~~ s:g! \/ \. \/ !/!;

    # regex remove /c/../b/ => /b/ - repeat this to remove /../../
    while $p ~~ s:g! \/ \w+ \/ \. \. \/ !/! {} ;

    # remove any leading double dots
    $p ~~ s:g! ^ \/  \. \.  \/ !/!;

    return $p
}

sub percent_encoding_unreserve($s) {
    my $per = $s.uc;
    # decode
    my $c = chr(:16($per.substr(1,2)));
    $c = $per if $c !~~ m/<unreserved>/ ;
    return $c;
}

sub stringifyURL($m) {
    my $s= $m<scheme> ~"://";
    $s~= $m<userinfo> ~ "@" if $m<userinfo>;
    $s~= $m<host>;
    $s~= ":" ~ $m<port>     if $m<port>;
    $s~= $m<path>;
    $s~= "?" ~ $m<query>    if $m<query>;
    $s~= "#" ~ $m<fragment> if $m<fragment>;
    return $s;
}

sub normalise_URL($url) {
    return stringifyURL(normalise(urlParse($url).made));
}
