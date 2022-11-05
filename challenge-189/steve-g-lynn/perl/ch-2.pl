#!/usr/bin/env perl

#real	0m0.007s
#user	0m0.005s
#sys	0m0.001s

#-- restricting to syntax available in perl 4
#-- as in the 1st edition of Programming perl

ARRAY_DEGREE: {
#-- enclose the whole script in a block
#-- so that variables defined with local
#-- are only defined in the block
#-- (mimicking file-scope lexicals)

local *smallest_slice_with_same_degree = sub {
    #-- takes name of array as input; 
    #-- returns an expression giving the slice(s) as string(s) to be
    #-- eval'd (a pseudo-closure)
    
    local (*arry) = @_;
    
    local (%freq, %first, %last, %arry, $max, @max, $i, @retval);

    #--- HELPER SUBSUBS

    local *whittle = sub {
        #-- @max contains elements with highest frequency
        #-- &whittle whittles these to those with 
        #-- the smallest slice-length
        
        local @max = @_;
        local (@retval, $arry, %slice_length, $min);
        
        $min=$#arry;
        
        for $arry (@max) {
            local $slice_length = $last{$arry} - $first{$arry};
            $slice_length{$slice_length} .= "$arry:";
            ( $slice_length < $min ) && ($min = $slice_length);
        }
        
        for $arry (split /:/, $slice_length{$min}) {
            push @retval, $arry;
        }
        return @retval;
    };

    local *smallest_slice_expression = sub {
        #-- returns an expression giving a smallest slice
        #-- as in "@main::arry[$first .. $last]"
        local ($arry) = @_;
        local $first = $first{$arry};
        local $last = $last{$arry};
        return '@' . substr(*arry,1) . "[$first .. $last]";
    };

    #-- END OF HELPER SUBSUBS
    #-- BACK TO THE ROOT SUB smallest_slice_with_same_degree

    $max=0;
    
    ($first{$_} = -1) foreach (@arry);
    
    for $i (0 .. $#arry) {
        
        local $arry=$arry[$i];
        
        local $freq = ++$freq{$arry};
        
        $first{$arry} = $i unless $first{$arry} > -1;
        
        $last{$arry} = $i;
        
        $arry{$freq} .= "$arry:"; 
        #-- track @arry elements with at least $freq frequency
        
        ($max < $freq) && ($max=$freq);
       
    }
    
    @max = split /:/, $arry{$max};
    @max = &whittle(@max); 

    #-- retain only items with minimal slice lengths
    
    push @retval, &smallest_slice_expression($_) foreach (@max);

    return @retval;
};

local *print_smallest_slice = sub {
    #-- wrapper sub to eval and print the smallest slice
    #-- wraps smallest_slice_with_same_degree;

    local (*arry) = @_;

    local *print_arry = sub {
        print "( ";
        print "$_ " foreach @_;
        print ")\n";
    };

    &print_arry(eval $_) foreach (&smallest_slice_with_same_degree(*arry));
};
#-- END SUB smallest_slice_with_same_degree

#-- RUN THE TEST EXAMPLES

EXAMPLE_1: {
    local @arry=(1,3,3,2);
    print &smallest_slice_with_same_degree( *arry ),"\n";
    #@main::arry[1 .. 2]
    
    &print_smallest_slice( *arry );
    #( 3 3 )
    }

EXAMPLE_2: {
    local @arry=(1,2,1,3);
    print &smallest_slice_with_same_degree( *arry ),"\n";
    #@main::arry[0 .. 2]
    
    &print_smallest_slice( *arry );
    #( 1 2 1 )
    }
    
EXAMPLE_3: {
    local @arry=(1,3,2,1,2);
    print &smallest_slice_with_same_degree( *arry ),"\n";
    #@main::arry[2 .. 4]
    
    &print_smallest_slice( *arry );
    #( 2 1 2 )
    }
    
EXAMPLE_4: {
    local @arry=(1,1,2,3,2);
    print &smallest_slice_with_same_degree( *arry ),"\n";
    #@main::arry[0 .. 1]
    
    &print_smallest_slice( *arry );
    #( 1 1 )
    }

EXAMPLE_5: {
    local @arry=(2,1,2,1,1);
    print &smallest_slice_with_same_degree( *arry ),"\n";
    #@main::arry[1 .. 4]
    
    &print_smallest_slice( *arry );
    #( 1 2 1 1 )
    }
    
EXAMPLE_1_EXTENDED: {
    local @arry=(1,3,3,2,2,1);
    print &smallest_slice_with_same_degree( *arry ),"\n";
    #@main::arry[1 .. 2]@main::arry[3 .. 4]
    
    &print_smallest_slice( *arry );
    #( 3 3 )
    #( 2 2 )

    }    
    
} #-- ARRAY_DEGREE

