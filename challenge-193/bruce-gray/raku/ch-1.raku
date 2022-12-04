multi sub task1 (       1 ) {       <0 1>        }
multi sub task1 ( UInt $n ) { [X~] (<0 1> xx $n) }

say .&task1 for ^4;
