#!/usr/bin/env raku

for <1122234 2333445 12345> -> $N  {
    my @numbers = $N.split('', :skip-empty);
    my $initial = @numbers.shift;
    my ( $enum , $count ) = ( '', 1 ); 
    for @numbers {
      when $initial { $count++ }
      default {
        $enum ~= $count.Str ~ $initial;
        ( $count , $initial ) = ( 1, $_); 
      }
    }
    $enum ~= $count.Str ~ $initial.Str;
    say 'Input: $N = ' ~ $N;
    say "Output: $enum \n";
}
