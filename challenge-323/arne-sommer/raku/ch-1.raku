#! /usr/bin/env raku

unit sub MAIN (*@operations where @operations.elems > 0
                 && all(@operations) eq any('++x', 'x++', '--x', 'x--'),
               :v(:$verbose));

my %val = ( '++x' => 1, 'x++' => 1, '--x' => -1, 'x--' => -1 );

my @val = @operations.map({ %val{$_} });

say ": Values: { @val.join(", ") }" if $verbose;

say @val.sum;
