#!/usr/bin/env -S perl -wl

print &senior_citizens( "7868190130M7522", "5303914400F9211", "9273338290F4010"); #2
print &senior_citizens( "1313579440F2036", "2921522980M5644" ); #0

sub senior_citizens {

    #-- helper sub sub
    local *validate_input = sub {
        $_[0] =~ m/^\d{10}[MF]{1}\d{4}$/;
    };

    #-- back to trunk of sub 
    scalar
    grep 
    {
        (&validate_input($_)) && 
        (substr($_,11,2) >= 60); 
    }
    @_;
}

