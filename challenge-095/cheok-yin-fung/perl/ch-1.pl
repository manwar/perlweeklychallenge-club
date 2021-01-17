# The Weekly Challenge 095 Task 1 Palindrome Number
use strict;
use experimental 'switch';

sub check_pal {
    my $a = $_[0];
    my @digit = split //, $a;

    my $n = 1;
    for my $i (0..int (scalar @digit / 2) ) {
        if ($digit[$i] != $digit[-$i-1]) {$n = undef; last;}
    }

    if ($n) {return 1;} else {return 0;}
}


my $a = $ARGV[0];
my $verify = check_pal($ARGV[0]);

print $verify, "\n";

if ($verify == 1) {
    print $a." is the ".order($a).theth(order($a)). " palindrome.\n";
}

sub order {
    my $a = $_[0];
    my $o;
    if ((length $a) % 2 == 1) {
        my $p = ((length $a) - 1) / 2 ;
        my $hr = substr($a, 0, $p+1);
        $o = 2 * ("9" x $p)
            + ($hr - ("1" . ("0" x ($p)) )) + 1;
    } else {
        my $r = (length $a) / 2 ;
        my $temp = "9". "0" x ( (length $a)/2 - 1 );
        my $temp2 = ( "1". "0" x ( (length $a)/2 - 1 ) ) - 1;
        $o = "9" x ( (length $a)/2 - 1 );
        $o = 2*$o + $temp - $temp2 + substr($a, 0, $r) ;
    }

    $o += 1;   # include "0" in the counting.
    return $o;
}


sub theth {
    my $th;
    my $x = $_[0];
    given( $x ) {
        when(/11$/) {$th = "th";}
        when(/12$/) {$th = "th";}
        when(/13$/) {$th = "th";}
        when( /[0,2-9]*1$/) {$th = "st";}
        when( /[0,2-9]*2$/) {$th = "nd";}
        when( /[0,2-9]*3$/) {$th = "rd";}
        default {$th = "th";}
    }
    return $th;
}
