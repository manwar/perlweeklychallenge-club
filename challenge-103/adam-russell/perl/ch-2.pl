use strict;
use warnings;
##
# Write a program to output which file is currently playing.
##
sub song_times{
    my($file_name) = @_; 
    my %song_times;
    my @song_order;
    my $length = 0; 
    my $index = 0;  
    if(!$file_name){
        while(<DATA>){
            chomp; 
            my($time, $song) = split(/,/);       
            $length += $time; 
            $song_order[$index] =  $song; 
            $song_times{$song} =  $time; 
            $index++; 
        } 
    } 
    else{
        open(FILE, $file_name); 
        while(<FILE>){
            chomp; 
            my($time, $song) = split(/,/);       
            $length += $time; 
            $song_order[$song] =  $index; 
            $song_times{$song} =  $time; 
            $index++; 
        } 
    } 
    return [\%song_times, \@song_order, $length];   
}

sub now_playing{
    my($start_time, $current_time, $file_name) = @_; 
    my($song_times, $song_order, $length_millis);
    $current_time = time() if !$current_time; 
    ($song_times, $song_order, $length_millis) = @{song_times()} if $file_name;   
    ($song_times, $song_order, $length_millis) = @{song_times($file_name)} if !$file_name;   
    my $time_playing = $current_time - $start_time;
    my $cycles = ($time_playing * 1000) / $length_millis;  
    my $current_cycle_millis = ($cycles - int($cycles)) * $length_millis;  
    my $seek_time = 0; 
    for my $song (@{$song_order}){
        $seek_time += $song_times->{$song};
        if($seek_time > $current_cycle_millis){
            my $position = ($song_times->{$song} - ($seek_time - $current_cycle_millis)) / 1000; 
            my $hours = int($position/3600);
            my $minutes = int(($position % 3600) / 60);
            my $seconds = int(($position % 3600) % 60);
            $position = $hours . ":" . $minutes . ":" . $seconds;    
            return ($song, $position);  
        }   
    }  
}  

MAIN:{
    my($song, $position) =  now_playing(1606134123, 1614591276);   
    print "$song\n$position\n";  
}  





__DATA__
1709363,"Les Miserables Episode 1: The Bishop (broadcast date: 1937-07-23)"
1723781,"Les Miserables Episode 2: Javert (broadcast date: 1937-07-30)"
1723781,"Les Miserables Episode 3: The Trial (broadcast date: 1937-08-06)"
1678356,"Les Miserables Episode 4: Cosette (broadcast date: 1937-08-13)"
1646043,"Les Miserables Episode 5: The Grave (broadcast date: 1937-08-20)"
1714640,"Les Miserables Episode 6: The Barricade (broadcast date: 1937-08-27)"
1714640,"Les Miserables Episode 7: Conclusion (broadcast date: 1937-09-03)"
