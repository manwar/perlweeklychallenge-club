#!/usr/bin/env raku
use Test;

is-deeply avc(<relocate delocate allocate>),         ("locate",);
is-deeply avc(<apple banana cherry>),                Nil;
is-deeply avc(<navigate cavity gravity>),            ("avi",);
is-deeply avc(<pedalgia pedalboard pedantic>),       ("peda",);
is-deeply avc(<schoolmaster schoolhouse schooling>), <ho ol>;

sub avc(@str is copy)
{
    @str .= sort(-*.chars);

    my $v        =  /<[aeiou]>/;
    my $c        = /<-[aeiou]>/;
    my %m is Map = (@str.pop ~~ m:ex/[$c? [$v$c]+ $v?] | $c$v/).classify(*.chars);

    for %m.keys.sort(-*) -> $k
    {
        .return if .elems given gather for flat %m{$k} -> $s
        { 
            take ~$s if @str.all.contains($s) 
        }
    }
}
