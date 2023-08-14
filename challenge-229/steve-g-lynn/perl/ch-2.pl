#!/usr/bin/env -S perl -wl

print join ',', &two_out_of_three([1,1,2,4],[2,4],[4]); #4,2
print join ',', &two_out_of_three([4,1],[2,4],[1,2]); #1,2,4

sub two_out_of_three {
    #-- helper sub sub
    local *in_arry = sub {
        local @in_arry=@_;
        local %in_arry;
      
        map {
            $in_arry{$_}=1;
        } @in_arry;
        %in_arry;
    };
    
    #-- main trunk of sub
    my ($ra1, $ra2, $ra3)=@_;
    
    my %rh1 = &in_arry($ra1->@*);
    my %rh2 = &in_arry($ra2->@*);
    my %rh3 = &in_arry($ra3->@*);
    
    my %two_out_of_three;
    
    map {( (exists $rh2{$_}) || (exists $rh3{$_}) ) &&
     ($two_out_of_three{$_}=1);} keys %rh1;
    map {( (exists $rh1{$_}) || (exists $rh3{$_}) ) &&
     ($two_out_of_three{$_}=1);} keys %rh2;

    keys %two_out_of_three;
}

