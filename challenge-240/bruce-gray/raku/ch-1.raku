# Three solutions:
# Extract first letters of words, and join those letters, compare with FoldCase (.fc) .
# Use .starts-with to check each letter of the acronym against each word.
# Construct regex to match against the stringifiled list of words iff proper acronym.

my sub first_letters ( @s --> Str ) { @s».substr(0, 1).join }

sub task1_first_letters ( Str $acronym, @words --> Bool ) {
    return $acronym.fc eq @words.&first_letters.fc;
}


# Used `Zsw` with size guard instead of `»sw«` to keep from throwing error.
my sub infix:«sw» { $^a.starts-with: $^b, :ignorecase }

sub task1_starts_with ( Str $acronym, @words --> Bool ) {
    return False if $acronym.chars != @words.elems;

    return ?all @words».fc Zsw $acronym.comb».fc;
}


sub task1_regex ( Str $acronym, @words --> Bool ) {
    warn if @words.any ~~ /\s/;

    my $re = $acronym.comb.map( * ~ '\S*' ).join('\s+');

    return so @words.Str ~~ m:i/ ^ <$re> $ /;
}


constant @tests =
    ( True  , ( 'ppp' , <Perl Python Pascal> ) ),
    ( False , ( 'rp'  , <Perl Raku>          ) ),
    ( True  , ( 'oac' , <Oracle Awk C>       ) ),
;
constant @subs =
    :&task1_first_letters,
    :&task1_starts_with,
    :&task1_regex,
;
use Test; plan @tests * @subs;
for @subs -> ( :key($sub_name), :value(&task1) ) {
    for @tests -> ( Bool $expected, ( Str $acro, @words ) ) {
        is task1($acro, @words), $expected,
            "{$sub_name.fmt("%19s")} : $acro, @words[]";
    }
}
