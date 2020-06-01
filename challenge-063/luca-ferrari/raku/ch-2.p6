#!env raku


# Given a word made up of an arbitrary number of x and y characters, that word can be rotated as follows: For the ith rotation (starting at i = 1), i % length(word) characters are moved from the front of the string to the end. Thus, for the string xyxx, the initial (i = 1) % 4 = 1 character (x) is moved to the end, forming yxxx. On the second rotation, (i = 2) % 4 = 2 characters (yx) are moved to the end, forming xxyx, and so on. See below for a complete example.
# 
# Your task is to write a function that takes a string of xs and ys and returns the maximum non-zero number of rotations required to obtain the original string. You may show the individual rotations if you wish, but that is not required.
# Example
# 
# Input: $word = 'xyxx';
# 
#     Rotation 1: you get yxxx by moving x to the end.
#     Rotation 2: you get xxyx by moving yx to the end.
#     Rotation 3: you get xxxy by moving xxy to the end.
#     Rotation 4: you get xxxy by moving nothing as 4 % length(xyxx) == 0.
#     Rotation 5: you get xxyx by moving x to the end.
#     Rotation 6: you get yxxx by moving xx to the end.
#     Rotation 7: you get xyxx by moving yxxx to the end which is same as the given word.
# 
# Output: 7

sub rotate( $string where { $string.split( '', :skip-empty ).chars > 1 }, $verbose = False ){
    my $step = 1;
    my @chars  = $string.split( '', :skip-empty );


    while ( $step == 1 || $string ne @chars.join( '' ) ) {
        say "Rotation $step the string is: {@chars}" if $verbose;

        # move the first character to the end
        @chars.push: @chars.shift for 0 ..^ ( $step % $string.chars );
        

        say "After step $step the string is: { @chars }" if $verbose;

        $step++;
    }

    return $step - 1;
}


sub MAIN(){
    say rotate( 'xyxx' );
    say rotate( 'xyxx', True );
}
