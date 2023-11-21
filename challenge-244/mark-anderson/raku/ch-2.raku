#!/usr/bin/env raku
use Test;
use Benchy;

is group-hero(2,1,4), 141;

benchmark();

# say group-hero((1..20).roll(10000));
# takes about 1 minute and 40 seconds on my computer.

sub group-hero(*@a)
{
    my %h;
    my $b = @a.Bag;

    $b.keys.map(-> $k { %h{$k} = 2 ** $b{$k} - 1 });        
    sum $b.keys.combinations.skip.map({ ([*] %h{$_}) * .max² * .min })
}

sub group-hero-slow(*@a)
{
    sum @a.combinations.skip.map({ .max² * .min })
}

sub benchmark
{
    my @a = 5,5,5,9,4,4,2,2,2,2,7,7,7,7,7,8,9,2,2,1;

    b 1,
    { say group-hero-slow(@a) },
    { say group-hero(@a)      }

    # Old:  45.791410967s
    # New:  0.020774281s
    # NEW version is 2204.24x faster
}    
