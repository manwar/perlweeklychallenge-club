use v6 ;

my $novemberstart_sunrise = DateTime.new( year => 2019 ,
                                          month => 11 ,
                      day => 1 ,
                      hour => 6 ,
                      minute => 53 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $novemberstart_sunset = DateTime.new( year => 2019 ,
                                          month => 11 ,
                      day => 1 ,
                      hour => 16 ,
                      minute => 34 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $novemberend_sunrise = DateTime.new( year => 2019 ,
                                          month => 11 ,
                      day => 30 ,
                      hour => 7 ,
                      minute => 41 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $novemberend_sunset = DateTime.new( year => 2019 ,
                                          month => 11 ,
                      day => 30 ,
                      hour => 15 ,
                      minute => 55 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $decemberstart_sunrise = DateTime.new( year => 2019 ,
                                          month => 12 ,
                      day => 1 ,
                      hour => 7 ,
                      minute => 43 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $decemberstart_sunset= DateTime.new( year => 2019 ,
                                          month => 12 ,
                      day => 1 ,
                      hour => 15 ,
                      minute => 55 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $decemberend_sunrise = DateTime.new( year => 2019 ,
                                          month => 12 ,
                      day => 31 ,
                      hour => 8 ,
                      minute => 6 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $decemberend_sunset = DateTime.new( year => 2019 ,
                                          month => 12 ,
                      day => 31 ,
                      hour => 16 ,
                      minute => 0 ,
                      second => 0 ,
                      timezone => 1 ) ;
my $daylength1 = $novemberstart_sunset - $novemberstart_sunrise ;
my $daylength2 = $novemberend_sunset - $novemberend_sunrise ;
my $novemberloss = $daylength1 - $daylength2 ;
say "Loss of daylength in november : " ~ $novemberloss.Str ~ " seconds!" ;
$daylength1 = $decemberstart_sunset - $decemberstart_sunrise ;
$daylength2 = $decemberend_sunset - $decemberend_sunrise ;
my $decemberloss = $daylength1 - $daylength2 ;
say "Loss of daylength in december : " ~ $decemberloss.Str ~ " seconds!" ;
