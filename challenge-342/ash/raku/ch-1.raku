# Task 1 of the Weekly Challenge 342
# https://theweeklychallenge.org/blog/perl-weekly-challenge-342/#TASK1

say balance-string('a0b1c2'); # 0a1b2c
say balance-string('abc12'); # 0a1b2c
say balance-string('0a2b1c3'); # 0a1b2c3
say balance-string('1a23'); # ''
say balance-string('ab123'); # 1a2b3

# Extra case with 3 letters and 3 digits
say balance-string('abc123'); # 1a2b3c


sub balance-string($s) {
    my @digits = $s.comb(/\d/).sort;
    my @letters = $s.comb(/<[a..z]>/).sort;

    # It's only possible to balance a string if
    # the number of digits and letters differs by not more than 2.
    if ((@digits.elems - @letters.elems).abs > 1) {
        return '';
    }
    elsif (@digits.elems == @letters.elems) {
        # Assuming that alphabetical sort puts digits first
        return [~] (@digits Z~ @letters);
    }

    # Now the two cases where the size is different, but the
    # difference of sizes is always 1 here. So appending the extra character.
    elsif (@digits.elems > @letters.elems) {
        return ([~] (@digits Z~ @letters)) ~ @digits[*-1];
    }
    else {
        return ([~] (@letters Z~ @digits)) ~ @letters[*-1];
    }
}
