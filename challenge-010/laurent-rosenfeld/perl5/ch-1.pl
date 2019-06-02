#!/usr/bin/perl
use strict;
use warnings;
use feature qw/say/;


my %rom_tab = (I => 1,  V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);

sub from_roman {
    my $roman = uc shift;
    my $numeric = 0;
    my $prev_letter = "M";
    for my $letter (split //, $roman) {
        $numeric -= 2 * $rom_tab{$prev_letter}
            if $rom_tab{$letter} > $rom_tab{$prev_letter};
        $numeric += $rom_tab{$letter};
        $prev_letter = $letter;
    }
    return $numeric;
}

sub to_roman {
    my $arabic = shift;
    warn "$arabic out of bounds" unless $arabic > 0 and $arabic < 4000;
    my %hash = %rom_tab;
    $hash{$_->[0]} = $_->[1] for (['IV', 4], ['IX', 9], ['XL', 40],
        ['XC', 90], ['CD', 400], ['CM', 900] );
    my $roman = "";
    for my $key (sort { $hash{$b} <=> $hash{$a} } keys %hash) {
        my $num = int ($arabic / $hash{$key});
        $roman .= $key x $num;
        $arabic -= $hash{$key} * $num;
    }
    return $roman;
}

say "From Roman to Arabic";
say "$_\t=>\t", from_roman $_ for qw <MM MCM LXXIII XCIII IC XCIX xv>;

my @test_nums = qw <19 42 67 90 97 99 429 498 687 938 949 996 2145 3597>;
say "From Arabic to Roman";
say "$_\t=>\t", to_roman $_ for @test_nums;

say "Some round trips: from Arabic to Roman to Arabic";
say "$_\t=>\t", from_roman to_roman $_ for @test_nums;

say "Sanity check (round trip through the whole range)";
for (1..3999) {
    my $result = from_roman to_roman $_;
    say "Error on $_ " unless $result == $_;
}
