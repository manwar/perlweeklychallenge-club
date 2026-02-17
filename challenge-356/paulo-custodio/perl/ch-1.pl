#!/usr/bin/env perl

use Modern::Perl;

sub kolakoski {
    my($n) = @_;
    my @seq = (1, 2, 2);
    my @count = (1, 2);
    for my $i (3 .. $n) {
        my $count = $seq[$i-1];
        my $num = 3 - $seq[-1];
        push @seq, ($num) x $count;
        push @count, $count;
    }
    return @count;
}

sub count_ones {
    my(@count) = @_;
    return scalar grep {$_==1} @count;
}

@ARGV==1 or die "Usage: $0 N\n";
my $N = 0+shift;
say count_ones(kolakoski($N));
