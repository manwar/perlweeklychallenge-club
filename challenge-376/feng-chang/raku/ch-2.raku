#!/bin/env raku

unit sub MAIN(Str:D $essay is copy);

my regex Tag { '</B>' || '\n' };
$essay .= subst(/:m <|w> (\w+) ([\s+ || <Tag>]+) (\w+) <|w> <?{ $0.lc eq $2.lc }>/, { "[$0]{$1}[$2]" });
my @e = $essay.split('\n');

my $first-line = True;
for |(|^+@e, |(^(+@e-1) Z 1..(+@e-1))).first({
        my %h = @e[|$_].join.comb.Bag;
        (%h<[> // 0) == 2 && (%h<]> // 0) == 2
    }) -> $i {
        last unless $i.defined;

        if $first-line {
            $first-line = False;
        } else {
            print '\n';
        }
        print @e[$i];
}
put '';
