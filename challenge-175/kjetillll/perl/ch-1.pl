#!/usr/bin/perl
use Time::Local;
my $y = shift || 1900+(localtime)[5];
for my $m (1..12){
    for(reverse 1..31){
	is_sunday($y,$m,$_) and printf("%04d-%02d-%02d\n", $y, $m, $_) and last
    }
}

sub is_sunday{ my($y,$m,$d)=@_; (eval{ timegm(0,0,0,$d,$m-1,$y) } / 86400 - 3) % 7 == 0 }
