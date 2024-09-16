# The Weekly Challenge 283
# Task 2 Digit Count Value

use v5.30;
use warnings;
use Integer::Partition;
use List::Util qw/sum any all/;
use List::MoreUtils qw/occurrences/;

# The required subroutine is verify or verify_mechanical.
# It is shown that only 7 arrays satisfying the requirement 
#     from array size = 2 to 10.
# They are:
# 2020
# 1210
# 21200
# 3211000
# 42101000
# 521001000
# 6210001000

sub verify {
    my @x = @_;
    my $n = $#x+1;
    my @o = occurrences @x;
    my $bool = 1;
    for my $i (0..$#x) {
        $bool = 0 unless $x[$i]==0 || any {$_ == $i} $o[$x[$i]]->@*;
        last unless $bool;
    }
    return $bool;
}

sub verify_mechanical {
    my @x = @_;
    my %y;
    for my $i (0..$#x) {
        $y{$i}=0;
    }
    for my $i (0..$#x) {
        $y{$x[$i]}++;
    }
    return all {$y{$_} == $x[$_]} 0..$#x;
}

my @arr;
for my $n (2..10) {
    my $y = Integer::Partition->new($n);
    my $p = $y->next; # skip the first partition (trivial one-portion partition)
    while ($p = $y->next) {
        my @x = (0) x $n;
        my @o = occurrences @$p;
        for my $i (1..$#o) {
            for my $k ($o[$i]->@*) {
                $x[$k] = $i;
            }
        }
        for my $k (1..$#x) {
            $x[0]++ if $x[$k] == 0;
        }    
        push @arr,[@x] if verify(@x);
    }
}

use Data::Printer;
p @arr;

use Test::More tests=>4;
ok verify(1,2,1,0);
ok !verify(0,3,0);
ok verify_mechanical(1,2,1,0);
ok !verify_mechanical(0,3,0);
