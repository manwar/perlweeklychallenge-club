#!/usr/bin/env perl6


say &equal-distribution((1,0,5)); #4
say &equal-distribution((0,2,0)); #-1
say &equal-distribution((0,3,0)); #2

#-- helper subs

sub minindx (@list) {
    (0 .. @list.elems-1).grep( {@list[$_] == (@list.min)} );
}

sub maxindx (@list) {
    (0 .. @list.elems-1).grep( {@list[$_] == (@list.max)} );
}

sub distance (@list) {
    min (
        abs(&maxindx(@list).max - &minindx(@list).min),
        abs(&maxindx(@list).min - &minindx(@list).max)
    );
}

sub closest_pair (@list) {
    my (@retval);
      
    my @minindx=&minindx(@list);
    my @maxindx=&maxindx(@list);            
      
    my ($min_min,$max_min,$min_max,$max_max)=(
            @minindx.min, 
            @minindx.max, 
            @maxindx.min, 
            @maxindx.max,        
    );
        
    my $ctr=0; #-- counter
    my $last_ctr=@list;
        
    for ($min_min, $max_min) -> $min {
        for ($min_max, $max_max) -> $max {
            $ctr=abs($min-$max);
            if ($ctr < $last_ctr) {
                @retval=($min,$max);
                $last_ctr=$ctr;             
            }
        }
   }  
   return @retval;     
}

sub is_equal( @list, $tgt ) {
    @list.map({$_==$tgt}).sum==@list;
}

sub iterate( @list )  {    
    
    my $distance=&distance(@list);
    
    my ($minindx,$maxindx)=&closest_pair(@list);    
    
    return ($distance, $minindx, $maxindx)
}

#-- root sub

sub equal-distribution(@list_) {
    my @list;
    
    for (@list_) {
        push(@list,$_);
    }
    
    
    (@list_.sum !%% @list_.elems) && (return -1);
    
    my $tgt = @list_.sum div @list_.elems;
    my $count = 0;
    
    while (1) {
    
        (&is_equal(@list, $tgt)) && (return $count);
        
        my ($distance, $minindx,  $maxindx) = &iterate(@list);
        
        $count += $distance;
        
        @list[$minindx] += 1;
        @list[$maxindx] -= 1;
        
    }        
}

