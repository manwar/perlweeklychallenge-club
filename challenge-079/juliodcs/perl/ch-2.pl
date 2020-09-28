use strict;
use warnings;
use experimental 'signatures';
use feature qw(say state);
use List::Util qw(max min reduce);

use constant E_MUST_BE_POSITIVE => 'ERROR: All numbers must be > 0';
use constant E_NO_DATA          => 'ERROR: You need to input some numbers';
use constant E_NUMERIC          => 'ERROR: Only number allowed';
use constant W_UNALIGNED_FOOTER => "WARNING: footer numbers may not be aligned\n";

sub calculate_water($histogram) {

    # Counting water with regex! Yay!
    # https://regex101.com/r/Ph88Wi/1/
    my @matches = $histogram =~ m{
        (?:
              [#] [ ] \K [ ]
            | \G  [ ] \K [ ]
        )
        (?= [ ]*+ [#] ) # An ending block must exist
    }sxmg;
    scalar @matches;
}

sub max_value {
    state $max_value = max @ARGV;
}

sub pad($str) {
    sprintf '%' . length( max_value() ) . 's', $str;
}

sub data_item ( $line, $x_val ) {
    $line <= $ARGV[$x_val] ? q{ #} : q{  };
}

sub data_line($line) {
    reduce { $a . data_item( $line, $b ) }
    ( q{}, 0 .. @ARGV - 1 );
}

sub histogram_lines {
    reduce { $a . sprintf "%s%s\n", pad($b), data_line($b) }
    ( q{}, reverse 1 .. max_value() );
}

sub separator {
    ( pad(q(-)) . q( -) x @ARGV ) . "\n";
}

sub footer {
    sprintf pad(q( )) . "[%s]\n", join(q( ), @ARGV)
}

## MAIN ##

die E_NO_DATA          if @ARGV == 0;
die E_NUMERIC          if @ARGV != grep { m/^\d+$/ } @ARGV;
die E_MUST_BE_POSITIVE if ( min @ARGV ) < 1;

my $histogram = histogram_lines();

say "\n";

use constant MAX_SINGLE_DIGIT => 9;
if (max_value() > MAX_SINGLE_DIGIT) {
    say {*STDERR} W_UNALIGNED_FOOTER;
}

print $histogram;
print separator();
print footer();

say "\nTotal water: " . calculate_water($histogram);
