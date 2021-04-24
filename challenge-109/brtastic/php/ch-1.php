<?php

foreach(range(1, 20) as $num) {
	echo array_sum(array_filter(
		$num >= 4 ? range(2, floor($num / 2)) : [],
		fn ($divisor) => $num % $divisor == 0
	)) . "\n";
}
