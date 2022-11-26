#!/usr/bin/env perl6


say &equal-distribution((1,0,5)); #4
say &equal-distribution((0,2,0)); #-1
say &equal-distribution((0,3,0)); #2
say &equal-distribution((5,2,3,1,4)); #5

#-- helper subs

sub minindx (@list) {
    (0 .. @list.elems-1).grep( {@list[$_] == (@list.min)} );
}

sub maxindx (@list) {
    (0 .. @list.elems-1).grep( {@list[$_] == (@list.max)} );
}


sub closest-pair (@list) {
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
        
        my ($minindx,  $maxindx) = &closest-pair(@list);
        
        $count += ($minindx - $maxindx).abs;
        
        @list[$minindx] += 1;
        @list[$maxindx] -= 1;
        
    }        
}

