# Create script to implement Chaocipher. Please checkout wiki page for more information
# Visualizing it using rotating disk is a bit difficult, here's a video illustration of the algo
# https://www.youtube.com/watch?v=0tL9A69olRc , that helped me understand it

#It should be okay to modify the zenith/nadir (0 to $wheelsize)
constant $ZENITH = 0;
constant $NADIR  = 13;

#Initialize  wheels (chaocipher with bigger wheels!)
my @pt = "7bqkj9l2hOWyzA8SLPEtRvBwUQVmxa45g ufspeTF1KHd0DrGMCZoJXi3YIN6nc".split('',:skip-empty);
my @ct = "vEDclCHZYeWo9drb6Jnkf5MRXOt UgN4Fi231GzQIx7sPaLK8TBuVpA0yjShqwm".split('',:skip-empty);

sub MAIN (
    $encrypt,   #= Use e to encrypt $string, d to decrypt
    $string     #= String enclosed with ""
)
{
    my $enc = $encrypt eq 'e';
    my $ret = "";
    for $string.split('',:skip-empty) -> $c {
        #find where $c is in the plain text @pt (or @ct when decrypting)
        my $pos = $enc ?? @pt.first($c, :k) !!  @ct.first($c, :k);

        #Get the character from the cipher text in that position($pos)
        $ret ~= $enc ?? @ct[$pos] !! @pt[$pos];

        #rotate @pt and @ct from $pos to ZENITH
        rot($pos-$ZENITH, @pt);
        rot($pos-$ZENITH, @ct);

        #permute @ct: move the char in ZENITH + 1 to NADIR
        rot(1,@ct,$ZENITH+1,$NADIR);

        #permute @pt: rotate1 then move the char in ZENITH + 2 to NADIR
        rot(1,@pt);
        rot(1,@pt,$ZENITH+2,$NADIR);
    }
    say $ret;
}
# This function rotates the given array or a portion of the given array 
# Rotation count is defined by $r
# The whole array will be rotated by default
# but the range can be specified in $from and $to variable
# Perl6 has .rotate method that's awesome!
sub rot ($rcount, @arr, $from?, $to?) {
    if (!(defined $to && defined $from)) {
        @arr = @arr.rotate($rcount);
    } else {
        my $r = ($rcount + $from) % (@arr.end()+1);
        @arr  = (@arr[0..$from-1],@arr[$from..$to].rotate($rcount),@arr[$to+1..@arr.end]).flat;
    }
}
# perl6 .\ch-2.p6 e "a quick brown fox jumps over the lazy dog"
# gFv4ujqOyIPdTk5I9bKrYUXY4DwkCygHDKmQmyqUh

# perl6 .\ch-2.p6 d "gFv4ujqOyIPdTk5I9bKrYUXY4DwkCygHDKmQmyqUh"
# a quick brown fox jumps over the lazy dog
