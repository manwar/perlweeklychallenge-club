#!/usr/bin/env raku
use Lingua::EN::Numbers;

sub four-is-magic(Int $n is copy){
  my @arr;
  my $len = cardinal($n).chars;
  repeat {
    push @arr, cardinal($n) ~ ' is ' ~ cardinal($len);
    $n = $len;
    $len = cardinal($n).chars;
  }until ($n == 4);
  push @arr, 'four is magic.';
  return tclc join ', ', @arr;
}

sub MAIN(Int $num)
{
    if $num > 9 {
	note "argument must be less than 10!";
	exit 1;
    }
    put four-is-magic($num.Int);
}
