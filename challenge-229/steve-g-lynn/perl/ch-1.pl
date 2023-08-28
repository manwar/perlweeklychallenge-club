#!/usr/bin/env -S perl -wl

print &lexicographic_order('abc', 'bce', 'cae'); #1
print &lexicographic_order('yxz','cba','mon'); #2

sub lexicographic_order {
    #-- helper subroutine
    
    local *is_sorted = sub {
        my ($str)=@_;
        
        (length($str) < 3) && (return 1);
        
        my $op;
        ( substr($str,0,1) le substr($str,1,1) ) ?
        ($op = 'le') : ($op = 'ge');
        
        INSTRING: for my $x (2 .. (length($str)-1)) {
            my $test = ('\''. substr($str,$x-1,1) .'\' '. $op .' \''. substr($str,$x,1).'\'');
            
            unless (eval($test)) {
                return 0;
                last INSTRING;
            }
        }
        1;
    };
    
    
    #-- main trunk of subroutine
    my @str = @_;
    scalar grep /0/, map {&is_sorted($str[$_])} 0 .. $#str;
}


