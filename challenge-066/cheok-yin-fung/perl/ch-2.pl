#!/usr/bin/perl
#
#applicable for positive integers from 1 to 1_000_000
use strict;

my @primes = (2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97, 101, 103, 107, 109, 113, 127, 131, 137, 139, 149, 151, 157, 163, 167, 173, 179, 181, 191, 193, 197, 199, 211, 223, 227, 229, 233, 239, 241, 251, 257, 263, 269, 271, 277, 281, 283, 293, 307, 311, 313, 317, 331, 337, 347, 349, 353, 359, 367, 373, 379, 383, 389, 397, 401, 409, 419, 421, 431, 433, 439, 443, 449, 457, 461, 463, 467, 479, 487, 491, 499, 503, 509, 521, 523, 541, 547, 557, 563, 569, 571, 577, 587, 593, 599, 601, 607, 613, 617, 619, 631, 641, 643, 647, 653, 659, 661, 673, 677, 683, 691, 701, 709, 719, 727, 733, 739, 743, 751, 757, 761, 769, 773, 787, 797, 809, 811, 821, 823, 827, 829, 839, 853, 857, 859, 863, 877, 881, 883, 887, 907, 911, 919, 929, 937, 941, 947, 953, 967, 971, 977, 983, 991, 997, 1009);

sub endgame {
    print -1, "\n";
    exit;
}


sub gcd {
    if ($_[1] == 0) {return $_[0];}
    my ($a,$b) = ($_[0],$_[1]);
    while ($a > $b) {
        $a = $a - $b;
    }
    if ($a == $b) {
        return $a;
    } 
    else {
        return gcd($a , $b % $a);
    }
}

sub mydiv {
    my ($divident, $divisor) = ($_[0], $_[1]);
    my $q = 0;
    while ($divident >= $divisor) {
        $divident -= $divisor;
        $q++;
    }
    my $remainder = $divident;
    return ($q, $remainder);
}

sub lookup { 
    my $william = $_[0];
    my $pindex = $_[1];
    while ($primes[$pindex] > int sqrt $william and
              ($william % $primes[$pindex] != 0 )) {
        $pindex--;
    }
    my @a = mydiv( $william, $primes[$pindex]);
    if ($a[1] == 0 and $a[0] < int sqrt $william ) {
        endgame;
    }
    while ($a[1] != 0 and $pindex>0) {
        $pindex--;
        @a = mydiv($william, $primes[$pindex]);
    }

    if ($pindex == 0) {@a = mydiv($william,2);}

    if ($a[1] == 0) {
        my $b = 1;
        @a = mydiv($a[0], $primes[$pindex]);
        while ($a[1] == 0) {
            $b++;
            @a = mydiv($a[0], $primes[$pindex]);
        }
        return ($primes[$pindex],$b, $pindex);
    }
    elsif ($a[1] != 0) {
        endgame;
    } 
}


sub nroot {
    my $r = $_[0];
    my $nth = $_[1];
    return exp((log $r)/$nth);
}

sub main {
    my ($william, $bill, $power, $primecounter) = ($_[0], $_[1], $_[2], $_[3]);
    #    print join " ", "main: ", $william, $bill, $power, $primecounter, "\n";

    my @pf = lookup($william, $primecounter);
    
    my $newpower = gcd($pf[1],$power);

    if ($newpower == 1) {
        endgame;
    }
    else {
        my $ex = $pf[0]**$pf[1];
        $bill *= $ex;
        $william /= $ex;
        if ($william == 1) {
            print "ANSWER FOUND\n";
            print nroot($bill,$newpower), "**", $newpower, "\n";
            exit;
        } else { 
            return main($william, $bill, $newpower,$pf[2]-1);
        }
    }
}

if ($ARGV[0] == 1) {endgame;}
my @temp = lookup($ARGV[0], $#primes);
print "\n";
my $firstpower = $temp[0]**$temp[1];
my $firstq = $ARGV[0]/$firstpower;
if ($firstq != 1) {
    print join " ", main($firstq, $firstpower , $temp[1], $temp[2]-1); 
} else {
    if ($temp[1] != 1) {
         print $temp[0], "**", $temp[1];
    } else {
        endgame;
    }
}
print "\n";



=pod  #ch-2a.pl   
my $N = $ARGV[0];
my $h = 2;
if ($N == 1) {print -1, "\n"; exit;}
for $a (reverse 2..int sqrt $N) {
    if ($N == $a**$h) {print "$a**$h\n"; exit;}
    if ($a**$h <= $N-1) {$h++;}
}

print -1, "\n";

# a lot faster, but have bugs: 
#   input: 128  output: -1
=cut
