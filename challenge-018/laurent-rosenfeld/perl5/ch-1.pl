#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;

sub compare2str {
    my ($str1, $str2) = @_;
    my @st1 = split //, $str1;
    my @st2 = split //, $str2;
    my %result;
    my $common = '';
    my ($i, $j) = (0, 0);
    while ($i <= $#st1) {
        while ($j <= $#st2) {
            if ($st1[$i] eq $st2[$j]) {
                $common .= $st1[$i];
                $result{$common} = 1;
                my ($k, $l) = ($i, $j);
                while (1) {
                    $k++; $l++;
                    if ($k <= $#st1 and $l<= $#st2
                        and $st1[$k] eq $st2[$l]) {
                            $common .= $st1[$k];
                            $result{$common} = 1;;
                    } else {
                        $common = '';
                        last;
                    }
                }
            }
            $j++;
        }
        $j = 0;
        $i++;
    }
    return keys %result;
}

die "Must supply at least two strings\n" unless @ARGV >= 2;
my %common = map { $_ => 1 } compare2str shift, $ARGV[0];
while (@ARGV > 1) {
    %common = map { $_ => 1 } grep $common{$_},
        compare2str shift, $ARGV[0];
}
my $max = "";
for (keys %common) {
    $max = $_ if length $_ > length $max;
}
say "Largest common substring: $max";
