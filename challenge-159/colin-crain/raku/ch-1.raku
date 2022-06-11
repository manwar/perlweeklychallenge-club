#!/usr/bin/env perl6
#
#
#       fareys-wear-boots.raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $order = 20 ) ;

sub tri-cross { [X] (0..$^a.Num) , $^a.Num } ;

my @f = ((1..$order).map: &tri-cross)
                    .flat
                    .rotor(2)  ;
my @rats;
my @frac;

@rats.push: ($_[0]/$_[1]).Rat for @f;
@frac.push: |(@rats.sort.unique).map: *.nude ;        

@frac .= map({ $_[0] ~ '/' ~ $_[1] });
@frac.put;
