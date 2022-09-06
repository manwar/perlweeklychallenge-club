#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

=begin comment
Task 2: Hot Day         Submitted by: Mohammad S Anwar
Given temperature.txt with daily temperature record in random order.
Write a script to find out days hotter than previous day.
temperature.txt has lines like / ^ \d\d\d\d-\d\d-\d\d, \d* $/
=end comment

my $expect = " 
        Output:
2022-08-02
2022-08-05
2022-08-06
2022-08-08
2022-08-10
";


my $filename = $?FILE.IO.parent.cleanup.add: 'temperature.txt' ;

sub report-hotter-today-than-yesterday( $filename ) {
    my @in = grep { .defined and $_ ne '' }, sort lines slurp $filename;

    for @in -> $i is rw {
        my ($d, $t) = $i.split: ', ', 2;
        $d = Date.new: $d;
        $i =  $d => $t;
    }
    say "    Output:";
    for @in.rotor( 2 => -1) {
        next unless .[0].key +1 == .[1].key;
        next unless .[0].value < .[1].value;
        say  .[1].key;
    }
}

report-hotter-today-than-yesterday( $filename );
exit;
