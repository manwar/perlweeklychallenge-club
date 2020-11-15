#!/usr/bin/env perl
use strict;
use warnings;
use v5.30;

# g++ --std=c++17 -DBUILD_SHARED ../cpp/c2.cpp -O2 -fPIC -shared -o sudoku.so
use FFI::Platypus;

# sudo apt install libgtk3-perl 
use Gtk3 -init;

use Data::Dumper;


my $ffi = FFI::Platypus->new( api => 1 );
$ffi->lib('./sudoku.so');

$ffi->attach( 'solve' => ['int[]']  => 'bool' );

my @puzzle = ( '', '', '',  2,  6, '',  7, '',  1,
                6,  8, '', '',  7, '', '',  9, '',
                1,  9, '', '', '',  4,  5, '', '',
                8,  2, '',  1, '', '', '',  4, '',
               '', '',  4,  6, '',  2,  9, '', '',
               '',  5, '', '', '',  3, '',  2,  8,
               '', '',  9,  3, '', '', '',  7,  4,
               '',  4, '', '',  5, '', '',  3,  6,
                7, '',  3, '',  1,  8, '', '', '',);

my $window = Gtk3::Window->new ('toplevel');
$window->signal_connect (delete_event => sub { Gtk3->main_quit });
$window->set_title("Sudoku Solver");
$window->set_border_width(5);

my $provider = Gtk3::CssProvider->new();
my $screen = Gtk3::Gdk::Screen::get_default;
Gtk3::StyleContext::add_provider_for_screen($screen, $provider, 600);
$provider->load_from_data('#boxsep { margin: 5px;} #boardsep { margin: 8px; }');

my @input_boxes;

my $vbox = Gtk3::Box->new( 'vertical', 5 );
$window->add($vbox);

for my $row (0..8) {
    if($row == 3 or $row == 6) {
        my $sep = Gtk3::HSeparator->new;
        $sep->set_name('boxsep');
        $vbox->add($sep);
    }

    my $hbox = Gtk3::Box->new( 'horizontal', 5 );
    $vbox->add($hbox);

    for my $col (0..8) {
        if($col == 3 or $col == 6) {
            my $sep = Gtk3::VSeparator->new();
            $sep->set_name('boxsep');
            $hbox->add($sep);
        }
        my $cell = new Gtk3::Entry->new;
        $cell->set_width_chars(2);
        $cell->set_text($puzzle[$row*9 + $col]);
        push @input_boxes, $cell;
        $hbox->add($cell)
    }
}
my $board_sep = Gtk3::HSeparator->new;
$board_sep->set_name('boardsep');
$vbox->add($board_sep);

my $solve_btn = Gtk3::Button->new('Solve');
$solve_btn->signal_connect (clicked => sub { 
        my @input_nums;
        foreach(@input_boxes) {
            my $text = $_->get_text();
            push @input_nums,  ($text ? $text : 0);
        }
        my $result = solve(\@input_nums);
        if($result) {
            for(my $i = 0; $i <= $#input_nums; $i++) {
                $input_boxes[$i]->set_text($input_nums[$i]);
            }
        }
        else {
            my $error_dialog = Gtk3::MessageDialog->new($window, 'destroy-with-parent', 'error', 'ok', 'Error solving Sudoku');
            $error_dialog->present();
            $error_dialog->signal_connect( response => sub { $error_dialog->destroy() } );
        }
    });

my $clear_btn = Gtk3::Button->new('Clear');
$clear_btn->signal_connect (clicked => sub {
        for(@input_boxes) {
            $_->set_text('');
        }
    });

my $buttons = Gtk3::HBox->new;
$buttons->add($solve_btn);
$buttons->add($clear_btn);
$vbox->add($buttons);

$window->show_all;
Gtk3::main;
