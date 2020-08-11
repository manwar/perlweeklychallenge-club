#!/usr/bin/env perl
use v5.22;
use strict;
use warnings;

# We only do the operations gauranteed to preserve semantics.

# Turn on method signatures
use feature 'signatures';
no warnings 'experimental::signatures';

use Parse::RecDescent 1.511;

my $urlparser = Parse::RecDescent->new(
    q{
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
}
);

MAIN: {
    die "Usage: $0 <url>" if @ARGV != 1;

    my $url   = $ARGV[0];
    my $parse = $urlparser->TOP( \$url );
    die "Invalid URL" if ( ( $url ne '' ) or ( !defined $parse ) );

    my $str = lc( $parse->{scheme} ) . ':';

    $str .= '//'                                   if defined $parse->{host};
    $str .= $parse->{userinfo}                     if defined $parse->{userinfo};
    $str .= normalize_percent( lc $parse->{host} ) if defined $parse->{host};

    if ( lc( $parse->{scheme} ) eq 'http' and defined $parse->{port} ) {
        $str .= ':' . $parse->{port} if $parse->{port} != 80;
    } elsif ( lc( $parse->{scheme} ) eq 'https' and defined $parse->{port} ) {
        $str .= ':' . $parse->{port} if $parse->{port} != 443;
    } elsif ( defined $parse->{port} ) {
        $str .= ':' . $parse->{port};
    }

    $str .= normalize_percent( $parse->{path} )     if defined $parse->{path};
    $str .= normalize_percent( $parse->{query} )    if defined $parse->{query};
    $str .= normalize_percent( $parse->{fragment} ) if defined $parse->{fragment};

    say "Scheme:   " . ( $parse->{scheme}   // '<not defined>' );
    say "Userinfo: " . ( $parse->{userinfo} // '<not defined>' );
    say "Host:     " . ( $parse->{host}     // '<not defined>' );
    say "Port:     " . ( $parse->{port}     // '<not defined>' );
    say "Path:     " . ( $parse->{path}     // '<not defined>' );
    say "Query:    " . ( $parse->{query}    // '<not defined>' );
    say "Fragment: " . ( $parse->{fragment} // '<not defined>' );

    say $str;
}

sub normalize_percent($part) {
    my $remainder = $part;
    my $output    = '';

    while ( $remainder ne '' ) {
        my $beginning = $remainder;
        my $end       = $remainder;

        $beginning =~ s/([^%]*).*$/$1/;
        $end       =~ s/[^%]*//;

        $output .= $beginning;

        if ( $end ne '' ) {
            if ( $end !~ m/^\%[a-f0-9][a-f0-9]/i ) {
                say $end;
                die("Invalid percent_encoding");
            }
            my $encoding = hex( substr( $end, 1, 2 ) );
            if ( $encoding >= 0x41 and $encoding <= 0x5a ) {    # Upper case
                $output .= chr($encoding);
            } elsif ( $encoding >= 0x61 and $encoding <= 0x79 ) {    # Lower case
                $output .= chr($encoding);
            } elsif ( $encoding >= 0x30 and $encoding <= 0x39 ) {    # Digits
                $output .= chr($encoding);
            } elsif ( $encoding == 0x2d ) {                          # Hyphen
                $output .= chr($encoding);
            } elsif ( $encoding == 0x2e ) {                          # Period
                $output .= chr($encoding);
            } elsif ( $encoding == 0x5f ) {                          # Underscore
                $output .= chr($encoding);
            } elsif ( $encoding == 0x7e ) {                          # Tilde
                $output .= chr($encoding);
            } else {
                $output .= '%' . sprintf( "%02x", $encoding );
            }

            $remainder = substr( $end, 3 );
        } else {
            # No defined end
            $remainder = '';
        }
    }

    return $output;
}

