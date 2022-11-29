#!/usr/bin/env perl6

our %code-hash;
(0 .. 25).map( {%code-hash{ ('a' .. 'z')[$_]} = (1 .. 26)[$_]} );

#-- not bothering with input validation and exception handling
#-- assume input is conformable list of strings of same length
#-- with exactly one string with the wrong difference array

say &odd-string(["adc","wzy","abc"]); #(abc)
say &odd-string(["aaa","bob","ccc","ddd"]); #(bob)

multi sub difference-array( Str $s ) {
    (1 .. $s.chars-1).map({%code-hash{$s.comb[$_]}-%code-hash{$s.comb[$_-1]}});
}

multi sub difference-array( @s ) {
#returns array of difference arrays
#as well as hash linking each string to its difference array
    my (@retval,%retval);
    for (@s) -> $s {
        my @difference-array=&difference-array($s);
        push @retval, @difference-array;
        %retval{@difference-array.raku} = $s;
    }
    (@retval,%retval);
}

sub my-bag( @difference-array ) { #-- input is array of arrays
    my %retval=();
    for (@difference-array) -> @s {
        %retval{@s.raku}++;
    }
    %retval;
}

multi sub odd-string( %my-bag ) { #-- input is custom bag
    %my-bag.keys.grep({%my-bag{$_}==1});
}

multi sub odd-string( @s ) {
    my @difference-array=&difference-array(@s);
    @difference-array[1]{(&odd-string(&my-bag(@difference-array[0])))};
}

