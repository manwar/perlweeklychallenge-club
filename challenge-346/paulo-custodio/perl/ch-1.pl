#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 '())()()'\n";
say longest_sequence($ARGV[0]);

sub longest_sequence {
    my($str) = @_;
    my @in = split //, $str;
    my $longest = 0;
    for my $i (0 .. $#in) {
        my $len = sequence(@in[$i .. $#in]);
        $longest = $len if $len > $longest;
    }
    return $longest;
}

sub sequence {
    my(@in) = @_;
    my $nest = 0;
    my $last_ok = 0;
    for my $i (0 .. $#in) {
        if ($in[$i] eq '(') {
            $nest++;
        }
        elsif ($in[$i] eq ')') {
            if ($nest == 0) {
                return $i;
            }
            $nest--;
        }
        else {
            die "invalid character ", $in[$i];
        }
        $last_ok = $i+1 if $nest == 0;
    }
    return $last_ok;
}
