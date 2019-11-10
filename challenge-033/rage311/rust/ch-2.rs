fn main() {
    let mut results: Vec<Vec<Option<u8>>> = vec![(0..12)
        .map(|n| match n {
            0 => None,
            _ => Some(n),
        })
        .collect()];

    for i in 1..12 {
        let mut row: Vec<Option<u8>> = vec![Some(i)];
        for j in 1..12 {
            row.push(if j >= i { Some(i * j) } else { None });
        }
        results.push(row);
    }

    results.iter().for_each(|row| {
        println!(
            "{}",
            row.iter()
                .map(|product| format!(
                    "{:>3}",
                    match product {
                        Some(p) => p.to_string(),
                        None => "".to_string(),
                    }
                ))
                .collect::<Vec<_>>()
                .join(" ")
        )
    });
}

/* Output:
      1   2   3   4   5   6   7   8   9  10  11
  1   1   2   3   4   5   6   7   8   9  10  11
  2       4   6   8  10  12  14  16  18  20  22
  3           9  12  15  18  21  24  27  30  33
  4              16  20  24  28  32  36  40  44
  5                  25  30  35  40  45  50  55
  6                      36  42  48  54  60  66
  7                          49  56  63  70  77
  8                              64  72  80  88
  9                                  81  90  99
 10                                     100 110
 11                                         121
*/
