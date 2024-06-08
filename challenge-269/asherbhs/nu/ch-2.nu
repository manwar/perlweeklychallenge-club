def distribute-elements [ints: list<int>] -> list<int> {
	mut arr1 = [$ints.0]
	mut arr2 = [$ints.1]
	for n in ($ints | skip 2) {
		if ($arr1 | last) > ($arr2 | last) {
			$arr1 ++= $n
		} else {
			$arr2 ++= $n
		}
	}
	$arr1 ++ $arr2
}

print (distribute-elements [2 1 3 4 5])
print (distribute-elements [3 2 4])
print (distribute-elements [5 4 3 8])
