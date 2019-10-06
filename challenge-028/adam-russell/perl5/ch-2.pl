use strict;
use warnings;
##
# Write a script to display a digital clock.
##
use boolean;
use English; 
use DateTime::Set;
use POE q/Component::Schedule/; 

$OUTPUT_AUTOFLUSH = true;

sub update_clock{
    my $d = DateTime->now();  
    $d->set_time_zone("America/New_York");
    print "\b" x 8;
    print "\x1b[93;47m" . 
          sprintf("%02d", $d->hour)   .  ":" . 
          sprintf("%02d", $d->minute) .  ":" . 
          sprintf("%02d", $d->second) .
          "\x1b[0m";  
}

POE::Session->create(
    inline_states => {
        _start => sub {
            $_[HEAP]{schedule} = POE::Component::Schedule->add(
                $_[SESSION], on_tick => DateTime::Set->from_recurrence(
                    after      => DateTime->now,
                    recurrence => sub{
                        return $_[0]->truncate(to=>"second")->add(seconds => 1)
                    },  
                ),  
            );
        },
        on_tick => \&update_clock,
    },
);

POE::Kernel->run(); 
