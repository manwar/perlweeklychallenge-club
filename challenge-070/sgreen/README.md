# Perl Weekly Challenge 070

Solution by Simon Green.

 
## TASK #1 › Character Swapping

For this I used the fact that `($a, $b) = ($b, a)` does what it should. Therefore it was a simple exercise of  doing this for `$C` times, and then display the output.

The task states that `$C + $O <= $O`. This however is not possible. When `$C + $O = $N`, you will get a `substr outside of string` error. For this reason, I've only allowed `$C + $O < $N` to be valid.

### Example

    » ./ch-1.pl perlandraku 3 4
    pndraerlaku

    » perl/ch-1.pl helloworld 8 1
    hlloworlde

## TASK 2 › Gray Code Sequence

Not really much to say about this task, as it is string forward. Given that `$N` can not be greater than five, I simply stored the array in memory. Even at 24 bits, it will run without any issues.

## Example

    » ./ch-2.pl 4
    0 1 3 2 6 7 5 4 12 13 15 14 10 11 9 8
