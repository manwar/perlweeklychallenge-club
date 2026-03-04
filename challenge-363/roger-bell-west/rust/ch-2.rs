#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(subnetsheriff("192.168.1.45", "192.168.1.0/24"), true);
}

#[test]
fn test_ex2() {
    assert_eq!(subnetsheriff("10.0.0.256", "10.0.0.0/24"), false);
}

#[test]
fn test_ex3() {
    assert_eq!(subnetsheriff("172.16.8.9", "172.16.8.9/32"), true);
}

#[test]
fn test_ex4() {
    assert_eq!(subnetsheriff("172.16.4.5", "172.16.0.0/14"), true);
}

#[test]
fn test_ex5() {
    assert_eq!(subnetsheriff("192.0.2.0", "192.0.2.0/25"), true);
}

#[test]
fn test_ex6() {
    assert_eq!(subnetsheriff("172.16.4.5", "172.17.0.0/14"), true);
}

fn parseaddr(a: &str) -> Option<u32> {
    let mut out = 0u32;
    for os in a.split('.') {
        if let Ok(ov) = os.parse::<u8>() {
            out *= 256;
            out += ov as u32;
        } else {
            return None;
        }
    }
    Some(out)
}

fn subnetsheriff(addrs: &str, nets: &str) -> bool {
    if let Some(addr) = parseaddr(addrs) {
        let netsc = nets.split('/').collect::<Vec<_>>();
        if let Some(netmask) = parseaddr(netsc[0]) {
            if let Ok(netlen) = netsc[1].parse::<u8>() {
                let bits = ((1u64 << (32 - netlen)) - 1) as u32;
                let netlo = netmask & !bits;
                let nethi = netmask | bits;
                return addr >= netlo && addr <= nethi;
            }
        }
    }
    false
}
