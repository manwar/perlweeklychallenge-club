Solutions by James Smith.

# Challenge 1 - Count Set Bits

This is a really interesting challenge - there is a really quick naive solution which is to do the
counting - but that is an O(n log(n)) problem so as n gets large (to values where the modulus
calculation is required) then this gets very slow.

There is an O(log(n)) solution which means breaking the sums into chunks which are easy to sum.

For the numbers 1 .. (2^n-1) you can see that the sum of the bits is n(2^n)/2

[ There are 2^n numbers (including 0) and you can represent number in n bits, and exactly half of the bits are 1 ]

We can then use this to work out the sums of the bit counts..

First we get a bit representation of "$i+1"

so e.g. for i = 22 - the array is 1 0 1 1 1

Loop through the bits and use the count method above to count the lower bits
of each group (ignore any where the value in the bit array is 0)
The higher bits are counted by multiplying the size of the group by the bits
in the "higher bit" e.g. 16, 20, 22 below... What we note though is that this
number increases by 1 each time that we loop through the array

So in the example above the chunks become:

```
 1..15 - split this into 16 x "0"  & 0..15  - total is 2^4 * 0 + 4(2^4)/2 = 32
16..19 - split this into  4 x "16" & 0..3   - total is 2^2 * 1 + 2(2^2)/2 =  8
20..21 - split this into  2 x "20" & 0..1   - total is 2^1 * 2 + 1(2^1)/2 =  5
22     - split this into  1 x "22" & 0      - total is 2^0 * 3 + 0(2^0)/2 =  3
                                                                            48
```

# Challenge 2 - trapped rain water

Much simpler challenge this time - we just need to work out how much water is trapped.
So for any column we need to work out the maximum height of rocks to the left and right
of the column, if neither of these are higher than the height of the current column no
water is trapped. Otherwise the amount of water is trapped is the minimum of these two
values minus the height of the column.

To enhance the image - I've also added "~~"s to indicate where the water is trapped
