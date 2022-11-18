#!/usr/bin/env perl


print &twice_largest(1,2,3,4),"\n"; #-1
print &twice_largest(1,2,0,5),"\n"; #1
print &twice_largest(2,6,3,1),"\n"; #1
print &twice_largest(4,5,2,3),"\n"; #-1

sub twice_largest {
    my (@list)=@_;
    my @sorted_list = sort {$b <=> $a} @list;
    (($sorted_list[0]) >= (2*$sorted_list[1]))  ? 1 : (-1);
}

