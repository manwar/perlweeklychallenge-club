#!/usr/env perl
# Daylight Hours
# Challenge 2 Week 37

use strict;
use warnings;

use LWP::Simple qw(get); 

my $difference=getDayLight( country=>"uk", city =>"london", month =>"11", year =>"2019", ) -
               getDayLight( country=>"uk", city =>"london", month =>"12", year =>"2019", );
               
print "\n\nThe difference in daylight is ".s2hms(abs($difference))."(Hours:Minutes:Seconds)\n";     
     
sub s2hms{                    # converts seconds to days hours minutes and seconds
	my $time=shift;
	my $sec=$time%60;
	$time=($time-$sec)/60;
	my $min=$time%60;
	$time=($time-$min)/60;
	my $hrs=$time%24;
	my $days=($time-$hrs)/24;
	return ($days?"$days days ":"").sprintf "%d:%02d:%02d",$hrs,$min,$sec;
	
}

sub hms2s{
	my($hours,$mins,$secs)=split /:/, shift;
	return 3600*$hours+60*$mins+$secs;

}

sub getDayLight{            #return total number of seconds of daylight;
	my %data=@_;
	my $url = "https://www.timeanddate.com/sun/$data{country}/$data{city}?month=$data{month}&year=$data{year}";
	print "According to \n  $url \n";
	my $html = get $url;

	$html=~s/^.+<tbody>//s;		#remove everything before the table body    
	$html=~s/<\/tbody>.*$//s;	#remove everything after  the table body
	$html=~s/<\/tr>/-\n/gs;		#each row of table in new line, remove row tags
	$html=~s/<\/?t[^>]+>/_/gs;	#replace each tag with '_'
	$html=~s/<\/?s[^>]+>//gs;	#span tags are not useful
	$html=~s/&#8722;/\-/gs;		#html minus charcode to be replaced with -
	$html=~s/&43;/\+/gs;		#html plus  charcode to be replaced with +  
	
	my @tt; 				    #array containing each day of the month		
	foreach my $line(split/\n/, $html){  #converts row into hash
		my @tmp=split /__/,$line;shift @tmp; my $dt=shift @tmp; my %ttmp;
		@ttmp{qw/sr ss dl dld ATS ATE NTS NTE CTS CTE noon MKm/}=@tmp;
		$tt[$dt]=\%ttmp;		#put each row hash into the date		
	}
	
	my $dlSum=0;				# the accumulator for the daylight time

	foreach my $date (1..$#tt){ #for each date collected
		$dlSum+=hms2s($tt[$date]{dl}); #get the daylight time converted to seconds
	}
								#spit out the time 
	print   "  There are ".s2hms($dlSum) . " of daylight in\n  ".
	        ucfirst($data{city})." during month $data{month}, year $data{year}\n"; 
	return  $dlSum; 
}

# output is: -
#
# According to 
#  https://www.timeanddate.com/sun/uk/london?month=11&year=2019 
#  There are 11 days 3:00:40 of daylight in
#  london during month 11, year 2019
# According to 
#  https://www.timeanddate.com/sun/uk/london?month=12&year=2019 
#  There are 10 days 5:45:01 of daylight in
#  london during month 12, year 2019
#
#
# The difference in daylight is 21:15:39(Hours:Minutes:Seconds)

