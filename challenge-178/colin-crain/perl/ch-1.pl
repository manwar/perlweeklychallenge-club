#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       imaginary-quartet.pl
#
#       Quater-imaginary Base
#         Submitted by: Mohammad S Anwar
#         Write a script to convert a given number (base 10) to
#         quater-imaginary base number and vice-versa. For more
#         informations, please checkout wiki page.
# 
#         For example:
# 
#             $number_base_10 = 4
#             $number_quater_imaginary_base = 10300

#         Background:
# 
#         Wow. well this has been a wild ride. I laughed, I cried. I looked
#         at the page and reread what I had in front of me again. I found
#         other sources and periphrial topics. I hunted down Knuth's
#         original and read that. It's really such an... interesting piece
#         of math.
# 
#         As it is, some of our previous efforts here at the PWC have
#         introduced me to various ideas in alternate bases. From the very
#         beginning in PWC we converted to base-35. You know what would
#         make a really interesting numbering system? Using prime numbers:
#         you could describe any number by the exponent values in its prime
#         factorization, with the primes each assigned positions. Or
#         Fibonacci numbers. Yes you can construct an insane numbering
#         system from them too.
# 
#         Today we have a brace of novel ideas that link together. THe
#         first is the idea of negative bases. If the base is negative,
#         than in a positional expansion:
# 
#         xyz = x * base^2 + y * base^1 + z * base^0
# 
#         every other value will wind up negative, and hence be subtracted.
#         This, interestingly enough, allows us to write negative values
#         without designating a special sign for them. 

#         This leads us to base (-2), or negabinary, which because of the
#         aforementioned property is occationally of interest to comuter
#         scientists who are sick of twos-complement for one reason orr
#         another. It's intriguing in a number of ways, and has soem
#         interesting properties, but never much caught on in computing.
# 
#         More immediate to the task at hand is base (-4), or
#         negaquaternary. Having four available values for each digit does
#         condense things a bit. We'll be using this later.
# 
#         Wait what? Why, for all that is good and holy, WHY?
# 
#         Because Donald Knuth wasn't satisfied with simply toying around in
#         negabinary, I suppose, and wanted to take matters into a
#         different dimension. Off the line, that is, up and into the complex plane.
# 
#         Complex numbers are constructed from two values, a real and an
#         imaginary component. The real part is just a number as we know
#         it, but the imaginary part is a real number multipllied by the
#         square root of negative 1, denotated *i*.
# 
#         Imaginary numbers, as it works out, can be an extremely useful
#         idea.
# 
#         So what we're talking about here is really just the same
#         conceptualization of negative bases mapped on over. How, you ask?
#         By making the base 2i.
# 
#         As i * i = -1, every other position in a positional expansion
#         here is real, as well as negative. However every other real
#         position will be a negative number squared, and hence will be
#         positive. The imaginary comonents follow the same alternating
#         pattern as well.
# 
#         So in the same way that by alternately adding and subtracting
#         values we can home in on any real value in negaquaternary, we can
#         home in on any real value for the complex component, all with
#         only the digits 0,1,2, and 3 and perhaps a lot of space.

#         Knuth originally commented in his 1955 paper that the
#         quater-imaginary number system could be potentially quite useful
#         due to its ease in multiplication and addition, which is
#         remarkably  straighforward. However a graceful technique for
#         division eluded him, and to this day quater-imaginary numbers
#         remain largely a mathematical curiosity.
# 
#       Method:
# 
#         In this task, however, we are only getting our feet wet, as we
#         are asked to convert base-10 real numbers to their
#         quater-imaginary equivalent and back. Real numbers are still
#         complex, of course, with an imaginary component set to 0. Thus
#         the alternating positions holding he complex components will all
#         be 0. The remaining positions, viewed as a number, will be the
#         decimal number converted to negaquaternary.
# 
#         Converting bases is old hat by this point, we divide out and
#         append the remainders to the converted value. There is one twist,
#         though, in that for this to work the remainder must be positive.
#         Should the remainder be negative, we need to carry a digit from
#         the quotient back, subtracting 1 from the quotient and adding 4
#         to the remainder. With this additional new step everything works
#         out right.
# 
#         To convert back to decimal there is no similar problem with
#         powers, so like any other conversion we raise (-4) to the power
#         of the position and multiply by the value found there, adding the
#         result to the deecimal conversion. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';

## a spread of values converted to quater-imaginary and back again

say " dec : quater-i   : dec ";
say "-----+------------+-----";
for (-16..16) {
    my $qi = dec2quater_i( $_ );
    say sprintf "%4d : %-10d : %d", $_, $qi, quater_i2dec( $qi );
    
}


sub dec2quater_i ( $num ) {
## variant on normal base conversion
## non-imaginary integers only!
## converts from base-10 to quater-imaginary
## converts to base -4 and then inserts 0s between digits for +i components 
    my $rem;
    my $quot;
    my @nqt;
    
    ## divide out -4s and save remainders
    ## remainders must be positive
    while ( $num != 0  ) {
        $quot = int($num / -4);
        ($num, $rem) = ($quot, $num - ($quot * -4));   
        if ($rem < 0) {
            ## flip remainder to positive if necessary (subtract -4 and carry)
            ($num, $rem) = ($num + 1, $rem + 4) 
        }
        unshift @nqt, $rem;
    }
    return scalar @nqt          ## required to ensure 0 value
        ? join '0', @nqt
        : 0 ;               
}

sub quater_i2dec( $num ) {

## non-imaginary integers only!
## converts quater-imaginary to non-imaginary base-10
## strips +i components (which will be zeros) and converts from base -4

    ## filter out every other position
    my $i = 1;
    my @num = grep { $i++ & 1 } split //, $num; 
    
    ##  convert by computing expanded form
    my $out;
    my $pos = 0;
    for ( reverse @num ) {
        $out += $_ * (-4) ** $pos++;
    }
    
    return $out;
}


