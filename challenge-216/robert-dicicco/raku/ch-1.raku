#!/usr/bin/env raku
=begin comment
--------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-05-08
Challenge 216 Registration Number ( Raku )
--------------------------------------------
=end comment

use v6;

my @words = ('abc', 'abcd', 'bcd', 'AB1 2CD'), ('job', 'james', 'bjorg', '007 JB'), ('crack', 'road', 'rac', 'C7 RA2');
my @out = ();

sub CheckWords($wd, $rg) {
    my @arr = $rg.comb;
    my $flag = 0;
    for (@arr) -> $let {
          if ($wd !~~ /$let/) {
            $flag = 1;         # set flag to 1 if no match
        }
    }
    @out.push($wd) if $flag == 0;
}


for (@words) -> @wds {
    my $reg = @wds.[*-1];
    my $cnt = @wds.elems - 2;
    my @wds_only = @wds[0..$cnt];
    print "Input: [",@wds_only,"]  \$reg = ",$reg,"\n";
    $reg ~~ tr/A..Z/a..z/;
    $reg ~~ s:g/\d|\s//;      # remove spaces and numbers
    my $x = 0;
    while $x <= $cnt {
        CheckWords(@wds[$x], $reg);
        $x += 1;
    }
    print("Output: ",@out,"\n\n");
    @out = ();
}

=begin comment
--------------------------------------------
SAMPLE OUTPUT
raku .\Registration.rk
Input: [abc abcd bcd]  $reg = AB1 2CD
Output: abcd

Input: [job james bjorg]  $reg = 007 JB
Output: job bjorg

Input: [crack road rac]  $reg = C7 RA2
Output: crack rac
--------------------------------------------
=end comment


