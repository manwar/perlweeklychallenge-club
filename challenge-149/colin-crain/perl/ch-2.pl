#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       big-ole-p-square.pl
#
#         Largest Square
#         Submitted by: Roger Bell_West
# 
#         Given a number base, derive the largest perfect square with no
#         repeated digits and return it as a string. 
#         (For base>10, use ‘A’..‘Z’.)
# 
#         Example:
#             f(2)="1"
#             f(4)="3201"
#             f(10)="9814072356"
#             f(12)="B8750A649321"
#
#     in base 13: CC5244 squared is CBA504216873

#     found 198003269696 squared is: 3.92052948103069e+22
#     in base 18: HH79A9GDE squared is HGF1937D5B4E06A8C2
#     real	22m8.960s
#     user	16m5.258s
#     sys	3m7.834s

#     found 1404376502502 squared is: 1.97227336077975e+24
#     in base 19: 46D2400C25 squared is IHGD2B086517E3ACF94
#     real	82m49.393s
#     user	82m38.563s
#     sys	0m2.744s


#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $base = shift // 12;

decrements ( $base );
# constructive( $base );  <-- to call the constructive permutations method


## decrementing solution:
## from the square root of the largest base-digit number
## square and check for repeating digits pass/fail
sub decrements  ( $base ) {
    my @alpha   = ( 0..9, "A".."Z" );
    my $maxbase = join '', reverse @alpha[0..$base-1];
    my $max     = int sqrt(base2dec( $maxbase, $base));
    say "decrementing from $max";

    my %h;
    MAX: while ($max--) {
        %h = ();
        ## inlined convert square to base and detect repeats code
        my $num = $max * $max;
        while ( $num > 0  ) {
            ++$h{$num % $base} > 1 and next MAX ;
            $num = int( $num/$base ); 
        }
        
        ## print result found
        say "found $max squared is: ", $max * $max;
        my $bout   = dec2base( $max, $base );
        my $bsqout = dec2base( $max * $max, $base );
        say "in base $base: $bout squared is $bsqout";
        last;
    }
}


sub repeats ( $num ) {
## checks for repeating digits pass/fail
    my %h;
    ++$h{$_} > 1 and return 1 for split //, $num ;
    return 0;
}

sub dec2base ( $num, $base ) {
## converts from base-10 to base-n : n = 2..36
    my @alpha = ( 0..9, "A".."Z" );
    my $rem; 
    my $val = '';
    while ( $num > 0  ) {
        ($num, $rem) = (int( $num/$base ), $num % $base);   
        $val = $alpha[$rem] . $val;
    }
    return $val;
}

sub repeats_in_base ( $num, $base ) {
## combined dec2base + repeats code, pass/fail
    my %h;
    while ( $num > 0  ) {
        ++$h{$num % $base} > 1 and return 1 ;
        $num = int( $num/$base ); 
    }
}

sub base2dec( $num, $base ) {
    my %alpha;
    my $n ;
    $alpha{$_} = $n++ for ( 0..9, "A".."Z" );
    my $out;
    my $pos = 0;
    for ( reverse split //, $num ) {
        $out += $alpha{$_} * $base ** $pos++;
    }
    return $out;
}


### constructing complete solutions from all digits in base 
### and testing for squareness

sub constructive ( $base ) {
    use Algorithm::Combinatorics qw( permutations );

    my @arr = reverse (0..$base-1);
    my $iter = permutations( \@arr );
    my $c;
    my $dec;
    say "permuting @arr";

    while (my $p = $iter->next) {
        $dec = perm2dec( $p, $base );
        my $sq = int sqrt $dec;
        last if $sq * $sq == $dec;    
    }
    
    say "constructive:";
    say "found $dec" ;
    my $bout = dec2base( $dec, $base );
    say "in base $base: $bout";
}

sub perm2dec ( $arr, $base ) {
    my $out;
    my $pos = 0;
    for ( reverse $arr->@* ) {
        $out += $_ * $base ** $pos++;
    }
    return $out;
}


