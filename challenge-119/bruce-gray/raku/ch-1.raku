#!/usr/bin/env raku
# Simplest solution, from the C language mindset.
multi sub nib ( Int $n where ^256 ) {
    return ( ($n +& 0xF0) +> 4 )
         + ( ($n +& 0x0F) +< 4 );
}
# Swap pairs of nybbles within each byte, for any size.
multi sub nib ( Int $n where * >= 0 ) {
    my Str $hex = $n.base(16);
    $hex [R~]= '0' if $hex.chars !%% 2; # append/prepend
    return $hex.comb(2)».flip.join.parse-base(16);
}

multi sub MAIN ( *@n ) {
    say $_, " ==> ", .&nib for +«@n;
}
multi sub MAIN ( ) {
    # All numbers written in hex, to make clearer the correctness of the expected transformation.
    # The Raku and Perl tests differ for >=256, since they different interpretations what it means to expand the problem past 256.
    constant @tests =
        0x65 => 0x56, # 101 ==>  86
        0x12 => 0x21, #  18 ==>  33
         0x1 => 0x10,
           0 =>    0,
        0xDeadBeef => 0xEddaEbfe,
        # Larger than  64-bits; # Even and odd number of nybbles.
        0x19_Efface_Decade_Facade => 0x91_Feafec_Edaced_Afaced,
         0x9_Efface_Decade_Facade => 0x90_Feafec_Edaced_Afaced,

        # Larger than 128-bits; # Even and odd number of nybbles.
        0x19_BeefCafe_FeedFace_BeefCafe_FeedFace => 0x91_EbfeAcef_EfdeAfec_EbfeAcef_EfdeAfec,
         0x9_BeefCafe_FeedFace_BeefCafe_FeedFace => 0x90_EbfeAcef_EfdeAfec_EbfeAcef_EfdeAfec,
    ;
    use Test;
    plan 2*@tests;
    is nib(.key), .value, "nib {.key.fmt('%3d')} ==> {.value.fmt('%3d')}" for |@tests, |@tests>>.antipair;
}
