#!/usr/bin/perl
use strict; use warnings; use v5.10;


test() and exit if join('',@ARGV) eq '-t';


my $n = shift() // 5724;
say is_damm_valid($n);


sub is_damm_valid {
    state $t = '0317598642709215486342068713591750983426612304597836742095815869720134894536201794386172052581436790';
    my($n,$i)=(@_,0);
    $n=~s/^.//                                  #if digits left, gnaw off one into $&
    ? is_damm_valid($n, substr($t,$i*10+$&,1))  #...and recurse with new shorter $n and new $i from table $t
    : 0+!$i                                     #when no digts left, i==0 returns 1/true/valid
}


sub test {
    require Digest::MD5;
    say Digest::MD5::md5_hex(join(' ',grep is_damm_valid($_), 1000..99999))
	eq '269ee57d90924f446b640bc8d32f7ac5' ? 'ok' : 'ERROR';
}


__END__
# https://theweeklychallenge.org/blog/perl-weekly-challenge-177/
# https://en.wikipedia.org/wiki/Damm_algorithm
