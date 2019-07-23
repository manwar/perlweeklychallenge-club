#!/usr/bin/perl6
use v6;

use Test;
# use Grammar::Tracer;

# Create a script to parse URL and print the components of URL. According to Wiki page, the URL syntax is as below:
#
# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]
#
# For example: jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
#
#   scheme:   jdbc:mysql
#   userinfo: user:password
#   host:     localhost
#   port:     3306
#   path:     /pwc
#   query:    profile=true
#   fragment: h1

#| URL parse validator
multi MAIN( $url ) {
    my $m=urlParse($url);
    say "$_ => {$m.made{$_}}" for  $m.made.keys;
}

#| Run tests
multi MAIN ( "test" ) {

    ok urlParse("http:/a/path"),"1 scheme and path test";
    ok urlParse("http:/path"),"2 scheme and path test";

    ok urlParse("http://localhost/path"),"3 scheme, authority and path test";
    ok urlParse("http://example.com/path"),"4 scheme, authority and path test";
    ok urlParse("http://example.co.uk/path"),"5 scheme, authority and path test";
    ok urlParse("http://example.co.uk:1234/path"),"6 scheme, authority and path test";
    ok urlParse("http://1.1.1.1/path"),"7 scheme, authority and path test";
    ok urlParse('http://kevin@example.co.uk/path'),"8 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk/path'),"9 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/path'),"10 scheme, authority and path test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path'),"11 scheme, authority and path test";

    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true'),"12 s,a,p, and query test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true;black=white;up=down'),"13 s,a,p, multi q test";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true&black=white&up=down'),"14 s,a,p, multi q test";

    todo "can't get trailing delims to work yet";
    ok urlParse('http://kevin:mypasword@example.co.uk:1234/a/path?profile=true&black=white&up=down&'),"14 s,a,p, multi q test with trailing delim";

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

    done-testing;
}


# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

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
        <alnum>+
    }
    token userinfo {
        | <slug> '@'
        | <slug> ':' <slug> '@'
    }
    token host {
        <slug> ['.' <slug>]*
    }
    token port {
        <digit>+
    }
    token path {
        | '/' [ <slug> '/' '/'? ]+ <slug>
        | '/' <slug>
    }
    # An optional query component preceded by a question mark (?), containing a query string of non-hierarchical data. Its syntax is not well defined, but by convention is most often a sequence of attribute–value pairs separated by a delimiter. (& or ;)
    token query {
#         | '?' <attrib-value>
     #   | '?' <attrib-value> 1..* % <delim>
        | '?' [<attrib-value> <delim>]* <attrib-value>
    }
    token attrib-value {
        <slug> '=' <slug>
    }
    token delim {
        ';' | '&'
    }
    token fragment {
        '#' <slug>
    }
}

class URL-actions {

    method TOP ($/) {
        make {
            scheme =>   $<scheme>.subst(/\: $$/,""),
            userinfo => $<authority><userinfo>.subst(/\@/,""),
            host     => $<authority><host>,
            port     => $<authority><port>,
            path     => $<path>,
            query    => $<query>.subst(/^^  '?' /,""),
            fragment => $<fragment>.subst(/^^  '#' /,""),
        }
    }

}

sub urlParse($url) {

    my $m=URL.parse($url, actions => URL-actions.new);

    # $m ?? "OK $url" !! "NOT OK $url";
    return $m;
}


