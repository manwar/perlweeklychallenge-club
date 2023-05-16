#!/usr/bin/env -S perl -wl


sub max_number {
    my (@list)=@_;
    join '', sort { $b.$a <=> $a.$b } @list;
}

print &max_number( 1,23 ); #--231
print &max_number( 10,3,2 ); #--3210
print &max_number( 31,2,4,10 ); #-- 431210
print &max_number( 5,11,4,1,2 ); #-- 542111
print &max_number( 1,10 ); #-- 110

