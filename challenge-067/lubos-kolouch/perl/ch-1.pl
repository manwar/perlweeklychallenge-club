#!/usr/bin/perl
use strict;
use warnings;

sub combinations {
    my ($m, $n) = @_;
    my @result;
    
    my $rec_comb;
    $rec_comb = sub {
        my ($start, $depth, @comb) = @_;
        if ($depth == 0) {
            push @result, [@comb];
            return;
        }
        for my $i ($start..$m) {
            $rec_comb->($i + 1, $depth - 1, @comb, $i);
        }
    };

    $rec_comb->(1, $n);
    return \@result;
}

my ($m, $n) = (5, 2);
my $combinations = combinations($m, $n);
print "[ ", join(", ", map { "[" . join(",", @$_) . "]" } @$combinations), " ]\n";

