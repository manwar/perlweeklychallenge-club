#!/usr/bin/env -S perl -wl

use PDL;
use Inline Pdlpp;

local *shortest_distance=sub {
    my ($str,$chr)=@_;
    ($str =~ /$chr/) || return 0;

    (1==length($chr)) || (die "Single character input needed:$!\n");

    my $retval=zeros(length($str)); #-- pdl to hold return value
    
    #-- get indices where the element equals chr
    my @grp=(grep {$chr eq substr($str,$_,1)} 0..length($str));
    
    #-- if the initial matching index is greater than 0 say x, fill 0:x 
    ($grp[0] > 0) && ($retval->slice("0:$grp[0]") .= sequence($grp[0]+1)->slice('-1:0'));
    
    #-- fill in distances between elements of @grp
    map {
        $retval->slice("$grp[$_]:$grp[$_+1]") .=
        pdl($grp[$_])->between(pdl($grp[$_+1]));
    } 0 .. ($#grp-1);
    
    
    #-- if the last element of @grp is less than the length of $str, fill in the distance for the remaining elemtnts.
    ($grp[-1] < (length($str)-1)) && ($retval->slice("$grp[-1]:") .= sequence(length($str)-$grp[-1]));
    
    return $retval;
 };


print &shortest_distance('loveleetcode','e');
#[3 2 1 0 1 0 0 1 2 2 1 0]

print &shortest_distance('aaab','b');
#[3 2 1 0]

__DATA__

__Pdlpp__

pp_def(
    'between',
    Pars => 'indx a1(); indx a2(); int [o]b(n);',
    RedoDimsCode => '$SIZE(n)=$a2()-$a1()+1;',
    Code => q{
        PDL_Indx i,c_mid, n_size=$SIZE(n);
        if (0==(n_size % 2)){
           c_mid=n_size/2;
        }
        else {
            c_mid=(n_size+1)/2;
        }
       for (i=0; i < c_mid; i++) {
            $b(n=>i)=i;             
       }
       for (i=c_mid; i < n_size; i++) {
            $b(n=>i)=n_size-i-1;
       } 
    },
);



