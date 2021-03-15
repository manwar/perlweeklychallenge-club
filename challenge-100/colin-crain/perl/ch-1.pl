#! /opt/local/bin/perl
#
#       fun-time-ta-go-go.pl
#
#         TASK #1 Ý Fun Time
#         Submitted by: Mohammad S Anwar
#         You are given a time (12 hour / 24 hour).
# 
#         Write a script to convert the given time from 12 hour format to 24
#         hour format and vice versa.
# 
#         Ideally we expect a one-liner.
# 
#         Example 1:
#             Input: 05:15 pm or 05:15pm
#             Output: 17:15
#         Example 2:
#             Input: 19:15
#             Output: 07:15 pm or 07:15pm
#
#       © 2021 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";


sub timef {
    local $_= shift;

    /^ (\d+)(:\d+)\s?(am|pm)* $/xi;

    my $hr  = $1;
    my $cyc = 'am';
    
    if ( $3 ) {                        ## 12hr->24hr
        $hr = sprintf "%02d", $1 % 12;
        $hr += 12 if $3 eq 'pm';
        return "$hr$2";
    }
    else {                                  ## 24hr->12hr        
        $cyc = 'pm' if $hr > 11;
        $hr %= 12;
        $hr ||= 12;
        return "$hr$2$cyc";
    }
}

sub timef_refactored {
    local $_= shift;

    /^ (\d+)(:\d+)\s?(am|pm)* $/xi;

    my $cyc = $1 > 11 ? 'pm' : 'am';
    my $hr  = $1 % 12;

    if ( $3 ) {
        $hr += 12 if $3 eq 'pm';
        return sprintf "%02d%s", $hr, $2;
    }
    else {    
        $hr ||= 12;
        return "$hr$2$cyc";
    }
}

sub timefl {
    no strict 'vars';
    local $_ = shift;
    /^(\d+)(:\d+)\s?(am|pm)*$/i;
    $c=$1>11?'pm':'am';
    $h=$1%12;
    if($3){
        $h+=12if$3eq"pm";
        sprintf"%02d%s",$h,$2;
    }
    else{
        $h||=12;
        "$h$2$c";
    }
}

=pod

as a one-liner we need to change the I/O a bit:

perl -E'@ARGV[0]=~/^(\d+)(:\d+)\s?(am|pm)*$/i;$c=$1>11?'pm':'am';$h=$1%12;if($3){$3eq"pm"and$h+=12;printf"%02d%s\n",$h,$2;}else{$h||=12;say"$h$2$c"}'

perl -E '$_=@ARGV[0];/^(\d+)(:\d+)\s?(am|pm)*$/i;$c=$1>11?'pm':'am';$h=$1%12;if($3){$3eq"pm"and$h+=12;printf"%02d%s\n",$h,$2}else{$h||=12;say"$h$2$c"}

=cut

use Test::More;

is timef("5:15AM"), "05:15", '12->24am'; 
is timef("5:15 am"), "05:15", '12->24am space';
is timef("5:15pm"), "17:15", '12->24pm';
is timef("5:15 pm"), "17:15", '12->24pm space';
is timef("12:15am"), "00:15", '12->24am-mid';
is timef("12:15pm"), "12:15", '12->24pm-noon';
is timef("5:15"),  "5:15am", '24->12am';
is timef("17:15"), "5:15pm", '12->24am';
is timef("12:00"), "12:00pm", '24->12-noon';
is timef("00:00"), "12:00am", '24->12-mid';
say '';
is timefl("5:15AM"), "05:15", '12->24am';
is timefl("5:15 am"), "05:15", '12->24am space';
is timefl("5:15pm"), "17:15", '12->24pm';
is timefl("5:15 pm"), "17:15", '12->24pm space';
is timefl("12:15am"), "00:15", '12->24am-mid';
is timefl("12:15pm"), "12:15", '12->24pm-noon';

is timefl("5:15"),  "5:15am", '24->12am';
is timefl("17:15"), "5:15pm", '12->24am';
is timefl("12:00"), "12:00pm", '24->12-noon';
is timefl("00:00"), "12:00am", '24->12-mid';


done_testing();
