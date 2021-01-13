sub count-middle(\phrase) {
    [+] phrase.trim.split(/\s+/)[1..*-2]>>.chars
}

if (@*ARGS.elems == 1) {
    say count-middle @*ARGS[0];
    exit 0;
}

use Test;

is count-middle('a a a'), 1, 'a simple phrase of 3 words';
is count-middle('a dummy phrase'), 5, 'a phrase of 3 words';
is count-middle('this a phrase of more than 3 words'), 18, 'can count phrases with more than 3 words';
is count-middle('a a'), 0, 'No middle words';
is count-middle('a'), 0, 'works with single word';
is count-middle('a'), 0, 'works with empty string';
is count-middle('   this a phrase of more than 3 words   '), 18, 'works with leading and trailing spaces';

done-testing;
