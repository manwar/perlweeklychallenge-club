use strict; use warnings; use Test::More;

sub shortest_completing {
    my($str, @array) = @_;
    (
      sort { length($a) <=> length($b) or $a cmp $b }
      grep { is_completing($str, $_) }
      @array
    )[0]
}

sub is_completing {
    my( $str1, $str2 ) = @_;
    return 1 if $str1 !~ s/[a-z]//i; #draw a letter out of str1, return true if no letter found
    return 0 if $str2 !~ s/$&//i;    #draw same letter out of str2, return false if not found
    is_completing( $str1, $str2 )    #...or let the reduced strings decide
}



my @tests = (
    {
        input  => 'aBc 11c',
        array  => ['accbbb', 'abc', 'abbc'],
        output => 'accbbb'
    },
    {
        input  => 'Da2 abc',
        array  => ['abcm', 'baacd', 'abaadc'],
        output => 'baacd'
    },
    {
        input  => 'JB 007',
        array  => ['jj', 'bb', 'bjb'],
        output => 'bjb'
    }
);
for my $test ( @tests ) {
    my $got = shortest_completing( $$test{input}, @{  $$test{array} } );
    is( $got, $$test{output} );
}
done_testing;
