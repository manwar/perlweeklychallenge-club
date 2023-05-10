use strict;
use warnings;
use List::Util      qw(min);
use List::MoreUtils qw(any);

sub min_stickers_needed {
    my ( $stickers, $target ) = @_;
    my %target_counts;
    $target_counts{$_}++ for split //, $target;
    my @stickers_counts = map { my %cnt; $cnt{$_}++ for split //, $_; \%cnt } @$stickers;

    # Filter out stickers that don't have any characters in common with the target word
    my @filtered_stickers_counts = grep {
        my $sticker = $_;
        any { exists $sticker->{$_} } keys %target_counts
    } @stickers_counts;

    return min_stickers_helper( \@filtered_stickers_counts, \%target_counts, 0 );
}

sub min_stickers_helper {
    my ( $stickers_counts, $target_counts, $used_stickers ) = @_;

    return $used_stickers unless keys %$target_counts;

    my $min_stickers = 'inf';
    for my $sticker_counts (@$stickers_counts) {

        # Try to fulfill the remaining character requirements of the target word
        my %new_target_counts    = %$target_counts;
        my $used_current_sticker = 0;
        for my $char ( keys %$sticker_counts ) {
            if ( $new_target_counts{$char} ) {
                $new_target_counts{$char} -= $sticker_counts->{$char};
                delete $new_target_counts{$char} if $new_target_counts{$char} <= 0;
                $used_current_sticker = 1;
            }
        }

        if ($used_current_sticker) {
            $min_stickers = min( $min_stickers,
                min_stickers_helper( $stickers_counts, \%new_target_counts, $used_stickers + 1 ) );
        }
    }

    return $min_stickers == 'inf' ? -1 : $min_stickers;
}

my $stickers = [ 'perl', 'raku', 'python' ];
my $word     = 'peon';
print min_stickers_needed( $stickers, $word ), "\n";    # Output: 2

$stickers = [ 'love', 'hate', 'angry' ];
$word     = 'goat';
print min_stickers_needed( $stickers, $word ), "\n";    # Output: 3

$stickers = [ 'come', 'nation', 'delta' ];
$word     = 'accommodation';
print min_stickers_needed( $stickers, $word ), "\n";    # Output: 4

$stickers = [ 'come', 'country', 'delta' ];
$word     = 'accommodation';
print min_stickers_needed( $stickers, $word ), "\n";    # Output: -1
