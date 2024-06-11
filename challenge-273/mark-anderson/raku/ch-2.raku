#!/usr/bin/env raku
use Test;

ok  b-after-a("aabb");
nok b-after-a("abab");
nok b-after-a("aaa");
ok  b-after-a("bbb");
ok  b-after-a("aaabxyzbcde");
nok b-after-a("aaabxayzbcde");
nok b-after-a("aaabxyzbcade");
nok b-after-a("aaabxyzcde");

ok  b-after-a-pos("aabb");
nok b-after-a-pos("abab");
nok b-after-a-pos("aaa");
ok  b-after-a-pos("bbb");
ok  b-after-a-pos("aaabxyzbcde");
nok b-after-a-pos("aaabxayzbcde");
nok b-after-a-pos("aaabxyzbcade");
nok b-after-a-pos("aaabxyzcde");

ok  b-after-a-indices("aabb");
nok b-after-a-indices("abab");
nok b-after-a-indices("aaa");
ok  b-after-a-indices("bbb");
ok  b-after-a-indices("aaabxyzbcde");
nok b-after-a-indices("aaabxayzbcde");
nok b-after-a-indices("aaabxyzbcade");
nok b-after-a-indices("aaabxyzcde");

# Note: I may have misunderstood the problem. I thought it was to check
# for a 'b' and then a 'b' after the first 'b' and no 'a' after the first
# 'b' but it looks like others have checked for a 'b' and no 'a' after
# that first 'b' 🤷

sub b-after-a($str)
{
    $str ~~ / ^ <-[b]>* b <-[a]>* b <-[a]>* $ /
}

sub b-after-a-pos($str)
{
    my $b         = $str ~~ m:1st          / b / || return False;
    my $a-after-b = $str ~~ m:c($b.pos):1st/ a /;
    my $b-after-b = $str ~~ m:c($b.pos):1st/ b /;
    $b-after-b and not $a-after-b
}

sub b-after-a-indices($str)
{
    my @a = $str.indices('a');
    my @b = $str.indices('b');
    @b > 1 and all(@a) < @b.head 
}
