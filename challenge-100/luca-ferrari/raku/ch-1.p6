#!raku


sub MAIN( Str $when, Str $phase? = '' ) {
    if $when ~ $phase ~~ / $<hour>=\d+ ':' $<minute>=\d+ $<phase>=( 'am'|'pm' )? / {
        my $hour = $<hour>.Int;
        my $am   = "%s".sprintf( $<phase> && $<phase>.Str ?? $<phase>.Str.lc !! '' );

        given $am {
            when 'am' { $hour += $hour > 12 ?? -12 !! 0; $am = ''; }
            when 'pm' { $hour += $hour < 12 ??  12 !! 0; $am = ''; }
            default   { $am = $hour < 13 ?? 'am' !! 'pm';
                        $hour += $hour < 13 ?? 0   !! -12; }
        }

        say "%02d:%02d %s".sprintf( $hour , $<minute>, $am ).trim;
    }
}
