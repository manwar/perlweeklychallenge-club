#! /bin/sh
//usr/bin/env rustc $0 -o ${0}x && ./${0}x --nocapture; rm -f ${0}x ; exit

use std::io::{self, BufRead, BufReader};

fn main() {
    let mut points: Vec<Vec<f64>> = Vec::new();
    let mut lines: Vec<Vec<f64>> = Vec::new();
    let mut x: Vec<f64> = Vec::new();
    let mut y: Vec<f64> = Vec::new();
    let reader = BufReader::new(io::stdin());
    for line in reader.lines() {
        let line = line.unwrap();
        let f = line
            .split(',')
            .filter_map(|i| i.parse::<f64>().ok())
            .collect::<Vec<f64>>();
        for (i, v) in f.clone().iter().enumerate() {
            if i % 2 == 0 {
                x.push(*v);
            } else {
                y.push(*v);
            }
        }
        if f.len() == 4 {
            lines.push(f);
        } else if f.len() == 2 {
            points.push(f);
        }
    }

    x.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let mnx = x[0];
    let mxx = x[x.len() - 1];

    y.sort_by(|a, b| a.partial_cmp(b).unwrap());
    let mny = y[0];
    let mxy = y[y.len() - 1];

    let lo = [mnx - (mxx - mnx) / 10., mny - (mxy - mny) / 10.];

    let hi = [mxx + (mxx - mnx) / 10., mxy + (mxy - mny) / 10.];

    let w = hi[0] - lo[0];
    let h = hi[1] - lo[1];

    println!("<?xml version=\"1.0\" encoding=\"UTF-8\" standalone=\"yes\"?>");
    println!("<!DOCTYPE svg PUBLIC \"-//W3C//DTD SVG 1.0//EN\" \"http://www.w3.org/TR/2001/REC-SVG-20010904/DTD/svg10.dtd\">");
    println!("<svg width=\"{}\" height=\"{}\" viewBox=\"{} {} {} {}\" xmlns=\"http://www.w3.org/2000/svg\" xmlns:svg=\"http://www.w3.org/2000/svg\" xmlns:xlink=\"http://www.w3.org/1999/xlink\">",w,h,lo[0],lo[1],w,h);

    if lines.len() > 0 {
        println!("  <g id=\"lines\" stroke=\"#369\" stroke-width=\"4\">");
        for p in lines {
            println!(
                "    <line x1=\"{}\" y1=\"{}\" x2=\"{}\" y2=\"{}\" />",
                p[0], p[1], p[2], p[3]
            );
        }
        println!("  </g>");
    }

    if points.len() > 0 {
        println!("  <g fill=\"#f73\" id=\"points\">");
        for p in points {
            println!("    <circle cx=\"{}\" cy=\"{}\" r=\"3\" />", p[0], p[1]);
        }
        println!("  </g>");
    }

    println!("</svg>");
}
