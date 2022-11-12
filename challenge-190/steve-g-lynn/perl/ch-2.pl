#!/usr/bin/env perl

#-- uses only perl 4 syntax 
#-- ref: https://www.rexswain.com/perl4.html
{

local (%a2i,%i2a); #-- hashes to store codes
local $ctr; #-- counter for loops

#-- create a lookup table to store the codes
#-- %i2a: 1 .. 26 => 'A' .. 'Z'
#-- %a2i: 'A' .. 'Z' => 1 .. 26

for $ctr (1 .. 26) {
    $i2a{$ctr}=('A' .. 'Z')[$ctr-1];
    $a2i{$i2a{$ctr}}=$ctr;
}

local *decoded_list = sub {
    local ($s) = @_;

    #-- subsubs and lookup tables
    
    local *chk = sub {
    #-- verify that a particular code matches $s
        local (@code) = @_;
        local ($ctr,$retval,@retval);
        for $ctr (@code) { 
            push @retval, $a2i{$ctr};
        }
        $retval = join //, @retval;
        return ($retval == $s)
    };
    
    local %iterator; 
    #-- specifies the order of iterations for $s length 2,3 and 4
    #-- as a string to be eval'd in a loop
     
    $iterator{2}=q<('@ones[0..1]','@twos[0]')>;
    $iterator{3}=q<('@ones[0..2]',
        '($ones[0],$twos[1])',
        '($twos[0],$ones[2])')>;
    $iterator{4}=q<('@ones[0..3]',
        '(@ones[0..1],$twos[2])',
        '($twos[0],@ones[2..3])',
        '($ones[0],$twos[1],$ones[3])',
        '@twos[0,2]'
        )>;

    #-- back to root sub decoded_list

    $s=~/^[1-9]+$/  || die "Only [1-9] allowed.\n";
    
    (length($s) > 4) && die "For strings > 4 chars, use &slide_decoded_list\n"; 
    
    (length($s)==1) && (return $i2a{$s});
    
    local (@ones,@twos,@retval,$ctr);
    
    for $ctr (1 .. length($s)) {
        push @ones, $i2a{substr($s,$ctr-1,1)};
        push @twos, $i2a{substr($s,$ctr-1,2)};
    }
    pop @twos;
    #@ones stores the codes for the digits 1 at a time
    #@twos stores the codes for the digits 2 at a time
    #with a null element for digit-pairs > 26
    
    #iterate thru' the possibilities
    
    for $ctr (eval $iterator{length($s)}) {
        local @s = eval $ctr;
        ( &chk(@s) ) && ( push @retval, join //, @s);
    }
                    
    return sort {$a cmp $b} @retval;
};

local *slide_decoded_list = sub{
    #-- for longer input, return a list of 
    #-- stringified decode_list output for
    #-- substrings taken four at a time, 
    #-- as substr($s,0,4),substr($s,3,4),substr($s,6,4)... 
    
    #-- it makes more sense to slide through a long text
    #-- decoding small overlapping chunks at a time
    #-- rather than searching for all the combinations 
    #-- in the entire text viewed as a single string

    local ($s)=@_;
    local ($ctr,@retval);
    for ($ctr=0; $ctr < length($s); $ctr+=3 ) {
        local @s=&decoded_list(substr($s,$ctr,4));
        push @retval, "(@s)"; 
    }
    return @retval;
};

{
local @test=&decoded_list('11');
print "@test\n"; #AA K
}

{
local @test=&decoded_list('1115');
print "@test\n"; #AAAE AAO AKE KAE KO
}

{
local @test=&decoded_list('127');
print "@test\n"; #ABG LG
}

{
local @test=&slide_decoded_list(1115127);
print "@test\n";
#(AAAE AAO AKE KAE KO) (EABG ELG) (G)
}
}
