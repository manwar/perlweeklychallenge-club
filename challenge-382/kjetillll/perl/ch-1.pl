# https://theweeklychallenge.org/blog/perl-weekly-challenge-382/
use strict; use warnings;

my %companionN = map {my $n = $_; $n=>{map{ my $x=$_; $x => [ grep $x != $_ && is_square( $x + $_ ), 1..$n ] } 1..$n} } 1..64;

sub is_square { my $r = sqrt( $_[0] ); $r == int $r }

sub hamcyc {  #returns all cycles of length n, array of arrayrefs
    my($n, $seen, @lst) = @_;
    @_   == 1  ? hamcyc(@_, 1 << 1, 1) :
    @lst == $n ? is_square( $lst[0] + $lst[-1] ) ? \@lst : () :
                 map hamcyc($n, $seen | 1 << $_, @lst, $_),
                 grep !( $seen & 1 << $_ ),
	         @{ $companionN{ $n }{ $lst[-1] } }
}


#---------- tests
sub array_eq_one_of_arrays {
    my($array, @arrays)=@_;
    print "len: ".@$_."   @$_\n" for @arrays; 
    !@$array && !@arrays || grep "@$array" eq "@$_", @arrays
}
my $n; $n= shift@$_, print array_eq_one_of_arrays($_, hamcyc($n)) ? "ok\n" : "ERROR\n" for
(map [ $_ => () ], 1..31),
[ 32 => qw(1 8 28 21 4 32 17 19 30 6 3 13 12 24 25 11 5 31 18 7 29 20 16 9 27 22 14 2 23 26 10 15) ],
[ 33 => qw(1 8 28 21 4 32 17 19 30 6 3 13 12 24 25 11 5 20 29 7 18 31 33 16 9 27 22 14 2 23 26 10 15) ],
[ 34 => qw(1 8 28 21 4 32 17 19 6 30 34 15 10 26 23 2 14 22 27 9 16 33 31 18 7 29 20 5 11 25 24 12 13 3) ],
[ 35 => qw(1 3 6 19 30 34 2 7 18 31 33 16 9 27 22 14 11 25 24 12 13 23 26 10 15 21 28 8 17 32 4 5 20 29 35) ],
