#!/bin/env raku

unit sub MAIN(*@seq);

my %chars = 'a'..'z' Z=> 1..26;
my %ords  = 1..26 Z=> 'a'..'z';
#put %chars.raku;

my $ndx = @seq.first('?', :k);
my @num = %chars{@seq};
for 1..26 -> $i {
    @num[$ndx] = $i;
    my @diff = @num[1..*] Z- @num[0..*-1];
    if @diff[0] == @diff[2] && @diff[1] == @diff[3] {
        put %ords{ @num[$ndx] };
    }
}
