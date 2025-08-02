use Test2::V0 -target => 'UCW';

subtest 'Example 1' => sub {
    my $line1 = 'Mango is sweet';
    my $line2 = 'Mango is sour';

    is $CLASS->words( $line1, $line2 ), [ 'sour', 'sweet' ];
};

subtest 'Example 2' => sub {
    my $line1 = 'Mango Mango';
    my $line2 = 'Orange';

    is $CLASS->words( $line1, $line2 ), ['Orange'];
};

subtest 'Example 3' => sub {
    my $line1 = 'Mango is Mango';
    my $line2 = 'Orange is Orange';

    is $CLASS->words( $line1, $line2 ), [];
};

done_testing;