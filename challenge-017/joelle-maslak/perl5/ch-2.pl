#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use Parse::RecDescent 1.511;

my $urlparser = Parse::RecDescent->new(q{
    TOP       :
        <skip:''>
        scheme authority(?) path ('?' query)(?) ('#' fragment)(?)
        {
            {
                scheme   => $item[2],
                userinfo => $item[3][0]{'userinfo'},
                host     => $item[3][0]{'host'},
                port     => $item[3][0]{'port'},
                path     => $item[4],
                query    => $item[5][0],
                fragment => $item[6][0],
            }
        }
    scheme    : /[A-Za-z]+ [A-Za-z\.\+\- ]+/x ':' { $item[1] }

    authority : '//' userinfo(?) host (':' port)(?)
        { { userinfo => $item[2][0], host => $item[3], port => $item[4][0] } }

    userinfo  : username ':' password '@' { $item[1] . $item[2] . $item[3] }

    path      : /( \/ [^\s\?\#]* )?/x

    query     : /[^\s\#]*/

    fragment  : /[^\s]*/

    host      : /[^\s\:\?\/\#]+/
    port      : /[^\s\?\/\#]+/ 
    username  : /[^\s\:]+/
    password  : /[^\s\@]*/
});

MAIN: {
    die "Usage: $0 <url>" if @ARGV != 1;

    my $url = $ARGV[0];
    my $parse = $urlparser->TOP(\$url);
    if (($url ne '') or (!defined $parse)) {
        say "Invalid URL";
        exit;
    }
    
    say "Scheme:   " . ($parse->{scheme}   // '<not defined>');
    say "Userinfo: " . ($parse->{userinfo} // '<not defined>');
    say "Host:     " . ($parse->{host}     // '<not defined>');
    say "Port:     " . ($parse->{port}     // '<not defined>');
    say "Path:     " . ($parse->{path}     // '<not defined>');
    say "Query:    " . ($parse->{query}    // '<not defined>');
    say "Fragment: " . ($parse->{fragment} // '<not defined>');
}

