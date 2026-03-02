#!/usr/bin/env perl

use Modern::Perl;

@ARGV==1 or die "usage: $0 N\n";
my $N = 0+$ARGV[0];

sub permute {
    my(@items) = @_;
    my @output;

    my $permute;
    $permute = sub {
        my($items, $perms) = @_;
        unless (@$items) {
            push @output, $perms;
            return;
        }
        for my $i (0 .. $#$items) {
            my @rest = @$items;
            my ($pick) = splice(@rest, $i, 1);
            $permute->(\@rest, [@$perms, $pick]);
        }
    };

    $permute->(\@items, []);
    return @output;
}

sub is_beautiful {
    my(@items) = @_;
    for my $i (1 .. @items) {
        return 0 if $items[$i-1] % $i != 0 && $i % $items[$i-1] != 0;
    }
    return 1;
}

my @output = grep {is_beautiful(@$_)} permute(1..$N);
say scalar(@output);
