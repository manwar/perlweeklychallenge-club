my @A = (2, 1, 4, 5, 3, 7);

.join(" ").say for reverse [Z] 
	(" ", "-", |(1..@A.max) ), 
	|@A.map({ $_, "-", |("#" xx $_), |(" " xx (@A.max - $_))  });
