use strict;
use warnings;
use feature qw/say/;

sub highest_digit  {
    my ($h, $m) = split /\:/, $_[0];
    # say $h, " ", $m;
    if ($h =~ /\?/) {
        my ($h1, $h2) = split //, $h;
        if ($h1 eq '?') {
            return $h2 > 3 ? 1 : 2;
        } elsif ($h2 eq '?') {
            return $h1 == 2 ? 3 : 9;
        }
    } elsif ($m =~ /\?/) {
        my ($m1, $m2) = split //, $m;
        return 5 if $m1 eq '?';
        return 9 if $m2 eq '?';
    }
}

for my $t (qw<?5:00 ?3:00 1?:00 2?:00 12:?5 12:5? 14:?9>) {
    say "$t => ", highest_digit($t);
}
