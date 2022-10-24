#!/usr/bin/env perl

print &total_zero(5,4),"\n"; #5
print &total_zero(6,4),"\n"; #3
print &total_zero(5,2),"\n"; #4
print &total_zero(3,1),"\n"; #3
print &total_zero(7,4),"\n"; #5

sub total_zero  {
    my ($bigger, $smaller) = sort {$b <=> $a} @_;
    ($smaller <= 0) && die "total_zero: Inputs must be positive\n";
    ($bigger==$smaller) && (return 1);
    ($smaller==1) && (return $bigger);
    ( !($bigger % $smaller) ) && (return (int($bigger/$smaller)));

    my $times=int($bigger/$smaller);
    return $times + &total_zero($smaller,$bigger-$times*$smaller);
}

