#!/usr/bin/env perl

{
use List::Util qw(sum max min);

local *equal_distribution=sub {

    #-- nested sub-subroutines
    local *minindx = sub {
        (grep {$list[$_] == (min @list)} (0 .. @list));
    };
    
    local *maxindx = sub {
        (grep {$list[$_] == (max @list)} (0 .. @list));
    };

    local *closest_pair = sub {
        local (@retval);
      
        local (@minindx) = &minindx;
        local (@maxindx) = &maxindx;            
      
        local ($min_min,$max_min,$min_max,$max_max)=(
            (min @minindx), 
            (max @minindx), 
            (min @maxindx), 
            (max @maxindx),        
        );
        
        local ($ctr,$min,$max)=(0,0,0); #-- counters
        local $last_ctr=@list;
        
        for $min ($min_min, $max_min) {
            for $max ($min_max, $max_max) {
                $ctr=abs($min-$max);
                if ($ctr < $last_ctr) {
                    @retval=($min,$max);
                    $last_ctr=$ctr;             
                }
            }
       }
       return @retval;     
    };

    local *is_equal = sub {
        local (@list)=@_;
        (sum map {$_==$tgt} @list)==@list;
    };

    local *iterate = sub {
        local (@closest_pair)=&closest_pair;
        
        $count += abs($closest_pair[0]-$closest_pair[1]);
        ($list[$closest_pair[0]]) += 1;
        ($list[$closest_pair[1]]) -= 1;
    };


    #-- the root subroutine starts here
    #-- dynamic scope (local keyword) is convenient
    
    local (@list) = @_;
    ((sum @list) % @list) && (return -1);
    
    local $tgt = (sum @list)/@list;
    local $count = 0;
    
    while (1) {
        &is_equal(@list) && return $count;
        &iterate;
    }        
};

print &equal_distribution(1,0,5),"\n"; #4
print &equal_distribution(0,2,0),"\n"; #-1
print &equal_distribution(0,3,0),"\n"; #2
print &equal_distribution(5,2,3,1,4),"\n"; #5

}

