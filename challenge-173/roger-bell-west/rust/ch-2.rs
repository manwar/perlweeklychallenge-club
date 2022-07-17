use num_bigint::BigUint;

#[test]
fn test_ex1() {
    assert_eq!(sylvester(10),
               vec![
            BigUint::from(2_u32),
            BigUint::from(3_u32),
            BigUint::from(7_u32),
            BigUint::from(43_u32),
            BigUint::from(1807_u32),
            BigUint::from(3263443_u32),
            BigUint::from(10650056950807_u64),
            BigUint::from(113423713055421844361000443_u128),
            "12864938683278671740537145998360961546653259485195807".parse::<BigUint>().unwrap(),
            "165506647324519964198468195444439180017513152706377497841851388766535868639572406808911988131737645185443".parse::<BigUint>().unwrap()
               ]);
}

fn sylvester(ct: usize) -> Vec<BigUint> {
    let mut o = vec![BigUint::from(2_u32)];
    let one = BigUint::from(1_u32);
    for _ in 2..=ct {
        let x = o.last().unwrap().clone();
        o.push(one.clone() + (x.clone() * (x - one.clone())));
    }
    o
}
