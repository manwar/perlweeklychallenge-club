#
# Perl  Weekly  Challenge  - 026
# Task #2
#
# See
#      engineering.purdue.edu/~mark/pwc -026 -2. pdf
# for  more  information.
#
# The  command  line  should be, for  example ,
#      perl6 t.p6 1 2 3
# to get the  mean  angle  of 1, 2, and 3 degrees.
#

# Run  using  Perl v6.d;
use v6.d;

sub  MAIN(*@deg  where  @deg.elems > 0)
{
    # Convert  from  degrees  to  radians.
    my @rad = @deg  <<*>> (pi /180);

    # Transform  from  degrees  to polar  coordinates.
    my  Complex  @z = @rad.map({e**(i *$_)});

    # Compute$p -bar in  polar  coordinates.
    my$p -bar = ([+] @z) / @z.elems;

    # Compute  arctangent  and  convert  from  radians  to  degrees.
    # Sample  inputs  and  outputs:
    #       INPUT          OUTPUT                           COMMENT
    #       ----------     -----------------------          -------
    #          1    1           1
    #          1    2           1.5
    #          1    2   3       2
    #         10  -10           0
    #         10   20   30      19.999999999999996          wrong
    #         60                59.99999999999999           wrong
    #         350   10          -1.614809932057922e-15      wrong
    my$theta -bar = atan2($p -bar.im ,$p -bar.re) * (180/pi);
    $theta -bar.say;
}
