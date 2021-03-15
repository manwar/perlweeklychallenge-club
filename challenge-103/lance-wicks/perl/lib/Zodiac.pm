package Zodiac;
use Moo;

sub _build_zodiac_table {

    my @elements = (
        qw/
            Wood
            Fire
            Earth
            Metal
            Water
            /
    );

    my @animals = (
        qw/
            Rat
            Ox
            Tiger
            Rabbit
            Dragon
            Snake
            Horse
            Goat
            Monkey
            Rooster
            Dog
            Pig
            /
    );

    my $elem_key = 0;

    my %table;
    for ( my $i = 1; $i <= 61; $i = $i + 2 ) {
        $table{$i} = $elements[$elem_key];
        $table{ $i + 1 } = $elements[$elem_key];

        $elem_key++;
        $elem_key = 0 if $elem_key > 4;
    }

    my $animal_key = 0;
    for ( my $i = 1; $i <= 61; $i++ ) {
        $table{$i} .= ' ' . $animals[$animal_key];

        $animal_key++;
        $animal_key = 0 if $animal_key > 11;
    }

    return \%table;

}

sub sign_from_year {
    my ( $self, $year ) = @_;

    my $table = _build_zodiac_table();
    my $step1 = $year - 3;
    my $step2 = int $step1 / 60;
    my $step3 = $step1 - ( 60 * $step2 );

    return $table->{$step3};
}

1;
