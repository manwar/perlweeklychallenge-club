#! /usr/bin/perl6

use Test;

plan 1;

is-deeply(ltruncprimes(20),[2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 113, 137, 167, 173, 197],'example 1');

sub ltruncprimes($count) {
    my @out;
    my $lt=0;
    my @p=genprimes(500);
    my %p=@p.SetHash;
    for @p -> $pc {
        my $l=chars($pc);
        my $c=True;
        for 1..$l-1 -> $i {
            unless (%p{substr($pc,$i,$l+1-$i)}:exists) {
                $c=False;
                last;
            }
        }
        if ($c) {
            push @out,$pc;
            $lt++;
            if ($lt >= $count) {
                last;
            }
        }
    }
    return @out;
}

sub genprimes($mx) {
    my @primes;
    {
        my $primesh=(2,3).SetHash;
        loop (my $i=6;$i <= $mx+1; $i += 6) {
            for ($i-1,$i+1) -> $j {
                if ($j <= $mx) {
                    $primesh{$j}=True;
                }
            }
        }
        my $p=2;
        my @q=[2,3,5,7];
        my $mr=floor(sqrt($mx));
        while ($p <= $mr) {
            if ($primesh{$p}:exists) {
                my $i=$p*$p;
                while ($i <= $mx) {
                    $primesh{$i}:delete;
                    $i += $p;
                }
            }
            if (@q.elems < 2) {
                @q.push(@q[*-1]+4);
                @q.push(@q[*-1]+2);
            }
            $p=@q.shift;
        }
        @primes=$primesh.keys.sort;
    }
    return @primes;
}
