<?php

const EL_COUNT = 7;

function permute($what)
{
	if (count($what) == 1) {
		return [$what];
	}

	$options = [];

	foreach($what as $el) {
		$seen = 0;
		array_push($options, ...array_map(
			fn ($arr) => [$el, ...$arr],
			permute(
				array_filter(
					$what,
					fn ($subel)
						=> $subel != $el || $seen++
				)
			)
		));
	}

	return $options;
}

function four_squares($input)
{
	$results = [];

	if (count($input) != EL_COUNT) {
		return $results;
	}

	foreach (permute($input) as $case) {
		$real_case = [0, ...$case, 0];
		$summed_groups = array_map(
			fn ($el)
				=> array_sum(
					array_map(
						fn ($subel)
							=> $real_case[$subel],
					range($el, $el + 2))
				),
			array_filter(
				array_keys($real_case),
				fn ($el)
					=> $el % 2 == 0 && $el <= count($real_case) - 2
			)
		);

		$matching_first = array_filter(
			$summed_groups,
			fn ($el)
				=> $el == $summed_groups[0]
		);

		if (count($matching_first) == count($summed_groups)) {
			$case_results = [];
			for ($letter = 'a'; $letter != 'h'; ++$letter) {
				$case_results[$letter] = array_shift($case);
			}

			$results[] = $case_results;
		}
	}

	return $results;
}

var_dump(four_squares(range(1, 7)));

