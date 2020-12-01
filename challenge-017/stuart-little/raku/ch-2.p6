#!/usr/bin/env perl6
use v6;

grammar URL {
    regex TOP { <scheme>':'(\/\/<authority>)?<path>(\?<query>)?('#'<fragment>)? }
    regex scheme { .+? }
    
    regex authority { (<userinfo>'@')?<host>(':'<port>)? }
    regex userinfo { .+ }
    regex host { <-[:]>+ }
    regex port { \d+ }
    
    regex path { <-[?]>* }
    regex query { .+? }
    regex fragment { .+ }
}

URL.parse(@*ARGS[0]);
my $res = qq:to/END/;

scheme: $/.<scheme>	   
userinfo: $/.[0].<authority>.[0].<userinfo>
host: $/.[0].<authority>.<host>
port: $/.[0].<authority>.[1].<port>	     
path: $/.<path>
query: $/.[1].<query>
fragment: $/.[2].<fragment>
END
say $res;

# run as <script> <string to validate as URL>
