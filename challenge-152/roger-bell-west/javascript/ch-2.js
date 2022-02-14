#! /usr/bin/node

function Rect(xy1,xy2) {
    let r=Object.create(Rect.methods);
    r.xy1=[Math.min(xy1[0],xy2[0]),Math.min(xy1[1],xy2[1])];
    r.xy2=[Math.max(xy1[0],xy2[0]),Math.max(xy1[1],xy2[1])];
    return r;
}

Rect.methods = {
    area() {
        let area=1;
        for (let axis=0;axis<=1;axis++) {
            area *= this.xy2[axis]-this.xy1[axis];
        }
        return area;
    },

    overlap(other) {
        let area=1;
        for (let axis=0;axis<=1;axis++) {
            area *= Math.max(0,
                             Math.min(this.xy2[axis],other.xy2[axis])-
                             Math.max(this.xy1[axis],other.xy1[axis])
                            );
        }
        return area;
    },

    fullarea(other) {
        return this.area()+other.area()-this.overlap(other);
    }
}

if (new Rect([-1,0],[2,2]).fullarea(new Rect([0,-1],[4,4])) == 22) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write(" ");

if (new Rect([-3,-1],[1,3]).fullarea(new Rect([-1,-3],[2,2])) == 25) {
    process.stdout.write("Pass");
} else {
    process.stdout.write("FAIL");
}
process.stdout.write("\n");

