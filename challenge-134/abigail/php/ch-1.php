<?php
    //
    // See ../README.md
    //

    //
    // Run as: php ch-1.php
    //
    $tails = array (789, 798, 879, 897, 978);

    foreach ($tails as &$tail) {
        echo "1023456$tail\n";
    }
?>
