#!/usr/bin/env raku
use Benchy;

my $string = [~] gather for ^100
{
    my $n = (1..100).pick;
    my @chars = ('a'..'z').Array.roll($n);
    take [~] @chars;

    $n = (1..100).pick;
    my @digits = (^10).Array.roll($n);
    take [~] @digits
}

# 😭 😭 😭 😭 😭

b 10, { replace-digits-old($string) }, 
      { replace-digits-new($string) } 

# Bare: 0.000041032s
# Old:  1.344218988s
# New:  5.990887955s
# OLD version is 4.46x faster
 
sub replace-digits-old($s)
{
    my $last-c;
    
    [~] gather for $s.comb -> $c 
    {
        if $c ~~ 0..9 
        { 
            take chr($last-c.ord + $c) 
        }

        else   
        { 
            $last-c = $c; 
            take $c         
        }
    }
}

sub replace-digits-new($s)
{
    my ($head, $tail) = $s.split(/ <.alpha>+ $ /, :v);

    my @result = do for $head.split(/ <.digit>+ /, :v:skip-empty).batch(2)
    {
        my $char  = .head ~~ / <.alpha> $ /;
        .head ~ [~] .tail.comb.map({ chr($char.ord + $_) })
    }

    ([~] @result) ~ ($tail or Empty)
}
