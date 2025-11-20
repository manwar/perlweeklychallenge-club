
sub f { shift() =~ /^(.)(.*)(.)$/ ? f( $2, map /[aeiou]/i + shift(), $1, $3) : $_[0]>0 && shift() == shift() }

sub f_verbose {  #same thing more verbose
    use strict; use warnings;
    my($str, $count_vowels_left, $count_vowels_right) = (@_,0,0);

    if( $str =~ s/^(.)(.*)(.)$/$2/ ){
        my($left_char, $middle_string, $right_char) = ($1,$2,$3);
        return f_verbose( $middle_string,
                          $count_vowels_left  + ( $left_char  =~ /[aeiou]/i ? 1 : 0 ),
                          $count_vowels_right + ( $right_char =~ /[aeiou]/i ? 1 : 0 ) )
    }
    else {
        return $count_vowels_left > 0   &&   $count_vowels_left == $count_vowels_right
    }
}

use Test::More;

ok f("textbook")     == 0;
ok f("book")         == 1;
ok f("AbCdEfGh")     == 1;
ok f("rhythmmyth")   == 0;
ok f("UmpireeAudio") == 0;

ok f_verbose("textbook")     == 0;
ok f_verbose("book")         == 1;
ok f_verbose("AbCdEfGh")     == 1;
ok f_verbose("rhythmmyth")   == 0;
ok f_verbose("UmpireeAudio") == 0;

done_testing;
