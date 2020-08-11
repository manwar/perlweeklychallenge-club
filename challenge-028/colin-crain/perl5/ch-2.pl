#! /opt/local/bin/perl
#
#       digital_clock.pl
#
#       28 Task #2:
#       Write a script to display Digital Clock. Feel free to be as
#           creative as you can when displaying digits. We expect bare
#           minimum something like “14:10:11”.
#
#
#       method: uses ascii in a custom 8x13 bitmaped font of my own creation:
#

   ##########################################################################################################################################
  ##       ##########################################################################################################################       ##
  ##     ###                                                                                                                        ###     ##
  ##   ###                    #####                     ########     #####                     #####     ###########    ##  #   #     ###   ##
  ##  ###                   #########       ###       ##########   #########       ###       #########   ###########   #  # ## ##      ###  ##
  ##  ##                   ##      ###      ###      ###          ##      ###      ###      ###     ###         ###    #### # # #       ##  ##
  ##  ##                         ###                 #######           #####                ##       ##        ###     #  # #   #       ##  ##
  ##  ##                       ###                        #####        #####                ##       ##       ###                       ##  ##
  ##  ##                     ###            ###      ##      ###  ##      ###      ###      ###     ###      ###                        ##  ##
  ##  ###                  ###########      ###      ###########   #########       ###       #########      ###                        ###  ##
  ##   ###                 ###########                 ########      #####                     #####       ###                        ###   ##
  ##     ###                                                                                                                        ###     ##
  ##       ##########################################################################################################################       ##
   ##########################################################################################################################################
                ##########                                                                                            ##########
                 ########                                                                                              ########

#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my ($hours, $min, $sec) = get_time();

## convert to 12 hour time and note whether its day or night
my $cycle = 'am';
$hours = 12 if $hours == 0;
if ($hours > 12){
    $hours -= 12;
    $cycle = 'pm';
};

## there are eleven characters in the display:
#   ( left frame, h, h, separator, m, m, separator, s, s, cycle, right frame )
#   the first digit of the hours should be a space if 0,
#   the others should be zero-filled eg: [( 1:59:05)]
my @display = ( 'left' );

## insert characters into the display array
($hours < 10) ?
     push @display, ('space', $hours)
    : push @display, (split //, $hours);
push @display, ('sep', (split //, (sprintf "%02d", $min)), 'sep', (split //, (sprintf "%02d", $sec)), $cycle, 'right');

## print the clock:
#   the clock is a block of a few rows of header text,
#   then the display, consisting of mutable characters enclosed between
#   fixed left and right blocks, encoded as characters in the font,
#   followed by a lower block mirroring the top.
my $frame = get_frame();
print $frame->{top};

print_display( @display );

print $frame->{bottom};


## ## ## ## ## SUBS

sub get_time {
## returns an array of (hours, minutes, seconds)
    return reverse( (localtime(time))[0..2] );
}

sub print_display {
## specific to this font and display.
## given the array of characters to display
## prints the eight lines of the font for the characters called for
## could be generalized but as is, is set to print 11 font characters wide, each character eight lines high
    my @disp = @_;

    my $font = get_font();

    for my $line_number (0..7) {
        for my $offset (0..10){
            my $char = $disp[$offset];
            print( $font->{$char}->{$line_number})
        }
        print "\n";
    }

}

sub get_font {
## Reads from DATA and constructs a string containing code for a nested hash reference for
## characters in the font and the eight lines of ascii that compose each character.
## It then evals the string and returns the reference created.
## Spaces and newlines have been retained in the formatting to make it more human readable;
## the string can be printed out, visually examined and debugged before eval-ing as required.
    my $line;
    my $font;
    my $code = '$font = {' . "\n";

    for my $outer ( 0..9, 'sep', 'space', 'left', 'right', 'am', 'pm') {
        $code .= "\t$outer => {\n";
        for my $inner ( 0..7 ) {
            $line = <DATA>;
            chomp $line;
            my $key_value = "\t\t\t$inner => " . (sprintf "\'%-13s\'", $line) . ",\n";
            $code .= $key_value;
        }
        $line = <DATA>;         ## read and skip one line after each character to make it easier to visualize font and add comments
        $code .= "\t\t\t},\n"
    }
    $code .= '};' ;

    ## uncomment to see structure:
#   say $code;

    eval $code;
    return $font;

}

sub get_frame {
## the plastic frame for the top and bottom of the clock
## specific to this display.

    my $frame;

    $frame->{"top"} =<<__TOP__;

   ##########################################################################################################################################
  ##       ##########################################################################################################################       ##
  ##     ###                                                                                                                        ###     ##
__TOP__

    $frame->{"bottom"} =<<__BOT__;
  ##     ###                                                                                                                        ###     ##
  ##       ##########################################################################################################################       ##
   ##########################################################################################################################################
                ##########                                                                                            ##########
                 ########                                                                                              ########

__BOT__

    return $frame;
}

## ## ## ## ## FONT DATA
## font characters are 8 lines wide followed by a blank line that can be used for comments
## the font is monospaced, in this case 13 ascii characters wide,
## like a certain classic 8x13 x-windows bitmap I was once fond of,
## but not actually a copy
__DATA__
    #####
  #########
 ###     ###
 ##       ##
 ##       ##
 ###     ###
  #########
    #####

      ###
    #####
  ##  ###
      ###
      ###
      ###
  ##########
  ##########

    #####
  #########
 ##      ###
       ###
     ###
   ###
 ###########
 ###########

    #####
  #########
 ##      ###
      #####
      #####
 ##      ###
  #########
    #####

         ##
        ###
      #####
    ### ###
  ###   ###
 ###########
        ###
        ###

    ########
  ##########
 ###
 #######
      #####
 ##      ###
 ###########
   ########

        ###
      ###
    ####
  #########
 ###     ###
 ###     ###
  #########
    #####

 ###########
 ###########
        ###
       ###
      ###
     ###
    ###
   ###

    #####
  #########
 ###     ###
  #########
  #########
 ###     ###
  #########
    #####

    #####
  #########
 ###     ###
 ###     ###
   ########
      ####
      ###
     ###
sep[arator]:

     ###
     ###


     ###
     ###

space:








left:
  ##   ###
  ##  ###
  ##  ##
  ##  ##
  ##  ##
  ##  ##
  ##  ###
  ##   ###
right:
   ###   ##
    ###  ##
     ##  ##
     ##  ##
     ##  ##
     ##  ##
    ###  ##
   ###   ##
am:
   ##  #   #
  #  # ## ##
  #### # # #
  #  # #   #




pm:




  ###  #   #
  #  # ## ##
  ###  # # #
  #    #   #

 __EOF__

