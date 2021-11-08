#! /bin/sh
//usr/bin/env rustc --test $0 -o ${0}x && ./${0}x; rm -f ${0}x ; exit

#[test]
fn test_ex1() {
    assert_eq!(sp(vec![
        vec![10.0,20.0],
        vec![20.0,20.0],
        vec![20.0,10.0],
        vec![10.0,10.0]
    ]),1);
}

#[test]
fn test_ex2() {
    assert_eq!(sp(vec![
        vec![12.0,24.0],
        vec![16.0,10.0],
        vec![20.0,12.0],
        vec![18.0,16.0]
    ]),0);
}

#[test]
fn test_ex3() {
    assert_eq!(sp(vec![
        vec![10.0,10.0],
        vec![20.0,0.0],
        vec![30.0,10.0],
        vec![20.0,20.0]
    ]),1);
}

#[test]
fn test_ex4() {
    assert_eq!(sp(vec![
        vec![0.0,0.0],
        vec![3.0,4.0],
        vec![8.0,4.0],
        vec![5.0,0.0]
    ]),0);
}

fn sp(m: Vec<Vec<f64>>) -> u8 {
    for ordering in &[
        vec![0,1,2,3,0],
        vec![0,1,3,2,0],
        vec![0,2,1,3,0]
    ] {
        let w: Vec<Vec<f64>>=(0..=4).map(|i| m[ordering[i%4]].clone()).collect();
        let mut ds: Vec<f64>=vec![];
        for pp in 0..=3 {
            ds.push((w[pp+1][0]-w[pp][0])*(w[pp+1][0]-w[pp][0])+(w[pp+1][1]-w[pp][1])*(w[pp+1][1]-w[pp][1]));
        }
        ds.sort_by(|a,b| a.partial_cmp(b).unwrap());
        if ds[0] != ds[3] {
            continue;
        }
        let mut angles: Vec<f64>=vec![];
        for pp in 0..=3 {
            let angle: f64;
            let delta: Vec<f64>=(0..=1).map(|i| w[pp+1][i]-w[pp][i]).collect();
            if delta[0]==0.0 {
                if delta[1]==0.0 {
                    return 0;
                }
                angle=if delta[1]>0.0 {90.0} else {-90.0};
            } else {
                angle=delta[1].atan2(delta[0]).to_degrees();
            }
            angles.push(angle);
        }
        println!("{:?}",angles);
        angles.push(angles[0]);
        let mut good: u8=1;
        let deltas: Vec<f64>=(0..=3).map(|i| (angles[i+1]-angles[i]+360.0)%360.0).collect();
        println!("{:?}",deltas);
        if deltas[0] != 90.0 && deltas[0] != 270.0 {
            continue;
        } else {
            for di in 1..=3 {
                if deltas[di] != deltas[0] {
                    good=0;
                    break;
                }
            }
        }
        return good;
    }
    return 0;
}
