#!/usr/bin/env raku

my %letter;
my %number;

my $number = 1;
my $letter = "A";

loop {
    last if $number > 16384;

    %letter{$number} = $letter;
    %number{$letter} = $number;

    $number++;
    $letter++;
}

multi sub MAIN (Str $str where $str.all ~~ /<[A..Z]>/) {
    say %number{$str};
}

multi sub MAIN (UInt $num where $num <= 16384) {
    say %letter{$num};
}
