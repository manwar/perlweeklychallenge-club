package Clock;

use Moo;

sub angle {
    my ( $self, $t ) = @_;

    $t =~ /^(\d+):(\d+)$/;
    my $hour_hand_angle   = $self->angle_hour( h => $1, m => $2 );
    my $minute_hand_angle = $self->angle_minute( h => $1, m => $2 );

    return $hour_hand_angle - $minute_hand_angle;

}

sub angle_hour {
    my ( $self, %args ) = @_;

    my $h = $args{h};
    my $m = $args{m};

    my $mins = ( $h * 60 ) + $m;

    return $mins * 0.5;
}

sub angle_minute {
    my ( $self, %args ) = @_;

    my $h = $args{h};
    my $m = $args{m};

    return $m * 6;
}

1;
