#!/usr/bin/env perl6
#
#
#       .raku
#
#
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



unit sub MAIN ( $num is copy = 20 ) ;

my @names = qw< 
    one	        two	        three	    four	    five	    
    six	        seven	    eight	    nine	    ten	        
    eleven	    twelve	    thirteen	fourteen	fifteen	    
    sixteen	    seventeen	eighteen	nineteen	twenty	  >;

my %d2n = @names.keys.map: {$_+1 => @names[$_]};
my $out;

loop {
    $out ~= "%d2n{$num} is ";
    $out ~= "magic" and last if $num == 4 ;
    $out ~= %d2n{ %d2n{$num}.chars } ~ ', ';
    $num  = %d2n{$num}.chars ;
}

$out.put;
