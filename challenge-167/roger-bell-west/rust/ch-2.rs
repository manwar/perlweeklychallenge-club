use num::abs;

const EPSILON: f64 = 1e-7;

const PI: f64 = 3.1415926536;

#[test]
fn test_ex1() {
    assert!(abs(gamma(3.0).re - 2.0) < EPSILON);
}

#[test]
fn test_ex2() {
    assert!(abs(gamma(5.0).re - 24.0) < EPSILON);
}

#[test]
fn test_ex3() {
    assert!(abs(gamma(7.0).re - 720.0) < EPSILON);
}

fn drop_imag(z0: num::complex::Complex<f64>) -> num::complex::Complex<f64> {
    let mut z = z0;
    if abs(z0.im) <= EPSILON {
        z = num::complex::Complex::new(z.re, 0.0);
    }
    z
}

fn gamma(z0: f64) -> num::complex::Complex<f64> {
    let p = vec![
        676.5203681218851,
        -1259.1392167224028,
        771.32342877765313,
        -176.61502916214059,
        12.507343278686905,
        -0.13857109526572012,
        9.9843695780195716e-6,
        1.5056327351493116e-7,
    ];
    let mut z = num::complex::Complex::new(z0, 0.0);
    let y;
    if z.re < 0.5 {
        y = PI / ((PI * z).sin() * gamma(1.0 - z.re));
    } else {
        z -= 1.0;
        let mut x = num::complex::Complex::new(0.99999999999980993, 0.0);
        for (i, pval) in p.iter().enumerate() {
            x += pval / (z + (i as f64) + 1.0);
        }
        let t = z + (p.len() as f64) - 0.5;
        y = (2.0 * PI).sqrt() * t.powc(z + 0.5) * (-t).exp() * x;
    }
    drop_imag(y)
}
