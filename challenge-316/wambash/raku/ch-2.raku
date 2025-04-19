#!/usr/bin/env raku

sub subsequence ($str1, $str2) {
    my $a = (
       $str1
       andthen .comb
       andthen .map: { q{ <[\qq{$_}]> <-[\qq{$_}]>* } }\
       andthen .join
    );

    $str2.contains: /<$a>/
}

multi MAIN (Bool :test($)!) {
    use Test;
    is subsequence('uvw', 'bcudvew'),True;
    is subsequence('aec', 'abde'),False;
    is subsequence('sip', 'javascript'),True;
    done-testing;
}

multi MAIN ($str1, $str2) {
    say subsequence $str1, $str2
}
