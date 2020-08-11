# This program requires a VT-100 compatible terminal or emulator thereof
# xterm is just fine
# For windows, see the README

subset CoordStr of Str where / ^ \d+ \, \d+ $ /;

my @numbers = map *.comb(3).Array,
    "╻━╻┃ ┃╹━╹", "  ╻  ┃  ╹", "╺━╻╻━╹╹━╸", "╺━╻╺━┃╺━╹", "╻ ╻╹━┃  ╹",
    "╻━╸╹━╻╺━╹", "╻━╸┃━╻╹━╹", "╺━╻  ┃  ╹", "╻━╻┃━┃╹━╹", "╻━╻╹━┃╺━╹";

sub MAIN( CoordStr :$at = "2,2" )
{
    my ($x, $y) = $at.Str.split(',');

    react {
        whenever Supply.interval(1) -> $v {
            print clear-screen;
            display-time( $x, $y, DateTime.now.hh-mm-ss );
            print go-to(0,0);
        }

        whenever signal(SIGINT) { exit 0; }
    }
}

sub display-time( $x, $y, $time )
{
    for $time.comb.kv -> $column, $part
    {
        if $part ~~ /\d/
        {
            for |@numbers[$part].kv -> $idx, $line
            {
                print go-to( $x + ($column * 3), $y + $idx ) ~ $line;
            }
        }
        else
        {
            print go-to( $x + ($column * 3) , $y + 1) ~ " : ";
        }
    }
}

sub clear-screen() { escape("2J") ~ escape(";H"); }
sub go-to( $column, $row ) { escape( "$row;$column" ~ "H" ); }
sub escape( $value ) { "\e[" ~ $value; }



