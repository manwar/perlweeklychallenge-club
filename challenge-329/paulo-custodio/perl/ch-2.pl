#!/usr/bin/env perl

use Modern::Perl;
use List::Util qw(uniq);

@ARGV==1 or die "usage: $0 str\n";
my $str = $ARGV[0];
my @subs = map {$_->[0]}
            sort {$a->[1] <=> $b->[1]}
            map {[$_, length($_)]}
            grep {is_nice($_)}
            get_substrings($str);
say $subs[-1];

sub get_substrings {
    my($str) = @_;
    my @str = split //, $str;
    my @out = ("");
    for my $i (0 .. $#str) {
        for my $len (1 .. @str-$i) {
            my $sub = join '', @str[$i .. $i+$len-1];
            push @out, $sub;
        }
    }
    return @out;
}

sub is_nice {
    my($str) = @_;
    my %letters; $letters{$_}=1 for split //, $str;
    for my $c ('a' .. 'z') {
        if ($letters{$c} && !$letters{uc($c)} ||
            !$letters{$c} && $letters{uc($c)}) {
            return 0;
        }
    }
    return 1;
}
