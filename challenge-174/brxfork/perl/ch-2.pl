#!/usr/bin/env perl

use strict;
use warnings;
use re 'eval';

# Just using regex engine for fun with a pure perl solution.
# Bad method because it enumerates every permutation until the good rank (but funny anyway :)

sub makeregex {
    my ($max) = @_;
    my $regex = "(?m)\\A_*(_*)\n";   # (?m) <=> /m modifier so ^ will match the beginning of the "line" (after each "\n")
    for my $i (1..$max) {
        $regex .= 
            '^_*' . 
            '(?!(?:' .  join('|' , map("\\$_" , 1..$i) ) . ")\n)" .   #  example : (?!(?:\1|\2|\3)\n) => 4th capture must be different from 1st, 2nd, 3rd
            "(_*)\n" ;
    }
    return $regex;
}

sub rank2permutation_index {
    my ($max,$rank) = @_; # $max = 2 <=> [0, 1 , 2] # we only deal with indexes of intergers
    $rank //= -1; # last rank if value is undef
    # construct string 
    my $string = ("_" x $max) . "\n" ; 
    $string x= $max + 1; 
    #  $max = 2 => $string == "__\n__\n__\n" == "__\n" x 3
    
    my @sol; 
    my $regex = makeregex($max);
    $regex .= '(?{push @sol, map {length} @{^CAPTURE} unless $rank })(??{$rank--?"(?!)CONTINUE":"(?!STOP)"})';
    #$regex .= '(?{print join(" ",map length,@{^CAPTURE}),"\n"})(??{$rank--?"(?!)CONTINUE":"(?!STOP)"})';  # enumerate
    # print $regex,"\n",$string,"\n"; #  the gory details
    $string =~ /$regex/;
    return @sol;
}


sub permutation2rank {
    my @list = @_; 
    my $max =  $#list; 
    my $rank = 0;

    # construct string 
    my $string = ("_" x $max) . "\n" ; 
    $string x= $max + 1; 
    #  $max = 2 => $string == "__\n__\n__\n" == "__\n" x 3
    my $fail=1; 
    my $regex = makeregex($max);
    $regex .= '(?{ if ("@list" ne "@{[ map {length} @{^CAPTURE}]}") {$rank++} else {$fail=0} })(??{$fail?"(?!)CONTINUE":"(?!STOP)"})';  # very bad comparaison of lists, but short to write => "@list" ne "@{[ map {length} @{^CAPTURE}]}" 
    #$regex .= '(?{print join(" ",map length,@{^CAPTURE}),"\n"})(??{$rank--?"(?!)CONTINUE":"(?!STOP)"})';  # enumerate
    # print $regex,"\n",$string,"\n"; #  the gory details
    $string =~ /$regex/;
    return $rank;
}

$"=', ';
print "1: [@{[  rank2permutation_index(2,1)  ]}]\n"; # list is 0, 1, 2 ; rank is 1

print "4: [@{[  rank2permutation_index(3,4)  ]}]\n"; # list is 0, 1, 2, 3 ; rank is 4

my @example1 = (2,3,8,9);
print "rank 2 for [@example1]: [@example1[rank2permutation_index($#example1,2)]]\n";  # work on indexes


my @list = (1,0,2);
print "[@list] : rank ",permutation2rank(@list),"\n";

@list = (0,1,2);
print "[@list] : rank ",permutation2rank(@list),"\n";
@list = (0,3,1,2);
print "[@list] : rank ",permutation2rank(@list),"\n";
