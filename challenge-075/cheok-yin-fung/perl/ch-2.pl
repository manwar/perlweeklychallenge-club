#!/usr/bin/perl
# Perl Weekly Challenge #075 Task 2 Largest Rectangle Histogram
# Usage: ch-2.pl [ARRAY]
#use Test::Simple tests=>2;
use List::Util qw/max/;
use strict;
use warnings;

my @A;

if (@ARGV) {@A = @ARGV;} else {@A = (3, 2, 3, 5, 7, 5);}

sub subtract1 {
    return map { $_ != 0 ? $_-1 : 0 } @_;
}

sub subtract_to_max {
    my @in = @{$_[0]};
    my $MAX_ = max @in;
    my @out = (\@in);
    my @temp = @in;
    for (1..$MAX_-1) {
        @temp = subtract1 @temp;
        my @newa = @temp;
        unshift @out, \@newa;
    }
    return @out;
}


sub print_A {
    my $MAX_ = max @A;
    my $i = $MAX_;
    for (subtract_to_max(\@A)) {
        my @in = @{$_};
        print "$i ";
        print join " ", map { $_ != 0 ? "#" : " "   } @in;
        print "\n";
        $i--;
    }
    print "_ " for @A;
    print "_ \n  ";
    print join " ", @A;
    print "\n";
}

sub lrh {
    my @histogram = subtract_to_max(\@_);
    my $length = scalar @_;
    my %areas;
    my $MAX_ = max @_;

    for my $i (0..$MAX_-1) {
        my $j = 0;
        my ($h, $t);                #head, tail
        while ($j < $length) {
            if ($histogram[$i][$j] != 0) {
                $h = $j;
                for (my $k=$j ; ($k < $length) && ($histogram[$i][$k] != 0) ;$k++) {
                    $t = $k;
                    $j++;
                }
            }
            if ( defined($h) && defined($t) && (!exists $areas{"$h,$t"}) ) {
                $areas{"$h,$t"} = ($t-$h+1)*($MAX_-$i);
            }
            $j++;
            
        }
    }

    return max values %areas;
}

print_A;
print "\n";
print lrh(@A);
print "\n";

=pod
ok ( lrh(2, 1, 4, 5, 3, 7)  == 12 ), "example 1" ;
ok ( lrh(3, 2, 3, 5, 7, 5)  == 15 ), "example 2" ;
=cut
