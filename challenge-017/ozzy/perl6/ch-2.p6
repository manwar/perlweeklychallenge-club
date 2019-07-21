#!/usr/bin/env perl6
#
# Destructuring a URI
#   URI = scheme:[//authority]path[?query][#fragment]
#   authority = [userinfo@]host[:port]

grammar G {

    regex TOP { ^ <scheme> ':' ['//' <authority>]? <path> ['?' <query>]? ['#' <fragment>]? $ }

    token scheme    { <+alpha-[_]> <[\w \+ \. \-]>+          }

    token authority { [<userinfo> '@']? <host> [':' <port>]? }
    token userinfo  {  <user> [':' <password>]?              }
    token user      { \w+           }
    token password  { \w*           }
    token host      { <[\w\.\[\]]>+ }
    token port      { \d+           }

    token path      { [ '/' \w+ ]+  }
    token query     { <[=\w]>+      }
    token fragment  { \w+           }
}

say G.parse: 'jdbc://user:password@localhost:3306/pwc?profile=true#h1';
