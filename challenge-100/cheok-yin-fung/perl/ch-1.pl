#!/usr/bin/perl
# The Weekly Challenge #100 
# Task 1 Fun Time
# Usage: $ perl ch-1.pl "XX:XX"

$_ = $ARGV[0];

die "Format error"
    if !(/^\d+:\d+$/) 
        && !/^\d+:\d+\s?[AaPp][Mm]$/ 
        && !/^[AaPp][Mm]\s?\d+:\d+$/
        && !/12:00/;

if (/(\d?\d):(\d\d)/) {$hr = $1; $min = $2;} 
    else {die "Format error";}

$apm = ( /[AaPp][Mm]/ ) ? 
        "" : (12 > $hr ? 
            "am" : ( $hr eq "12" && $min eq "00" ? 
                    "nn": "pm")) ;
$apm = "" if /12:00/ && /nn/;
$tfv = (/[Pp][Mm]/ && $hr != 12) ? 12: ( 12<$hr ? -12 : "" );
$tfv = -12 if /[Aa][Mm]/ && $hr == 12;
$hr += $tfv;
$hz = ($hr =~ /^\d$/ ) ? "0" : "";

print $hz , $hr, ":" , $min, " ", $apm, "\n";
