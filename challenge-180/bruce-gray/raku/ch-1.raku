sub first_unique_character_index ( Str $_ --> UInt ) {
    my @c = .lc.comb;
    my %h = @c.repeated.Set;
    return @c.first: :k, * !~~ %h;
}

my @tests = 
    'Perl Weekly Challenge' => 0,
    'Long Live Perl'        => 1,
    'abc abc'               => 3,
;
use Test;
plan +@tests;
is first_unique_character_index(.key), .value for @tests;
