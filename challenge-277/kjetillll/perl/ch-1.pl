use strict; use warnings;

sub count_common {
    my @lists = @_;
    my %count;
    for my $i ( 0 .. @lists-1 ) {
        for my $word ( @{ $lists[$i] } ) {
            $count{$word}{$i}++
        }
    }
    my $onestring = join ' ', (1) x @_;
    0 + grep join(' ',values %{ $count{$_} }) eq $onestring, sort keys %count;
}

#---------------------------------------- tests
use Test::More tests=>3;
is count_common( @$_{'words1','words2'} ), $$_{output}
    for { words1 => ["Perl", "is", "my", "friend"],
          words2 => ["Perl", "and", "Raku", "are", "friend"],
          output => 2 }, # "Perl" and "friend" appear once in each array.
        { words1 => ["Perl", "and", "Python", "are", "very", "similar"],
          words2 => ["Python", "is", "top", "in", "guest", "languages"],
          output => 1 }, # "Python" appear once in each array
        { words1 => ["Perl", "is", "imperative", "Lisp", "is", "functional"],
          words2 => ["Crystal", "is", "similar", "to", "Ruby"],
          output => 0 }; # "is" appear in both arrays but twice in word1
