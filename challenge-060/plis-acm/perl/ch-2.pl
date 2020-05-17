#!/usr/bin/env perl

use 5.018;
use warnings;
use diagnostics;
use utf8;

print "Input a number list: ";
chomp(my $line = <STDIN>);
my @nums = split ' ', $line;

print "Input X: ";
chomp(my $x = <STDIN>);

print "Input Y: ";
chomp(my $y = <STDIN>);

my @result;

sub gen {
    my ($X, $Y, @L) = @_;
    my @L1;
    for (@L) {
        if ((length $_) < $X) { push @L1, $_; }
    }
    @L1 = sort @L1;
    my @L2 = @L1;
    for (0..$#L1) {
        &rec("", $X, $Y, @L2);
        my @L3 = @L2[1..$#L2];
        push(@L3, shift @L2);
        @L2 = @L3;
    }

    @result = sort @result;
}

sub rec {
    my ($cur, $X, $Y, @L) = @_;

    if (length($cur) != 0) { $cur += 0; }

    if (length($cur) == $X) {
        if ($cur < $Y) { return $cur; }
        else { return undef; }
    } elsif (length($cur) > $X) { return undef; }
    else {
        while (my ($i, $v) = each @L) {
            for (0..$X) {
                my $cur1 = $cur x $_;
                my $res1 = &rec($cur1 . $v, $X, $Y, @L[$i+1..$#L]);
                my $res2 = &rec($cur1, $X, $Y, @L[$i+1..$#L]);

                if ($res1 && !&contains($res1, @result)) {
                    push @result, $res1;
                }
                if ($res2 && !&contains($res2, @result)) {
                    push @result, $res2;
                }
            }
        }
    }
}

sub contains {
    my ($x, @L) = @_;
    for (@L) { if ($_ == $x ) {return 1;} }
    undef;
}

&gen($x, $y, @nums);
print "@result\n";
