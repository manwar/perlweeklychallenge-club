#!/usr/bin/env perl

#-- restricted to perl 4 syntax

{
local %code_hash;
map { $code_hash{('a' .. 'z')[$_]} = $_+1} (0 .. 25);

local *odd_string = sub {

    #-- helper sub-subroutines
    
    local *difference_array = sub {
       local ($s)=@_;
       local $retval;
       local @s=split(//,$s);  
       map {
        $retval .= ($code_hash{$s[$_]} - $code_hash{$s[$_-1]}) . ":";
        } 
        (1 .. @s-1);
       chop $retval;
       return $retval;  
    };

    local *difference_array_loop = sub {
        local ($ctr,@retval);
        for $ctr (0..@s-1) {
            $retval[$ctr]=&difference_array( $s[$ctr] );
        }
        return @retval;
    };
    
    local *mybag = sub {
        local (@s)=@_;
        local %retval;
        
        foreach (@s) {
            $retval{$_}++;
        }
        return %retval;
    };
    
    
    #-- root sub
    local (@s)=@_;
    
    local @difference_array_loop = &difference_array_loop;
    local %mybag = &mybag(@difference_array_loop);

    for (0 .. @difference_array_loop-1) {
        return $s[$_] if $mybag{$difference_array_loop[$_]}==1;
    }

};

print &odd_string("adc","wzy","abc"),"\n";
print &odd_string("aaa","bob","ccc","ddd"),"\n";

}

