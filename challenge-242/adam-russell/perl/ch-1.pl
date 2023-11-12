use v5.38;
##
# You are given two arrays of integers.
# Write a script to find out the missing members in each other arrays.
##
use boolean;
use Data::Dump q/pp/;
sub missing_members{
    my @r;
    my($a0, $a1) = @_;
    my $missing0 = [];
    missing_members_r([@{$a0}], [@{$a1}], $missing0);
    my $missing1 = [];
    missing_members_r([@{$a1}], [@{$a0}], $missing1);
    push @r, $missing0 if @{$missing0} > 0;
    push @r, $missing1 if @{$missing1} > 0;
    return @r;
}

sub missing_members_r{
    my($a0, $a1, $missing, $seen) = @_;
    $seen = [] if !defined($seen);
    my $x = shift @{$a0};
    push @{$missing}, $x if missing_r($x, [@{$a1}]) && !seen_r($x, $seen); 
    push @{$seen}, $x;
    missing_members_r($a0, $a1, $missing, $seen) if @{$a0} > 0;
}

sub missing_r{
    my($x, $a0) = @_;
    return true if @{$a0} == 0;
    if(@{$a0}){
        my $y = shift @{$a0};
        if($x == $y){ 
            return false;
        }
    }
    return missing_r($x, $a0);
}

sub seen_r{
    my($x, $seen) = @_;
    return false if @{$seen} == 0;
    my $y = shift @{$seen};
    if($x == $y){
        return true;
    }
    return seen_r($x, $seen);
}

MAIN:{
    my @array1 = (1, 2, 3);
    my @array2 = (2, 4, 6);
    say pp missing_members \@array1, \@array2;
    @array1 = (1, 2, 3, 3);
    @array2 = (1, 1, 2, 2);
    say pp missing_members \@array1, \@array2;
}