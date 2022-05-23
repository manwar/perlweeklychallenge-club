# Ryan Thompson

## Week 165 Solutions

### Task 1 › SVG

 * [Perl](perl/ch-1.pl)

    $ ./ch-1.pl [options]

        --height=N          Height in pixels
        --width=N           Width in pixels
        --stroke=N          Stroke width
        --line-color=str    Line color (CSS color value)
        --point-color=str   Point color (CSS color value)
        --radius=N          Point radius
        --nocredits         Disable credits in SVG file

### Task 2 › Line of Best Fit

 * [Perl](perl/ch-2.pl)

    $ ./ch-2.pl

### Bonus › Point Generator

 * [Perl](perl/gen_points.pl)

    $ ./gen_points.pl [options]

        --height=N      Height in pixels
        --width=N       Width in pixels

        --slope=N       Slope
        --m=N

        --intercept=N   y-intercept
        --b=N

### Recommended Pipeline

    $ ./gen_points.pl [options] | ./ch-2.pl | ./ch-1.pl

## Blogs

 * [Simple SVG Generator](https://ry.ca/2022/05/simple-svg-generator/)
