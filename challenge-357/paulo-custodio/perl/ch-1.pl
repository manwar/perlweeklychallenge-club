#!/usr/bin/env perl

# Perl Weekly Challenge 357 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-357/

use Modern::Perl;

@ARGV==1 or die "usage: $0 num\n";
say num_steps($ARGV[0]);

sub num_steps {
    my($num) = @_;
    return -1 if length($num) != 4;
    my $steps = 0;
    my %seen;
    while ($num != 6174) {
        my $n1 = join '', sort split //, $num;
        $n1 = "0" x (4 - length($n1)) . $n1;
        my $n2 = join '', reverse sort split //, $num;
        $n2 .= "0" x (4 - length($n2));
        ($n1, $n2) = sort {$a<=>$b} ($n1, $n2);
        $num = $n2-$n1;
        $steps++;
        return -1 if $seen{$num}++;
    }
    return $steps;
}
