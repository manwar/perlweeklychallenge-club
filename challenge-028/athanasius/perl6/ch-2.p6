use v6;

################################################################################
=begin comment

Perl Weekly Challenge 028
=========================

Task #2
-------
Write a script to display *Digital Clock*. Feel free to be as creative as you
can when displaying digits. We expect bare minimum something like *"14:10:11"*.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my UInt constant $TIMEZONE      = +10;        # Difference in hours from UTC/GMT
my UInt constant $SECS-PER-HOUR =  60 * 60;
my UInt constant $TZ-OFFSET     = $TIMEZONE * $SECS-PER-HOUR;

BEGIN say '';

#===============================================================================
sub MAIN()
#===============================================================================
{
    my DateTime $dt   = DateTime.now(timezone => $TZ-OFFSET);
    my UInt     $hour = $dt.hour;
    my UInt     $min  = $dt.minute;
    my UInt     $sec  = $dt.whole-second;

    "%02d:%02d:%02d\r".printf($hour, $min, $sec);

    while 1
    {
        sleep 1;

        if ++$sec >= 60
        {
            $sec = 0;

            if ++$min == 60
            {
                $min  = 0;
                $hour = 0 if ++$hour == 24;
            }
        }

        "%02d:%02d:%02d\r".printf($hour, $min, $sec);
    }
}

################################################################################
