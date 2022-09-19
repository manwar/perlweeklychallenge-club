# Finds .head(19) in under 1 second; 100x speedup compared to other methods.

# IMPORTANT: I do not understand this algorithm!
# Perhaps you can understand it if you spend more time than I did reading:
#   https://github.com/rgxgr/Disarium-Numbers/blob/master/README.md

# This code was copied by Bruce Gray
# from https://github.com/rgxgr/Disarium-Numbers/blob/master/Disarium.c ,
# translated into Raku, and refactored into constant+gather form.
# I also partially refactored into idiomatic Raku, but could not nearly
# eliminate the "C language accent".

# I think the code is doing (among other optimizations) an elaborate form of this Number Theory analysis:
# raku -e 'for 1..25 -> $n { say "$n : ", ( ( (10 ** ($n-1)) - ( 9 X** (1..^$n)).sum ) ** (1/$n)).ceiling }'
# Examining that table, we can conclude:
# A final digit of 0|1|2 can only happen in 1-digit and 2-digit numbers.
# For numbers between  7 and  8 digits, the final digit must be 7|8|9.
# For numbers between  9 and 12 digits, the final digit must be 8|9.
# For numbers between 13 and 22 digits, the final digit must be 9.
#       (This removes 90% of the search space by itself!)
# No number larger that 22 digits can be a Disarium number;
#       9ⁿ is outpaced against 10ⁿ too much for all the 9-power-sums of prior digits to make up for.

constant @Disarium = gather {
    constant DMAX = 22; # Max # of digits

    # Pre-calculated exponential & power serials
    constant @EXP = 0 xx 10, |map { 0..9 X*  (10 ** $_) }, ^DMAX;
    constant @POW = 0 xx 10, |map { 0..9 X** ( 1 +  $_) }, ^DMAX;

    # Element [10] of @EXP and @POW were special-purposed in the original C code.
    # I separated those elements into their own arrays here.
    constant @EXP10 = map { 10 ** $_ }, ^DMAX;
    constant @POW10 = [\+] @POW».[9];

    # Digits of candidate and values of known low bits
    my Int @DIGITS = 0 xx (DMAX + 1);  # Digits form
    my Int @Exp    = 0 xx (DMAX + 1);  # Number form
    my Int @Pow    = 0 xx (DMAX + 1);  # Powers form

    for 1 .. DMAX -> $digit {
        # say "# of digits: $digit";

        my Int $level = 1;
        @DIGITS[0] = 0;
        loop {
            # Check limits derived from already known low bit values
            # to find the most possible candidates
            while $level ~~ 0 ^..^ $digit {
                # Reset path to try next if checking in level is done
                if  @DIGITS[$level] > 9 {
                    @DIGITS[$level] = 0;
                    $level--;
                    @DIGITS[$level]++;
                    next;
                }

                # Update known low bit values
                @Exp[$level] = @Exp[$level - 1] + @EXP[             $level][ @DIGITS[$level] ];
                @Pow[$level] = @Pow[$level - 1] + @POW[$digit + 1 - $level][ @DIGITS[$level] ];

                # Max possible value
                my Int $pow = @Pow[$level] + @POW10[$digit - $level];

                if $pow < @EXP[$digit][1] {  # Try next since upper limit is invalidly low
                    @DIGITS[$level]++;
                    next;
                }

                my Int $max;
                {
                    my Int $short_pow = $pow % @EXP10[$level];
                    $pow -= $short_pow;
                    $pow -= @EXP10[$level] if $short_pow < @Exp[$level];
                    $max  = $pow + @Exp[$level];
                }
                if $max < @EXP[$digit][1] {  # Try next since upper limit is invalidly low
                    @DIGITS[$level]++;
                    next;
                }

                # Min possible value
                my Int $exp = @Exp[$level] + @EXP[$digit][1];
                $pow = @Pow[$level] + 1;

                if $max < $exp or $max < $pow { # Try next since upper limit is invalidly low
                    @DIGITS[$level]++;
                    next;
                }

                my Int $min;
                if $pow > $exp {
                    my Int $short_pow = $pow % @EXP10[$level];
                    $pow -= $short_pow;
                    $pow += @EXP10[$level] if $short_pow > @Exp[$level];
                    $min  = $pow + @Exp[$level];
                }
                else {
                    $min  = $exp;
                }

                # Check limits existence
                if $max < $min {
                    @DIGITS[$level]++;  # Try next number since current limits invalid
                }
                else {
                    $level++;  # Go for further level checking since limits available
                }
            }

            # All checking is done, escape from the main check loop
            last if $level < 1;

            # Final check last bit of the most possible candidates
            # Update known low bit values
            @Exp[$level] = @Exp[$level - 1] + @EXP[             $level][ @DIGITS[$level] ];
            @Pow[$level] = @Pow[$level - 1] + @POW[$digit + 1 - $level][ @DIGITS[$level] ];

            # Loop to check all last bit of candidates
            while @DIGITS[$level] < 10 {
                # Found a new Disarium number
                take +@DIGITS.skip.reverse.join if @Exp[$level] == @Pow[$level];

                # Go to followed last bit candidate
                @DIGITS[$level]++;
                @Exp[$level] += @EXP[$level][1];
                @Pow[$level]++;
            }

            # Reset to try next path
            @DIGITS[$level] = 0;
            $level--;
            @DIGITS[$level]++;
        }
    }
}
say @Disarium.head(19);

use Test;
plan 1;
constant @A032799 = 0,1,2,3,4,5,6,7,8,9,89,135,175,518,598,1306,1676,2427,2646798,12157692622039623539;
is @Disarium.head(@A032799.elems - 1), @A032799.head(*-1),
    'https://oeis.org/A032799 (without final element)';

# Bonus; This would take many hours, but should work.
# is @Disarium[19], @A032799.tail, 'A032799 (final element; 20-digits!)';
