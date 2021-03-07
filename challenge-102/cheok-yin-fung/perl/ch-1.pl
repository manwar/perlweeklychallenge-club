#!/usr/bin/perl
# The Weekly Challenge #102 Task 1 Rare Numbers
# Usage: ch-1.pl [number of digits]
use strict;
use warnings;

sub rvrse {
    my $r = $_[0];
    my $r1 = join "", reverse split //, $r;
    return $r1;
}

sub check_sq {
    return (sqrt $_[0]) =~ /^\d+$/;
}   

sub check_rare {
    my $r = $_[0];
    my $a = substr($r,0,1);
    my $q = substr($r,-1,1);
    return undef if $a % 2 == 1;  
    return undef if 
        $a == 2 
        && !( $q == 2   
              && substr($r,1,1) == substr($r,-2,1) );
    return undef if 
        $a == 4 && !($q == 0);
    return undef if
        $a == 6 && !($q == 0 || $q == 5);
    return undef if
        $a == 8 && !($q == 2 || $q == 3 || $q == 7 || $q == 8);
   # above: properties of rare number, as noted in website
   # http://www.shyamsundergupta.com/rare.htm

    my $r1 = rvrse $r;
    return undef if $r1 > $r;
    return check_sq($r+$r1) && check_sq($r-$r1);
}

my $N = $ARGV[0];

if ($N == 1) {
    print "2\n8\n";
    exit;
}

my $bN = "1" . "0" x ($N-1);
my $eN = "9" x $N;

for my $k ($bN..$eN) {
    print $k , "\n" if check_rare $k;
}

# PERFORMANCE COMMENT:
# reasonable time for length = 7 ,
# be patient for length = 8 (one term, which is palindromic)
# over 2 min and killed for length = 9 ...
