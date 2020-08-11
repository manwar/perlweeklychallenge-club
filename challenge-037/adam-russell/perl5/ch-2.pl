use strict;
use warnings;
##
# Write a script to find out the DayLight gain/loss 
# in the month of December 2019 as compared to 
# November 2019 in the city of London.
##
use LWP::UserAgent;
use HTML::TableExtract;
use DateTime::Duration;
use constant NOVEMBER_URL => "https://www.timeanddate.com/sun/uk/london?month=11&year=2019";
use constant DECEMBER_URL => "https://www.timeanddate.com/sun/uk/london?month=12&year=2019";

sub get_daytime{
    my ($url) = @_; 
    my $daytime = new DateTime::Duration; 
    my $ua = new LWP::UserAgent(
        ssl_opts => {verify_hostname => 0}
    );
    my $response = $ua->get($url);
    my $parser = new HTML::TableExtract(headers => [qw/Daylength/]);
    $parser->parse($response->decoded_content);  
    for my $t ($parser ->tables){
        for my $row ($t->rows){ 
            if($row->[0] && $row->[0]=~m/[0-9]/){ 
                my @fields = split(/:/, $row->[0]);
                my $d = new DateTime::Duration(
                    hours   => $fields[0], 
                    minutes => $fields[1],   
                    seconds => $fields[2] 
                );
                $daytime->add_duration($d);   
            } 
        } 
    }
    return $daytime; 
} 

MAIN:{
    my $november_daytime = get_daytime(NOVEMBER_URL);
    my $december_daytime = get_daytime(DECEMBER_URL);
    my $delta = $december_daytime - $november_daytime;
    unless($delta->is_zero){ 
        print "loss of " if DateTime::Duration->compare($december_daytime, $november_daytime) < 0;  
        print "gain of " if DateTime::Duration->compare($december_daytime, $november_daytime) > 0;  
        print $delta->hours() . " hours "; 
        print $delta->minutes() . " minutes "; 
        print $delta->seconds() . " seconds\n"; 
    }  
    else{
        print "no change.\n"; 
    } 
}  
