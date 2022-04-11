// The Weekly Challenge 159
// Task 2 Moebius Function
// Usage: java Moebius N

public class Moebius
{
    public static void main(String[] args)
    {
        int N = 1;
        try {
            N = Integer.parseInt(args[0]);
            if (N<=0)
                throw new ArithmeticException(); 
        } catch (Exception e) {
            System.err.print("Please use a positive integer ");
            System.err.println("as your parameter.");
            System.exit(0);
        }
        double[][] complex1 = new double[][] { {1, 0} , {0, 1} };
        double[][] complex2 = new double[][] { {0, 1} , {-1, 0} };
        System.out.println(Math.round(mu(N)));
    }


    public static double mu(int n)
    {
        double[][] sum = ithRootOfUnityModuloN(1, n);
        LOOP: for (int i=2; i<n; i++) 
        {
            for (int s=2; s<n; s++)
            {
                if ( (i*s) % n == 0 )
                    continue LOOP;
            }
            sum = complexAddition(sum, ithRootOfUnityModuloN(i,n));
        }
        return sum[0][0];
    }


    public static double[][] complexAddition(double[][] c1, double[][] c2)
    {
        double a = c1[0][0];
        double b = c1[0][1];
        double c = c1[1][0];
        double d = c1[1][1];
        double e = c2[0][0];
        double f = c2[0][1];
        double g = c2[1][0];
        double h = c2[1][1];
        return new double[][] {{ a+e, b+f }, { c+g, d+h }};
    }



    public static double[][] complexMultiplication(double[][] c1, double[][] c2)
    {
        double a = c1[0][0];
        double b = c1[0][1];
        double c = c1[1][0];
        double d = c1[1][1];
        double e = c2[0][0];
        double f = c2[0][1];
        double g = c2[1][0];
        double h = c2[1][1];
        return new double[][] {{a*e+b*g, a*f+b*h}, {c*e+d*g, c*f+d*h}};
    }



    public static double[][] ithRootOfUnityModuloN(int i , int n)
    {
        double realPart = Math.cos(2*Math.PI*i/n);
        double imaginaryPart = Math.sin(2*Math.PI*i/n);
        double[][] result = new double[][] {
                              {realPart, imaginaryPart},
                              {-imaginaryPart, realPart}  
                            };
        return result;
    }
}
