# The Weekly Challenge 254
# Task 2 Reverse Vowels
use v5.30.0;
use warnings;

sub r_v {
    my $s = $_[0];
    my $c_s = $s;
    $c_s =~ tr/aeiou/=/;
    $c_s =~ tr/AEIOU/_/;
    my @arr = split "", $s;
    my @c_arr = split "", $c_s;
    my @vowels = reverse map {lc} grep { /[aeiou]/i} @arr;
    my $i = 0;
    for my $j (0..$#c_arr) {
        my $c = $c_arr[$j];
        if ($c eq "=") {
            $arr[$j] = $vowels[$i];
            $i++;
        }
        if ($c eq "_") {
            $arr[$j] = uc $vowels[$i];
            $i++;
        }
    }
    return join "", @arr;
}

use Test::More tests=>5;
ok r_v("Raku") eq "Ruka";
ok r_v("Perl") eq "Perl";
ok r_v("Julia") eq "Jaliu";
ok r_v("Uiua") eq "Auiu";
ok r_v("Cpp") eq "Cpp";

