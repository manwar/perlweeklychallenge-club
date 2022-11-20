use v5.36;
use List::Util qw<all mesh>;

sub number_valid ($n) { $n >= 1 and $n <= 26 }

sub all_numbers_valid ( $ns_aref ) {
    return all { number_valid($_) } @{$ns_aref};
}

sub partition ($s) {
    my @r;
    for my $i ( 1 .. length($s) ) {
        my ($prefix, $t) = unpack "a$i a*", $s;
        last unless number_valid($prefix); # Speed optimization
        push @r, map { [ $prefix, @{$_} ] } partition($t);
    }
    return !@r ? [] : grep { all_numbers_valid($_) } @r;
}

sub task2 ($s) {
    state @letters = (undef, 'A'..'Z');
    return [ sort map { join '', @letters[ @{$_} ] } partition($s) ];
}



my @tests1 = (
    [   11, [qw< AA K                >] ],
    [ 1115, [qw< AAAE AAO AKE KAE KO >] ],
    [  127, [qw< ABG LG              >] ],

    [  222, [qw< BBB BV VB           >] ],
    [ 2222, [qw< BBBB BBV BVB VBB VV >] ],
    [ 2333, [qw< BCCC WCC            >] ],
    [ 2626, [qw< BFBF BFZ ZBF ZZ     >] ],
    [ 2727, [qw< BGBG                >] ],
);
my @tests2 = split "\n", <<'END';
I have got 
such a rotten
little present
Misbegotten
and unpleasant
Learn your lesson
Try to leave me
off your list
END
use Test::More;
plan tests => 0+@tests1+@tests2;
for (@tests1) {
    my ( $input, $expected ) = @{$_};
    is_deeply task2($input), $expected, "task2($input)";
}
sub to_num ( $s ) {
    state %alpha = mesh ['A'..'Z'], [1..26];
    return join '', map { $alpha{$_} } split '', $s;
}
for my $text (@tests2) {
    my $input = uc($text =~ tr/ ''//dr);
    my $count = 0 + grep { $_ eq $input } @{ task2(to_num $input) };
    is $count, 1, $text;
}
