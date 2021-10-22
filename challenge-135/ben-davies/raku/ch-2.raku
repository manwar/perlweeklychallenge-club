use v6;
unit sub MAIN(Str:D $sedol) {
    my constant @digits  = |(<0>..<9>), |<B C D F G H J K L M N P Q R S T V W X Y Z>;
    my constant @weights = <1 3 1 7 3 9 1>;
    say +do
        $sedol ~~ rx:r/ ^ <digit=@digits> ** 6 <check=[ 0..9 ]> $ / andthen
        @<digit>.kv.map({ @weights[$^k] * :36(~$^v) }).sum andthen
        (10 - $_ % 10) % 10 == $<check>;
}
