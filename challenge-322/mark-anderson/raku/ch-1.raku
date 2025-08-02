#!/usr/bin/env raku
use Test;

is format-string("ABC-D-E-F", 3), "ABC-DEF";
is format-string("A-BC-D-E",  2), "A-BC-DE";
is format-string("-A-B-CD-E", 4), "A-BCDE";

sub format-string($str, $int)
{
    # This is the version I like but it doesn't always work.
    # The problem is with the {$int}. If it's hardcoded with
    # the appropriate int then it works. Not sure what I'm 
    # doing wrong. 🤔 🤷 

    $str ~~ /^ 
                 (  \-? <upper> \-? ) ** {0..$int} 
                 ([ \-? <upper> \-? ] ** {$int}  )* 
            $/;

    (flat $/[0]>><upper>.join, $/[1]>><upper>>>.join).join("-")
}

sub format-string-v2($str is copy, $int)
{
    $str ~~ s:g/"-"//;
    my $m = "." x ($str.chars mod $int or $int);
    my $i = "." x $int;
    S:g/<?after <$m>> (<$i>)/-$0/ given $str
}

sub format-string-v3($str, $int)
{
    my @chars = $str.comb(/<upper>/);
    my $list = flat (@chars mod $int or Empty), ($int, $int...*);
    @chars.rotor($list)>>.join.join("-")
}
