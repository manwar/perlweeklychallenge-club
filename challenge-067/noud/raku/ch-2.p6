# You are given a digit string $S. Write a script to print all possible letter
# combinations that the given digit string could represent.
#
# Example:
#
#  Input: $S = '35'
#
#  Output: ["dj", "dk", "dl", "ej", "ek", "el", "fj", "fk", "fl"].

my %phone =
    1 => <_ , @>,
    2 => <a b c>,
    3 => <d e f>,
    4 => <g h i>,
    5 => <j k l>,
    6 => <m n o>,
    7 => <p q r s>,
    8 => <t u v>,
    9 => <w x y z>;

sub phone-to-string($S) {
    return [X~] gather { take %phone{$_} for $S.comb; };
}

.say for phone-to-string('35');



