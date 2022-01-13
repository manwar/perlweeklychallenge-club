#!raku


class Node {
    has Rat $.member;
    has Int $.level;
    has Node $.left;
    has Node $.right;
    has Node $.parent is rw;

    submethod BUILD( Rat :$member, Int :$level = 1, Int :$stop-at = 4 ) {
        $!member = $member;
        $!level  = $level;

        if ( $level < $stop-at ) {
            my $sum = $!member.numerator + $!member.denominator;
            $!left  = Node.new: member => $member.numerator / $sum,
                      level => $level + 1,
                      stop-at => $stop-at;
            $!right = Node.new: member => $sum / $member.denominator,
                      level => $level + 1,
                      stop-at => $stop-at;
        }
    }


    method adjust() {
        $!left.parent  = self if $!left;
        $!right.parent = self if $!right;
        $!left.adjust if $!left;
        $!right.adjust if $!right;
    }

    method search-from-here ( Rat $needle ) {
        return self if $!member ~~ $needle;

        if ( $!left ) {
            my $left = $!left.search-from-here( $needle );
            return $left if $left;
        }
        if ( $!right ) {
            my $right = $!right.search-from-here( $needle );
            return $right if $right;
        }
        return Nil;
    }

    method Str(){ $!member.numerator ~ '/' ~ $!member.denominator }
}

sub MAIN( Rat $member ) {
    my $level = 1;
    my $root = Node.new: member => 1.Rat;
    $root.adjust;


    my Node $which = $root.search-from-here( $member );
    "Not found $member " and exit if ! $which;
    "Node $member found: { $which.Str } with parent { $which.parent.Str } and grandparent { $which.parent.parent.Str }".say;
}
