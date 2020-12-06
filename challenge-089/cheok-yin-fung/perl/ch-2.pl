#!/usr/bin/perl
# The Weekly Challenge 089
# Task 2: Magical Matrix
use strict;
use warnings;

my $number_of_ans = 0;
my ($a, $b, $c, $d, $e, $f, $g, $h, $i);


$e = 5;

for my $a (1..4, 6..9) {
    for my $b (1..4, 6..9) {
        next if $a == $b;
        my %nine;
        $i = 10-$a;
        $c = 15-$a-$b;
        $h = 10-$b;
        $g = 10-$c;
        $d = 15-$a-$g;
        $f = 15-$c-$i; 
        
        my @term = (\$a, \$b, \$c, \$d, \$e, \$f, \$g, \$h, \$i);
        $nine{$_} = 0 for (1..9);
        for (@term) {
            if ($$_ >= 1 and $$_ <= 9) {$nine{$$_}++;}
        }
        my $bool = 1;
        my $count = 1;
        while ($count <= 9 and $bool) {
            $bool = ($nine{$count} == 1);
            $count++;
        }
        print " $a $b $c \n $d $e $f\n $g $h $i\n\n" if $bool;
        $number_of_ans++ if $bool;
    }
}

print $number_of_ans, "\n";

=pod

# Task: Magic Cube
# Related to The Weekly Challenge 089
#            Task 2 Magical Matrix
# follow definition of magic cube on:
# https://en.wikipedia.org/w/index.php?title=Magic_cube&oldid=987317430
use strict;
use warnings;

my ($a, $b, $c, $d, $e, $f, $g, 
    $h, $i, $j, $k, $l, $m, $n, 
    $o, $p, $q, $r, $s, $t, $u, 
    $v, $w, $x, $y, $z, $X);

my $number_of_ans = 0;

$X = 14;
for $e (1..27) {
for $a (1..27) {
    for $b (1..27) {
        for $g (1..27) {
            $c = 42 - $a - $b;
            $z = 28 - $a;
            $x = 28 - $c;
            $y = 42 - $x - $z;
            $d = 42 - $a - $g;
            $t = 28 - $g;
            $w = 42 - $z - $t;
            $h = 42 - $e - $b;
            $p = 42 - $y - $h;
            $f = 42 - $d - $e;
            $i = 42 - $c - $f;
            $r = 28 - $i;
            $s = 42 - $t - $r;
            $v = 42 - $y - $s;
            $j = 42 - $a - $r;
            $l = 42 - $c - $t;
            $k = 42 - $j - $l;
            $q = 42 - $z - $i;
            $n = 42 - $l - $q;
            $m = 28 - $n;
            $o = 42 - $j - $m;
            $u = 42 - $v - $w;
            my @term = (\$a, \$b, \$c, \$d, \$e, \$f, \$g, 
                        \$h, \$i, \$j, \$k, \$l, \$m, \$n, 
                        \$o, \$p, \$q, \$r, \$s, \$t, \$u, 
                        \$v, \$w, \$x, \$y, \$z, \$X);
            my %cube;
            $cube{$_} = 0 for (1..27);
            for (@term) {
                if ($$_ >= 1 and $$_ <= 27) {$cube{$$_}++;}
            }
            my $bool = 1;
            my $count = 1;
            while ($count <= 27 and $bool) {
                $bool = ($cube{$count} == 1);
                $count++;
            }
            if ($bool) {
                print " $a $b $c \n $d $e $f\n $g $h $i\n\n";
                print " $j $k $l \n $m $X $n\n $o $p $q\n\n";
                print " $r $s $t \n $u $v $w\n $x $y $z\n\n\n";
                $number_of_ans++;
            } 
        }
    }
}}

print $number_of_ans, "\n";
=cut
