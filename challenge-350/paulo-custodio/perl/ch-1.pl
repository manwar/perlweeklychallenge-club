#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 string\n";
my $string = shift;
my @subs = find_substrings(3, $string);
my @good = grep {is_good($_)} @subs;

say scalar(@good);

sub find_substrings {
    my($len, $str) = @_;
    my @out;
    for my $i (0 .. length($str) - $len) {
        push @out, substr($str, $i, $len);
    }
    return @out;
}

sub is_good {
    my($str) = @_;
    my %count;
    for my $c (split //, $str) {
        return 0 if $count{$c}++;
    }
    return 1;
}
