#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       fib-sums.pl
#
#       Fibonacci Digit Sum
# 
#         Submitted by: Roger Bell_West
# 
#         Given an input $N, generate the first $N numbers for which the
#         sum of their digits is a Fibonacci number.
# 
#         Example
#         f(20)=[0, 1, 2, 3, 5, 8, 10, 11, 12, 14, 17, 20, 21, 23, 26, 30, 32, 35, 41, 44]

#           6591     <-- 1,000th value
#           13380892 <-- 1,000,000th value
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

my $N = shift // 1081;
my $candidate;
my @out = (0);

while ( ++$candidate ) {
    push @out, $candidate if is_fib( digisum($candidate) );
    last if @out == $N;
}

local $" = ', ';
say "@out";

sub digisum ( $num ) {
    my $sum;
    $sum += substr $num, $_-1, 1 for (1..length $num);
    return $sum;   
}

sub is_fib ( $num ) {
    state @fibs = ( 0, 1 );
    state %fhash = map { $_ => undef } @fibs;
    while ( $fibs[-1]+$fibs[-2] <= $num ) {
        my $next = $fibs[-1]+$fibs[-2];
        push @fibs, $next;
        $fhash{$next} = undef;
    }
    return 1 if exists $fhash{$num};
    return 0;
}

