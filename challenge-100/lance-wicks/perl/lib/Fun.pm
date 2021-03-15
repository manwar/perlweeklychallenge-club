package Fun;

use Moo;

sub convert {
    my ( $self, $time ) = @_;

    if ( $time =~ m/([ap]m)/ ) {
        my $am_pm = $1;

        $time =~ m/^(\d+):(\d+)/;
        my $hours   = $1;
        my $minutes = $2;

        if ( $am_pm eq 'pm' ) {
            $hours += 12;
        }
        return "$hours:$minutes";
    }
    else {
        $time =~ m/^(\d+):(\d+)/;
        my $hours   = $1;
        my $minutes = $2;

        if ( $hours > 12 ) {
            $hours -= 12;
            return sprintf( "%02d", $hours ) . ":$minutes" . 'pm';
        }
        else {
            return sprintf( "%02d", $hours ) . ":$minutes" . 'am';
        }
    }
}

1;
