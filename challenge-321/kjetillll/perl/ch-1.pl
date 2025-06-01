use warnings; use strict; use List::Util 'uniq';

#----four alternatives:

sub f1 {
    my @n = sort { $a <=> $b } @_;
    my %avg; $avg{ ( shift(@n) + pop(@n) ) / 2 }++ while @n >= 2;
    0 + keys %avg
}

sub f2 {
    my($n,$h)=(@_,{});
    !ref$n ? f2( [ sort { $a <=> $b } @_ ] )
    :@$n   ? f2( [ @$n[ 1 .. $#$n-1 ] ], { %$h, $$n[0] + $$n[-1] => 1 } )
           : +keys %$h
}

sub f3 {
    ! ref $_[0] ? f3( {}, sort { $a <=> $b } @_ )
    : @_ > 2    ? f3( { %{ shift() }, shift() + pop() => 1 }, @_ )
                : +keys %{ shift() }
}

sub f4 {
    my @n = sort { $a <=> $b } @_;
    +keys %{ { map { $n[$_]+$n[-1-$_], 1 } 0 .. $#n/2 } }
}

sub f5 {
    my @n = sort { $a <=> $b } @_;
    0+uniq map $n[$_]+$n[-1-$_], 0 .. $#n/2
}


#----tests
binmode STDOUT, ':encoding(UTF-8)';
my @tests=map{my@i=/\d+/g;{output=>pop@i,input=>\@i}}join('',<DATA>)=~/Input: .*? Output: \d+/gs;
for my $f ( \&f1, \&f2, \&f3, \&f4, \&f5 ){
    print $f->( @{ $$_{input} } ) == $$_{output}
    ? "\N{FIRST PLACE MEDAL}" : "\N{PILE OF POO}"
    for @tests;
}
__DATA__

https://theweeklychallenge.org/blog/perl-weekly-challenge-321/

  Example 1
  Input: @nums = (1, 2, 4, 3, 5, 6)
  Output: 1

    Step 1: Min = 1, Max = 6, Avg = 3.5
    Step 2: Min = 2, Max = 5, Avg = 3.5
    Step 3: Min = 3, Max = 4, Avg = 3.5

    The count of distinct average is 1.

  Example 2
  Input: @nums = (0, 2, 4, 8, 3, 5)
  Output: 2

    Step 1: Min = 0, Max = 8, Avg = 4
    Step 2: Min = 2, Max = 5, Avg = 3.5
    Step 3: Min = 3, Max = 4, Avg = 3.5

    The count of distinct average is 2.

  Example 3
  Input: @nums = (7, 3, 1, 0, 5, 9)
  Output: 2

    Step 1: Min = 0, Max = 9, Avg = 4.5
    Step 2: Min = 1, Max = 7, Avg = 4
    Step 3: Min = 3, Max = 5, Avg = 4

    The count of distinct average is 2.
