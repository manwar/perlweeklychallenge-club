#!/usr/bin/env raku

use Test;

# Leading zeroes are ignored.

multi sub MAIN {
    for << 

           #example tests
           0.1   < 1.1    -1
           2.0   > 1.2     1
           1.2   < 1.2_5  -1
           1.2.1 > 1.2_1   1
           1.2.1 = 1.2.1   0

           #more tests 
           1.2.1   < 1.11.1    -1
           1.2_2   < 1.2_11    -1
           001.2_3 = 1.2_03     0
           1.0     < 10        -1

        >> -> $str1, $sign, $str2, $result {

        ok compare($str1, $str2) == $result, 
                sprintf "%8s %s %-8s %2s\n", $str1, $sign, $str2, $result; 
    }

    done-testing;
}

multi sub MAIN (*@args where (.elems == 2 and .all ~~ /^ [\d+]+ % <[._]> $/)) {
    my %sign =  0 => "=", 
               -1 => "<", 
                1 => ">";

    my $result = compare(@args[0], @args[1]);
        
    printf "%s %3s\n", "@args[0] %sign{$result} @args[1]", $result;
}

sub compare(Str $str1, Str $str2) {
    my @str1 = $str1.comb(/\d+|\.|_/);
    my @str2 = $str2.comb(/\d+|\.|_/);

    my @elems = @str1 Z @str2;

    my $result;

    for @elems -> ($e1, $e2) {
        $result = compare_elems($e1, $e2);
        last unless $result == 0;
    }

    if $result == 0 {
        if @str1 > @str2 { $result =  1 }
        if @str1 < @str2 { $result = -1 }
    }

    $result;
}

sub compare_elems(Str $e1, Str $e2) {
    given $e1 {
        when /\d+/ {
            given $e2 {
                when /\d+/ { +($e1.subst(/^0+(\d+)$/, { $0 })
                               <=> 
                               $e2.subst(/^0+(\d+)$/, { $0 })) }
                when "."   { 1 }
                when "_"   { 1 }
            }
        }
        when "."  {
            given $e2 {
                when /\d+/ { -1 }
                when "."   {  0 }
                when "_"   {  1 }
            }
        }
        when "_"  { 
            given $e2 {
                when /\d+/ { -1 }
                when "."   { -1 }
                when "_"   {  0 }
            }
        }
    }
} 
