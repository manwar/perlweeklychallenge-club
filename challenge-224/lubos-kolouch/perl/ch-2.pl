#!/usr/bin/perl
use strict;
use warnings;

sub is_additive {
    my ($str) = @_;
    my $n = length($str);

    for my $i ( 1 .. $n / 2 ) {

        # Ensure first number doesn't start with a '0'
        next if ( $str =~ m/^0/ && $i > 1 );
        for my $j ( 1 .. ( $n - $i ) / 2 ) {

            # Ensure second number doesn't start with a '0'
            next if ( $str =~ m/^.$j\d/ && $j > 1 );
            if ( check_sequence( $str, $i, $j ) ) {
                return 1;
            }
        }
    }

    return 0;
}

sub check_sequence {
    my ( $str, $i, $j ) = @_;
    my $n      = length($str);
    my $first  = substr( $str, 0,  $i );
    my $second = substr( $str, $i, $j );

    for ( my $k = $i + $j ; $k < $n ; ) {
        my $next   = $first + $second;
        my $next_s = "$next";
        my $len    = length($next_s);

        if ( $k + $len <= $n && $next_s eq substr( $str, $k, $len ) ) {
            $first  = $second;
            $second = $next;
            $k += $len;
        }
        else {
            return 0;
        }
    }

    return 1;
}

# Test cases
print is_additive('112358')    ? "true\n" : "false\n";
print is_additive('12345')     ? "true\n" : "false\n";
print is_additive('199100199') ? "true\n" : "false\n";
