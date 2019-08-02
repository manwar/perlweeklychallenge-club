# Challenge #2
#
# Write a script that can convert integers to and from a base35 representation,
#  using the characters 0-9 and A-Y. Dave Jacoby came up with nice description
#  about base35, in case you needed some background.

my @numnums = (0..9,'A'..'Y'); # map integers 0..34 into base35 #TODO use actual map instead, for reverse lookup.

sub intTo35 {
    # convert positive integer into base35 string.
    return "0" if (0 == $_); # special case; log(0) is undefined.

    my @result = ();
    for my $i (0..(int(log($_)/log(35)))) { # iterate from int(log_35($_)) to 0.
      push @result, @numnums[$_ % 35]; # map value of respective power of 35.
      $_ /= 35; # prepare for next power of 35.
    }

    return join "", reverse @result; # string encoding $_ as base35.
}

sub intFrom35 {
    # convert positive base35 string into integer
    my ($result,$p) = (0,0);
    for my $d (reverse (split //)) { # match each digit to its respective power of 35.
      my $e = 0; # TODO reverse map lookup would reduce this whole section.
      for my $num (@numnums) {
        last if ($d eq $num); # found respective int multiplier.
        $e++;
      }
      $result += $e * (35**($p++)); # appraise base35 digit as int.
    }
    return $result; # int of decoded base35 string.
}

# default to conversion from int into base35,
#  flag --base35-to-int to convert base35 into int.
$_ = shift;
my $converter = ($_ eq "--base35-to-int") ? "intFrom35" : "intTo35";
print "# read numbers (also negative) from stdin.\n# use --base-35-to-int to convert from base35 into int.\n";
while(<>) {
    chomp $_; # read positive or negative numbers as lines from stdin
    print "$converter($_) = @{[ ( s/^-// ? -(eval $converter) : (eval $converter) ) ]}\n"; # run selected conversion, appending sign.
}
