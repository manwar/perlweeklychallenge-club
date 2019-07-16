#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Create a script to parse URL and print the components of URL.
# According to Wiki page, the URL syntax is as below:

# scheme:[//[userinfo@]host[:port]]path[?query][#fragment]

my @list;
push @list, 'ftp://ftp.cerias.purdue.edu/pub/dict/README.txt';
push @list, 'http://slashdot.org/';
push @list, 'https://en.wikipedia.org/wiki/URL';
push @list, 'https://github.com/manwar/perlweeklychallenge-club/pulse';
push @list, 'https://mail.google.com/mail/u/0/#inbox/FMfcg';
push @list, 'https://perlweeklychallenge.org/blog/perl-weekly-challenge-017/';
push @list, 'https://practimer.me:443/#5m0s';
push @list, 'https://www.perlmonks.org/?node_id=818843';
push @list, 'jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1';

@list = @ARGV if scalar @ARGV; # replace test list if anything is entered

# by the URL definition on wikipedia, jdbc:mysql is not a valid scheme
# and the scheme contains a trailing colon.

# Notes on implementation:
# + this is VERY ascii-centric code, and unicode and emoji are allowed
#   in URLs. Take, for example, i❤️tacos.ws
# + schemas and TLDs are constrained, not just to ascii, but to a small
#   (but larger than before) list. Yeah, you can override this with your
#   hosts file, but otherwise, all URLs should end (case-insensitive)
#   with a string in this list: 
#       http://data.iana.org/TLD/tlds-alpha-by-domain.txt
# + similarly, the lists for path and query are limited to values
#   fitting my dataset. There have been path separator bugs: IE
#   would count \ as a separator, while Mozilla would not, so 
#   you could hide information from Windows browsers /with\this\path

# So, this is a very naive implementation, needing more work before  
# it can be trusted with real-world URLs. So, except when it's done
# for fun, like here, use something like Mojo::URL to split it up
# for you https://metacpan.org/pod/Mojo::URL

for my $url ( sort @list ) {
    my ( $scheme, $userinfo, $host, $port, $path, $query, $fragment ) =
        $url =~ m{
        ^
        (\w[A-Za-z0-9\+\.\-\:]+)://   # schema
        (?:([^@]+)@)?                 # userinfo
        ([\w\.]+)                     # host
        (?:\:(\d+))?                  # port
        (/[\w/\+\.\-]*)               # path
        (?:\?([\w/\+\.\-\=]+))?       # query
        (?:\#([^#]+))?                # fragment
        $
        }mxis;
    $scheme   //= '';
    $userinfo //= '';
    $host     //= '';
    $port     //= '';
    $path     //= '';
    $query    //= '';
    $fragment //= '';

    say <<"END";
    URL         $url
    scheme      $scheme
    userinfo    $userinfo
    host        $host
    port        $port
    path        $path
    query       $query
    fragment    $fragment
END
}

__DATA__

    URL         ftp://ftp.cerias.purdue.edu/pub/dict/README.txt
    scheme      ftp
    userinfo    
    host        ftp.cerias.purdue.edu
    port        
    path        /pub/dict/README.txt
    query       
    fragment    

    URL         http://slashdot.org/
    scheme      http
    userinfo    
    host        slashdot.org
    port        
    path        /
    query       
    fragment    

    URL         https://en.wikipedia.org/wiki/URL
    scheme      https
    userinfo    
    host        en.wikipedia.org
    port        
    path        /wiki/URL
    query       
    fragment    

    URL         https://github.com/manwar/perlweeklychallenge-club/pulse
    scheme      https
    userinfo    
    host        github.com
    port        
    path        /manwar/perlweeklychallenge-club/pulse
    query       
    fragment    

    URL         https://mail.google.com/mail/u/0/#inbox/FMfcg
    scheme      https
    userinfo    
    host        mail.google.com
    port        
    path        /mail/u/0/
    query       
    fragment    inbox/FMfcg

    URL         https://perlweeklychallenge.org/blog/perl-weekly-challenge-017/
    scheme      https
    userinfo    
    host        perlweeklychallenge.org
    port        
    path        /blog/perl-weekly-challenge-017/
    query       
    fragment    

    URL         https://practimer.me:443/#5m0s
    scheme      https
    userinfo    
    host        practimer.me
    port        443
    path        /
    query       
    fragment    5m0s

    URL         https://www.perlmonks.org/?node_id=818843
    scheme      https
    userinfo    
    host        www.perlmonks.org
    port        
    path        /
    query       node_id=818843
    fragment    

    URL         jdbc:mysql://user:password@localhost:3306/pwc?profile=true#h1
    scheme      jdbc:mysql
    userinfo    user:password
    host        localhost
    port        3306
    path        /pwc
    query       profile=true
    fragment    h1

