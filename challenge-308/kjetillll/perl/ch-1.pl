#https://theweeklychallenge.org/blog/perl-weekly-challenge-308/

sub cc{my%c;//,map$c{$_}|=$',@{+pop}for 1,2;grep$c{$_}==3,keys%c} #count common

use Test::More tests => 3;
for(
[ ["perl", "weekly", "challenge"], ["raku", "weekly", "challenge"] => 2 ],
[ ["perl", "raku", "python"],      ["python", "java"]              => 1 ],
[ ["guest", "contribution"],       ["fun", "weekly", "challenge"]  => 0 ]    
){ my($arr1,$arr2,$want)=@$_; my $got = cc($arr1,$arr2); is $got, $want }
