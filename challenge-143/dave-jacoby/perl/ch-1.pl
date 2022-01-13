#!/usr/bin/env perl

use strict;
use warnings;
use feature qw{ say state postderef signatures };
no warnings qw{ experimental };

my @examples;
push @examples, '( 5 * 10 )  - ( 12 * 3 )';
push @examples, '10 + 20 - 5';
push @examples, '(10 + 20 - 5) * 2';
push @examples, '( ( 10 * 20 ) - 5) * 2';

for my $i (@examples) {
    my $o  = calculator($i);
    my $o2 = bc($i);
    say <<"END";
    Input:  \$i = $i
    Output: $o
    BC:     $o2
END
}

sub calculator( $s) {

    # parens
    while ( $s =~ /\([\s\d\+\-\*]+\)/mix ) {
        $s =~ s/\(([\s\d\+\-\*]+\))/calculator( unbracket( $1 ))/e;
    }

    # multiplication

    while ( $s =~ / \d+ \s* \* \s* \d+ /mx ) {
        $s =~ s/( (\d+) \s* \* \s* (\d+) )/ $2 * $3 /emx;
    }

    # addition

    while ( $s =~ / \d+ \s* \+ \s* \d+ /mx ) {
        $s =~ s/( (\d+) \s* \+ \s* (\d+) )/ $2 + $3 /emx;
    }

    # subtraction
    while ( $s =~ / \d+ \s* \- \s* \d+ /mx ) {
        $s =~ s/( (\d+) \s* \- \s* (\d+) )/ $2 - $3 /emx;
    }
    return $s;
}

sub unbracket( $s ) {
    $s =~ s/^\(//;
    $s =~ s/\)$//;
    return $s;
}

# This is the easy way, using pre-existing code
sub bc( $s) {
    my $cmd = qq{ echo '$s' | bc  };
    my $x   = qx{$cmd};
    chomp $x;
    return $x;
}
