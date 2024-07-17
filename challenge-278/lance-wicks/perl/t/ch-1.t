use Test2::V0 -target => 'String';

subtest "Eaxample 1" => sub {
    my $str      = "and2 Raku3 cousins5 Perl1 are4";
    my $expected = "Perl and Raku are cousins";

    is $CLASS->num_sort($str), $expected;
};

subtest "Example 2" => sub {
    my $str      = "guest6 Python1 most4 the3 popular5 is2 language7";
    my $expected = "Python is the most popular guest language";

    is $CLASS->num_sort($str), $expected;
};

subtest "Example 3" => sub {
    my $str      = "Challenge3 The1 Weekly2";
    my $expected = "The Weekly Challenge";

    is $CLASS->num_sort($str), $expected;
};

done_testing();