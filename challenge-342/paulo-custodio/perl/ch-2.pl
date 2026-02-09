#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 101010\n";
say max_score($ARGV[0]);

sub max_score {
    my($str) = @_;
    my $max_score = 0;
    for my $len (1 .. length($str)-1) {
        my $s1 = substr($str, 0, $len);
        my $s2 = substr($str, $len);
        my $score = ($s1 =~ tr/0/0/) + ($s2 =~ tr/1/1/);
        $max_score = $score if $max_score < $score;
    }
    return $max_score;
}
