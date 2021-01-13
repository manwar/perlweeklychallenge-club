#!/usr/bin/perl
# Perl Weekly Challenge #075 Task 1 Coins Sum
# task statement: 
# You are given a set of coins @C, assuming you have 
# infinite amount of each coin in the set.
# Write a script to find how many ways you make 
# sum $S using the coins from the set @C.
# Usage: ch-1a.pl $S @C
use strict;
use warnings;
#use Test::More tests => 3;
use Integer::Partition;

sub okcoins {
    my @coins = @{$_[0]};
    my @partition = @{$_[1]};
    my $ans = 1;
    my $psize = scalar @partition;
    my %ecoins;
    for (@coins) {
        $ecoins{$_} = 1;
    }
    my $i = 0;
    while ($ans &&  ($i < $psize)) {
        $ans = $ans && exists $ecoins{$partition[$i]};
        $i++;
    }
    return $ans; 
}

sub main {
    my ($sum, @coins) = @_;
    my @out = ();
    my $objIP = Integer::Partition->new($sum , {lexicographic => 1});
    while (my $p = $objIP->next) {
        my @p_order = reverse @$p;
        if (okcoins(\@coins, \@p_order)) {
            push @out, \@p_order;
            print join ' ', @p_order;
            print "\n";
        }
    }
    print "\n";
    return scalar @out;
}

my $S;
my @C;

if ($ARGV[1]) {$S = shift @ARGV; @C = @ARGV;} else {$S = 3; @C = (1,2);}

print "total number of ways: ", main($S, @C);
print "\n";

=pod
ok main(6, 1, 2, 4) == 6, "test 1";
ok main(5, 1, 2, 3, 5) == 6, "test 2";
ok main(5, 1, 2, 3, 4, 5) == 7, "test 3";
=cut
