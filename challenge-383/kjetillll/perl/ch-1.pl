# https://theweeklychallenge.org/blog/perl-weekly-challenge-383/

sub f {
    my %syn = map {my $lst = $_; map { $_ => $$lst[0] } @$_ } @{ $_[2] };
    "@{[ map $syn{$_} // $_, @{ $_[0] } ]}" eq
    "@{[ map $syn{$_} // $_, @{ $_[1] } ]}"
}

#---------- tests
my($true, $false) = (1, 0);
print f( @{ $$_{input} } ) == $$_{output} ? "ok\n" : "ERROR\n" for
    { input => [ ["great", "acting"],
                 ["fine", "drama"],
                 [ ["great", "fine"], ["acting", "drama"] ] ],
      output => $true },

    {  input => [ ["apple", "pie"],
                  ["banana", "pie"],
                  [ ["apple", "peach"], ["peach", "banana"] ] ],
       output => $false },

    {  input => [ ["perl4", "python"],
                  ["raku", "python"],
                  [ ["perl4", "perl5", "raku"] ] ],
       output => $true },

    {  input => [ ["enjoy", "challenge"],
                  ["love", "weekly", "challenge"],
                  [ ["enjoy", "love"] ] ],
       output => $false },

    {  input => [ ["fast", "car"],
                  ["quick", "vehicle"],
                  [ ["quick", "fast"], ["vehicle", "car"] ] ],
       output => $true },
