#!/usr/bin/env raku
=begin comment
------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-10-21
Challenge 240 Task 01 Acronym ( Raku )
------------------------------------
=end comment
use v6;

my @mystr = (["Perl", "Python", "Pascal"],["Perl", "Raku"],["Oracle", "Awk", "C"]);
my @mychk = ("ppp","rp","oac");
my $cnt = 0;

sub GetFirstLetters(@wds) {
    my $acronym = "";
    for @wds -> $w {
        $acronym ~= lc(substr($w,0,1));
    }
    return $acronym;
}

for (@mystr) -> @str {
    say "Input: \@str = ",@str;
    say "\$chk = \"@mychk[$cnt]\"";
    my $retval = GetFirstLetters(@str);
    $retval eq @mychk[$cnt] ?? say "Output: true\n" !! say "Output: false\n";
    $cnt++;
}

=begin comment
------------------------------------
SAMPLE OUTPUT

raku .\Acronym.rk

Input: @str = [Perl Python Pascal]
$chk = "ppp"
Output: true

Input: @str = [Perl Raku]
$chk = "rp"
Output: false

Input: @str = [Oracle Awk C]
$chk = "oac"
Output: true
------------------------------------
=end comment


