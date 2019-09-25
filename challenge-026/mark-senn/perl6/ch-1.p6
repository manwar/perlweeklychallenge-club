# Perl  Weekly  Challenge  - 026
# Task #1
#
# See
#      engineering.purdue.edu/~mark/pwc -026 -1. pdf
# for  more  information.
#
# The  command  line  should be, for  example ,
#      perl6 t.p6  stones  jewels
# The  values  for "stones" and "jewels"
# default  to "chancellor" and "chocolate ".
#
#

# Run  using  Perl v6.d;
use v6.d;

sub  MAIN($a = 'chancellor', $b = 'chocolate')
{
    # Check  that$a and$b  consist  of only  upper  and  lowerccase  letters.
    ($a ~~ /^^<[A..Za..z]>+$$/)   or   die qq/"$a" must  consist  of one or more  letters /;
    ($b ~~ /^^<[A..Za..z]>+$$/)   or   die qq/"$a" must  consist  of one or more  letters /;

    # Convert$a and$b to  arrays.
    my @a =$a.comb (/./).unique;
    my @b =$b.comb (/./);


    #
    #    Array -based  solution.
    #

    # If keys to a hash  can be  expressed  as small
    # non -negative  integers  you may  want to use an
    # array  instead  of a hash.
    my @in -a;
    @a.map({@in -a[$_.ord] = True });
    $count = 0;
    @b.map({@in -a[$_.ord] and $count++});
    $count.say;


    #
    #   Cross -product  based  solution.
    #

    $count = 0;
    (@a X @b).map({$_[0] eq $_[1] and $count++});
    $count.say;


    #
    #   Hash -based  solution.
    #

    # Make a %a hash  with  letter  keys  and  True  values.
    # The  letters  in %a are the  ones we count  in$b.
    my %a = @a.map({$_ => True });

    # Count  the  characters  in$b that  occur  in$a.
    my $count = 0;
    @b.map ({%a{$_} and $count++});

    $count.say;


    #
    #   Set -based  solution.
    #

    # When I was  looking  up "perl6  degrees  to  radians" to see if there  was
    # a built -in Perl 6 method  to do it I came  across
    #      http :// blogs.perl.org/users/laurent_r /2019/09/
    #      perl -weekly -challenge -26-common -letters -and -mean -angles.html
    # showing  how to  convert a list/array  to a set.
    # I like  Laurent  Rosenfeld's solution  better  than  any I did  above.
    # The  following  is based  on his  work.
    my $aset = @a.Set;
    $count = @b.grep({$_ (elem) $aset }).elems;
    $count.say;
}

