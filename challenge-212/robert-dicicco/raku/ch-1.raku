#!/usr/bin/env raku
#`{
---------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-04-10
Challenge 212 Jumping Letters ( Raku )
---------------------------------------
}

my $word = 'Perl';
my @jump = (2,22,19,9);

#my $word = 'Raku';
#my @jump = (24,4,7,17);

my @alphabet = <a b c d e f g h i j k l m n o p q r s t u v w x y z>;

say "Input: \$word = $word and \@jump = ",@jump;

print "Output: ";

for (0..^$word.chars) -> $n {
    my $ndx = @alphabet.first(substr($word,$n,1).lc, :k);
    $ndx += @jump[$n];
    $n == 0 ?? print @alphabet[$ndx % 26].uc !! print @alphabet[$ndx % 26];
}

#`{
---------------------------------------
SAMPLE OUTPUT
raku .\Jumping.rk
Input: $word = Perl and @jump = [2 22 19 9]
Output: Raku

raku .\Jumping.rk
Input: $word = Raku and @jump = [24 4 7 17]
Output: Perl
---------------------------------------
}





