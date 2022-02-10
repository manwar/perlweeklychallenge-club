#! /usr/bin/perl6

use Test;
plan 2;

is(mindepth(str2tree("1 | 2 3 | 4 5")),2,'example 1');

is(mindepth(str2tree("1 | 2 3 | 4 *  * 5 | * 6")),3,'example 2');

sub str2tree($st) {
    my @o;
    my $d=0;
    my $p=0;
    for $st.words -> $e {
        if ($e eq '|') {
            $d++;
            $p=0;
            my $m=(1 +< ($d+1))-1;
            if (@o.elems < $m) {
                @o.append(0 x ($m - @o.elems));
            }
        } else {
            my $y=0;
            if ($e ne '*') {
                $y=0+$e;
            }
            my $i=(1 +< $d) -1 +$p;
            @o[$i]=$y;
            $p++;
        }
    }
    return @o;
}

sub mindepth(@tree) {
    my $firstleaf=@tree.elems;
    for @tree.kv -> $i,$e {
        if ($e==0) {
            next;
        } elsif (($i+1) +< 1 >= @tree.elems) {
            $firstleaf=$i;
            last;
        } else {
            my $ni=(($i+1) +< 1)-1;
            if (@tree[$ni]==0 && @tree[$ni+1]==0) {
                $firstleaf=$i;
                last;
            }
        }
    }
    my $t=$firstleaf+1;
    my $d=0;
    while ($t > 0) {
        $t +>= 1;
        $d++;
    }
    return $d;
}
