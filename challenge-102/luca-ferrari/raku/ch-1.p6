#!raku



class ChineseCalendar {
    has DateTime $!now;
    has Str @!animals;
    has Str @!elements;

    submethod BUILD( :$year = Nil ) {
        @!animals  = qw/ Rat Ox Tiger Rabbit Dragon Snake Horse Goat Monkey Rooster Dog Pig /;
        @!elements = qw/ Wood Fire Earth Metal Water /;
        $!now      = $year ?? DateTime.new: year => $year !! DateTime.now;
    }

    method element() {
        return @!elements[ ( $!now.year - 4 ) % 10 / 2 ];
    }

    method animal() {
        return @!animals[ ( $!now.year - 4 ) % 12 ];
    }
}


multi sub MAIN( Int $year where { $year > 1900 } ) {
    my $cc = ChineseCalendar.new: year => $year;

    say "Year $year is %s %s".sprintf:
        $cc.element, $cc.animal;
}

multi sub MAIN() {
    MAIN( DateTime.now.year );
}
