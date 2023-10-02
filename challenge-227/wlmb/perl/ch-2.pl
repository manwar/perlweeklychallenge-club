#!/usr/bin/env perl
# Perl weekly challenge 227
# Task 2:  Roman Maths
#
# See https://wlmb.github.io/2023/07/24/PWC227/#task-2-roman-maths
use v5.36;
use experimental qw(try);
use POSIX qw(floor);
use List::Util qw(sum);
my %ops=   # generate code for several binary operators
    map{$_ => eval "sub(\$x, \$y){\$x $_ \$y}"}
    qw(+ - * / ** %);

die <<~"FIN" unless @ARGV;
    Usage: $0 "x1 op1 y1" ["x2 op2 y2"...]
    to perform operations op_n between pairs numbers x_n and y_n expressed
    in Roman numerals.
    FIN
for(@ARGV){
    try{say "$_ ->", evaluate($_)}
    catch($e){say "$_ failed: $e"}
}

sub evaluate($exp){
    my ($x, $op, $y)=split " ", $exp;
    die "Undefined operation $op" unless defined $ops{$op};
    my $result=$ops{$op}->(map {toD($_)}($x,$y));
    return $result==0                                ?"nulla"
	:($result>3999||$result<0||$result!=floor $result)?"non potest"
	:toR($result)
}

sub toD($R){ # Roman to decimal
    $R=~/^                 # Identify components
	(M{0,3})           # thousands
        (CM|CD|D?(C{0,3})) # Hundreds
    	(XC|XL|L?(X{0,3})) # tens
	(IX|IV|V?(I{0,3})) # units
     	$/x
    or die "Failed to convert $R to decimal";
    my($FM, $M,$D,$C,$L,$X,$V,$I)=map {$_//""} (undef, $1,$2,$3,$4,$5,$6,$7);
    my $result=	sum map {
	    my ($fives, $ones, $mult,$nine, $four, $five)=@$_;
	    local $_=$fives;
	    $mult*((m/^$nine/?9:m/^$four/?4:m/^$five/?5:0)+split "",$ones);
    } (
	    [$FM,$M, 1000, qr/MX/, qr/MX/, qr/X/],
	    [$D, $C,  100, qr/CM/, qr/CD/, qr/D/],
	    [$L, $X,   10, qr/XC/, qr/XL/, qr/L/],
	    [$V, $I,    1, qr/IX/, qr/IV/, qr/V/],
    );
    return $result; #$thousands+$hundreds+$tens+$units;
}

sub toR($N){
    return "non potest" if $N>3999 or $N < 0 or $N!=floor $N; # too large, negative, non integer
    return "nulla" if $N==0;
    return
	join "",
	map {
	    my ($div, $nine, $five, $four, $one)=@$_;
	    my $n=($N%(10*$div))/$div;
	    my $r0=$n>=9?$nine:$n>=5?$five:$n>=4?$four:"";
            $n%=5;
	    my $r1=$n<4? $one x $n: "";
	    "$r0$r1";
    }
    (
     [1000, "MX", "X", "MX", "M"],
     [ 100, "CM", "D", "CD", "C"],
     [  10, "XC", "L", "XL", "X"],
     [   1, "IX", "V", "IV", "I"],
    )
}
