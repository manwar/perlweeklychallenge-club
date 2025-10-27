#!/usr/bin/env raku
use v6.e.PREVIEW;
use Test;

is-deeply last-visitor(<5 -1 -1>),           [<5 -1>];
is-deeply last-visitor(<3 7 -1 -1 -1>),      [<7 3 -1>];
is-deeply last-visitor(<2 -1 4 -1 -1>),      [<2 4 2>];
is-deeply last-visitor(<10 20 -1 30 -1 -1>), [<20 30 20>];
is-deeply last-visitor(<-1 -1 5 -1>),        [<-1 -1 5>];

my @arr = (-1 xx 1000, 1..1000).flat.roll(10_000);
is-deeply last-visitor(@arr), last-visitor-alternate(@arr);

sub last-visitor(@ints)
{
    my @seen;
    my @snip = @ints.snip: flat (@ints.head > 0 ?? (* > 0, * == -1) !! (* == -1, * > 0)) xx *;
    my @ans.append: @snip.shift.flat if @snip.head.head == -1;
    @snip.pop if @snip.tail.tail > 0;

    for @snip -> @pos, @neg-ones
    {
        @seen.append: @pos;
        @ans.append:  flat (reverse @seen.tail: @neg-ones), @neg-ones.tail: @neg-ones - @seen
    }

    return @ans
}
 
sub last-visitor-alternate(@ints)
{
    my $x = 0;
    my @seen;
    my @ans;

    for @ints -> $i
    {
        if $i.sign == 1
        {
            $x = 0;
            @seen.unshift: $i
        }

        else
        {
            @ans.push: @seen[$x] // -1;
            $x++
        }
    }

    return @ans
}
