# The Weekly Challenge 249
# Task 2 DI String Match
use v5.30.0;
use warnings;
use List::Util qw/first/;

sub check_DI {
    my $str = $_[0];
    my @perm = $_[1]->@*;
    return 0 unless (join ",", sort {$a<=>$b} @perm) 
                            eq 
                    (join ",", 0..length $str);
    for (0..$#perm-1) {
        next if substr($str, $_, 1) eq "I" && $perm[$_] < $perm[$_+1];
        next if substr($str, $_, 1) eq "D" && $perm[$_] > $perm[$_+1];
        return 0;
    }
    return 1;
}

sub generate {
    my $str = $_[0];
    my @bin = map {1 << $_} 1..length $str;
    my @asst = (0);
    for (1..length $str) {
        if (substr($str, $_-1, 1) eq "I") {
            $asst[$_] = $asst[$_-1]+$bin[$_-1];
        } elsif (substr($str, $_-1, 1) eq "D") {
            $asst[$_] = $asst[$_-1]-$bin[$_-1];
        } else {
            die "Error\n";
        }
    }
    my @bsst = sort {$a<=>$b} @asst;
    my @arr;
    for my $i (0..length $str) {
        push @arr, first {$bsst[$_] == $asst[$i]} 0..length $str;
    }
    say "String $str, generate '@arr'";
    return [@arr];
}
use Test::More tests=>3;
ok check_DI("IDID",generate("IDID"));
ok check_DI("III",generate("III"));
ok check_DI("DDI",generate("DDI"));
