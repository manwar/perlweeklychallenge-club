#!/usr/bin/env perl6


say &decode-list('8'); #H
say &decode-list('11'); #(AA K)
say &decode-list('127'); #(ABG LG)
say &decode-list('1115'); #(AAAE AAO AKE KAE KO)
say &decode-list('1115127');
#[(AAAE AAO AKE KAE KO) (EABG ELG) G]

multi sub decode-list( Str $s where 
    $s ~~ /^<[1..9]>+$/ && $s.chars==1) { 

    return $s.trans([1 .. 9] => ['A' .. 'I']);

}

multi sub decode-list( Str $s where 
    $s ~~ /^<[1..9]>+$/ && $s.chars==2) {

    my @retval;
                
    @retval.append($s.trans([1 .. 9] => ['A' .. 'I']));
    
    ($s <= 26) && @retval.append($s.trans([1..26] => ['A' .. 'Z']));
        
    return @retval.sort;
}

multi sub decode-list( Str $s where 
    $s ~~ /^<[1..9]>+$/ && $s.chars==3) {

    my @retval;
                
    @retval.append($s.trans([1 .. 9] => ['A' .. 'I']));
    
    ($s.substr(1) <= 26) && @retval.append($s.substr(0,1).trans([1..9]=>['A'..'I']) ~
    $s.substr(1).trans([1..26] => ['A' .. 'Z']));
    
    ($s.substr(0,2) <= 26) && @retval.append($s.substr(0,2).trans([1..26]=>['A'..'Z']) ~
    $s.substr(2).trans([1..9] => ['A' .. 'I']));
            
    return @retval.sort;
}

multi sub decode-list( Str $s where 
    $s ~~ /^<[1..9]>+$/ && $s.chars==4 ) {

    my @retval;
    
    @retval.append($s.trans([1 .. 9] => ['A' .. 'I']));
    
    ($s.substr(2) <= 26) && @retval.append($s.substr(0,2).trans([1..9]=>['A'..'I']) ~
    $s.substr(2).trans([1..26] => ['A' .. 'Z']));
    
    ($s.substr(0,2) <= 26) && @retval.append($s.substr(0,2).trans([1..26]=>['A'..'Z']) ~
    $s.substr(2).trans([1..9] => ['A' .. 'I']));

    ($s.substr(1,2) <= 26) && @retval.append($s.substr(0,1).trans([1..9]=>['A'..'I']) ~
    $s.substr(1,2).trans([10..26]=>['J'..'Z']) ~
    $s.substr(3).trans([1..9] => ['A' .. 'I']));

    (($s.substr(0,2) <= 26) && ($s.substr(2) <= 26)) &&
        @retval.append($s.trans([10..26]=>['J'..'Z'])); 
            
    return @retval.sort;
} 
    
multi sub decode-list( Str $s where 
    $s ~~ /^<[1..9]>+$/ && $s.chars > 4 ) {

    my @retval;
    
    loop (my $ctr=0; $ctr <= $s.chars; $ctr+=3) {
        push @retval, (decode-list($s.substr($ctr,4)));
    }

    return @retval;
}
