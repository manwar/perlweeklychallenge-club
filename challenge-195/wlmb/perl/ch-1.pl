#!/usr/bin/env perl
# Perl weekly challenge 195
# Task 1:  Special Integers
#
# See https://wlmb.github.io/2022/12/12/PWC195/#task-1-special-integers
use v5.36;
use integer;
use POSIX qw(lround);
say(<<"FIN"), exit unless @ARGV;
Usage: $0 N1 [N2...]
to get the number of special numbers between 1 and Ni
FIN
say "$_->", special($_) for @ARGV;
sub fact($n){ # factorial
    my $r=1;
    $r*=$_ for (1..$n);
    $r
}
sub special($n){
    my $k=0;
    my $count=0;
    while($k<=9 && 10**($k+1) < $n){
        # Count from 1 to 9, then from 10 to 99, then from 100 to 999, etc.
        $count += 9*fact(9)/fact(9-$k);
        ++$k;
    }
    return $count if $k>9; # Nothing else to do eleven digit numbers or larger
    #Count from 100.. to q00..-1
    my $q=lround($n/10**$k);
    $count += ($q-1)*fact(9)/fact(9-$k);
    $count += final($q, $k-1, $n); # count from q00... upto $n=qxy...
    return $count;
}
sub final($left, $power, $n){ # final approach from left 0 0 0 to n=x y z
    my $count=0;
    my $fixed=length $left; # leftward fixed digits
    my %fixed;
    ++$fixed{$_} for my @fixed=split '', $left; # actual fixed digits.
    $_>1 && return 0 for(values %fixed); # nothing to add if fixed part is not special
    return 1 if $power < 0; # Found last string
    my $target=substr($n, $fixed, 1); # Next digit
    for(0..$target-1){ # count upwards to target
        next if $fixed{$_}; # skip seen digits
        $count += fact(9-$fixed)/fact(9-$fixed-$power); # add rightwards contribution
    }
    $count += final($left.$target, $power-1, $n); # add digit to leftmost and recurse.
    return $count;
}
