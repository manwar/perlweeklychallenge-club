#!/usr/bin/perl

# Challenge 014
#
# Challenge #1
# Write a script to generate Van Eck’s sequence starts with 0. For more
# information, please check out wikipedia page. This challenge was proposed by
# team member Andrezgz.

use Modern::Perl;

sub van_eck_iter {
    my @hist;
    my @init = (0, 0);      # first two terms
    return sub {
        if (@init) {
            push @hist, shift @init;
            return $hist[-1];
        }
        else {
            for my $m (reverse 0 .. $#hist-1) {
                if ($hist[$m]==$hist[-1]) {
                    push @hist, $#hist - $m;
                    return $hist[-1];
                }
            }
            push @hist, 0;
            return $hist[-1];
        }
    };
}

@ARGV==1 or die "usage: ch-1.pl N\n";
my $N = shift;
my $iter = van_eck_iter();
my $sep = "";
for (1..$N) {
    print $sep, $iter->();
    $sep = ", ";
}
print "\n";
