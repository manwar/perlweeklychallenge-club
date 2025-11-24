#!/usr/bin/perl ;
use strict ;
use warnings ;
use feature 'say' ;

sub down {
    my $point = shift ;
    my @result = ( $point->[0] , $point->[1] - 1 ) ;
    return @result ;
}

sub up {
    my $point = shift ;
    my @result = ( $point->[0] , $point->[1] + 1 ) ;
    return @result ;
}

sub left {
    my $point = shift ;
    my @result = ( $point->[0] - 1 , $point->[1] ) ;
    return @result ;
}

sub right {
    my $point = shift ;
    my @result = ( $point->[0] + 1 , $point->[1] ) ;
    return @result ;
}

say "Enter a sequence of letters U , D , L or R!" ;
my $motions = <STDIN> ;
chomp $motions ;
my %movedirs = ( 'U' => \&up , 'D' => \&down , 'L' => \&left , 'R' =>
        \&right ) ;
my @start = (0 , 0) ;
my @current = (0 , 0 ) ;
for my $c ( split( // , $motions ) ) {
   @current = $movedirs{$c}->(\@current) ;
}
if ( $current[0] == 0 && $current[1] == 0 ) {
    say "true" ;
}
else {
    say "false" ;
}
   
