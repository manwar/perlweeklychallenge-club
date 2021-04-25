# https://perlweeklychallenge.org/blog/perl-weekly-challenge-10X/

# Check if values meet condition
sub condition(@perm) returns Bool {
  my ($a, $b, $c, $d, $e, $f, $g) = @perm;
  return $a + $b == $b + $c + $d == $d + $e + $f == $f + $g  
}

#| This is based on Mark Anderson's solution
sub challenge( @numbers ) returns Hash {
 my $i = 1;
 my %solution;
 my @chars = 'a'..'g';
 for @numbers.permutations -> @perm {
    my %this-permutation = @chars Z=> @perm;
    %solution{$i++} = @chars.map(-> $char { $char => %this-permutation{$char} }) if condition(@perm);
  }
  return %solution;
}

multi sub MAIN( *@numbers where { $_.all ~~ Int } ) {
  my %solution = challenge(@numbers);
  say 'There are ',%solution.keys.elems,' solutions';
  for %solution.keys.sort -> $solved {
    say 'Solution ',$solved;
    say ' ',%solution{$solved};
    my %s = %solution{$solved};
    die 'There is something wrong' unless condition( (%s<a>, %s<b>, %s<c>, %s<d>, %s<e>, %s<f>, %s<g>) );
    say ' a+b = b+c+d = d+e+f = f+g = ',%s<a> + %s<b>; 
  }
}

multi sub MAIN( 'challenge' ) {
  MAIN( (1..7) );
}

