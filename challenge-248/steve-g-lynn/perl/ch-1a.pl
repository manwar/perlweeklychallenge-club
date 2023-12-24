#!/usr/bin/env -S perl -wl

#-- faster version that does everything in Inline Pdlpp

use PDL;
use Inline Pdlpp;

local *shortest_distance_a=sub {
    # faster version using PP for outer loop
    my ($str,$chr)=@_;
    ($str =~ /$chr/) || return 0;

    (1==length($chr)) || (die "Single character input needed:$!\n");
    
    #-- get indices where the element equals chr
    my $grp=pdl(grep {$chr eq substr($str,$_,1)} 0..length($str));
    my $retval=$grp->shortest_distance_pp(length($str));
    
    return $retval;
 };

print &shortest_distance_a('loveleetcode','e');
#[3 2 1 0 1 0 0 1 2 2 1 0]

print &shortest_distance_a('aaab','b');
#[3 2 1 0]

__DATA__

__Pdlpp__


pp_def(
    'shortest_distance_pp',
    Pars => 'indx a(m); indx lenstr(); [o]b(n);',
    RedoDimsCode => '$SIZE(n)=$lenstr();',
    GenericTypes => ['N'], 
    Code => q{
        PDL_Indx i,j,size_m, size_n, ctr_stop;
        size_m=$SIZE(m);
        size_n=$SIZE(n);
        ctr_stop=$a(m=>0);
        if (0 < $a(m=>0)){
            for (i=0; i < ctr_stop; i++) {
                $b(n=>i)=ctr_stop-i;
            } 
        }
        PDL_Indx a1,a2,c_mid,gap_size;
        for (j=0; j<size_m; j++) {
            a1=$a(m=>j);
            a2=$a(m=>j+1);
            gap_size=a2-a1+1;
            
            if (0==(gap_size % 2)){
                c_mid=gap_size/2;
            }
            else {
                c_mid=(gap_size+1)/2;
            }
            
            for (i=a1; i < a1+c_mid; i++) {
                $b(n=>i)=i-a1;             
            }
            for (i=a1+c_mid; i <= a2; i++) {
                $b(n=>i)=a2-i;
            } 
            
        }       
        if (size_n > $a(m=>-1)+1){
            a1=$a(m=>size_m-1);
            for (i=a1; i < size_n; i++) {
                $b(n=>i)=i-a1;
            } 
        }                        
    },
);

