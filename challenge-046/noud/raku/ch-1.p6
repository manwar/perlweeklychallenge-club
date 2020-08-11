# Cryptic Message
#
# The communication system of an office is broken and message received are not
# completely reliable. To send message Hello, it ended up sending these
# following:
#
# H x l 4 !
# c e - l o
# z e 6 l g
# H W l v R
# q 9 m # o
#
# Similary another day we received a message repeatedly like below:
#
# P + 2 l ! a t o
# 1 e 8 0 R $ 4 u
# 5 - r ] + a > /
# P x w l b 3 k \
# 2 e 3 5 R 8 y u
# < ! r ^ ( ) k 0
#
# Write a script to decrypt the above repeated message (one message repeated 6 times).
# HINT: Look for characters repeated in a particular position in all six messages received.

sub select-double(@a) {
    for @a -> $elm {
        if (@a.grep($elm).elems == 2) {
            return $elm;
        }
    }
}

sub decrypt(@a) {
    return [~] ([Z] @a).map({ select-double($_) });
}

my @enc1 = (
    <H x l 4 !>,
    <c e - l o>,
    <z e 6 l g>,
    <H W l v R>,
    <q 9 m # o>);

say decrypt(@enc1);


my @enc2 = (
    ('P', '+', '2', 'l', '!', 'a', 't', 'o'),
    ('1', 'e', '8', '0', 'R', '$', '4', 'u'),
    ('5', '-', 'r', ']', '+', 'a', '>', '/'),
    ('P', 'x', 'w', 'l', 'b', '3', 'k', '\\'),
    ('2', 'e', '3', '5', 'R', '8', 'y', 'u'),
    ('<', '!', 'r', '^', '(', ')', 'k', '0'));

say decrypt(@enc2);
