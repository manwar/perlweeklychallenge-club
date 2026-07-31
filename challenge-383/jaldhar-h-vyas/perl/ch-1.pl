#!/usr/bin/perl
use 5.40.1;
use warnings;

my @list1 = split /\s+/, shift;
my @list2 = split /\s+/, shift;
my @list3 = map { [ split /\s+/ ] } @ARGV;
my $result = true;

if (scalar @list1 != scalar @list2) {
    $result = false;
} else {
    for my $i (keys @list1) {
        if ($list1[$i] eq $list2[$i]) {
            delete $list1[$i];
            delete $list2[$i];
        }
    }

    for my $i (keys @list1) {
        my @similar = @{$list3[$i]};
        unless ((grep { $_ eq $list1[$i] } @similar) &&
        (grep { $_ eq $list2[$i] } @similar)) {
            $result = false;
            last;
        }
    }
}

say $result ? "true" : "false";
