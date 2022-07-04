import java.lang.reflect.Method;

class Compose{

    private Method f, g;

    public void setF(Method _f){
        this.f = _f;
    }
    
    public void setG(Method _g){
        this.g = _g;
    }

    public int f(int x){
        return x + x;
    }
    
    public int g(int x){
        return x * x;
    }
    
    public int h(int x){
        try{
            return ((Integer) this.f.invoke(this, new Object[]{this.g.invoke(this, new Object[]{new Integer(x)})})).intValue();
        }
        catch(java.lang.reflect.InvocationTargetException ite){
            exceptionMessageInvoke(ite);
        }
        catch(IllegalArgumentException iae){
            exceptionMessageInvoke(iae);
        }
        catch(IllegalAccessException iae){
            exceptionMessageInvoke(iae);
        }
        return -1;
    }
    
    public Method compose(Method f, Method g){
        setF(f);
        setG(g);
        Method h = null;
        try{
            h = Compose.class.getMethod("h", new Class[]{int.class});
        }
        catch(NoSuchMethodException e){
            e.printStackTrace();
        }
        return h;
    }
    
    public static void exceptionMessageInvoke(Exception e){
         System.out.println("Error executing h");
         e.printStackTrace();
    }
    
    public static void main(String[] args){
        Compose composer = new Compose();
        try{
            Method f = Compose.class.getMethod("f", new Class[]{int.class});
            Method g = Compose.class.getMethod("g", new Class[]{int.class});
            Method h = composer.compose(f, g);
            try{
                int x = ((Integer)h.invoke(composer, new Object[]{new Integer(7)})).intValue();
                System.out.println(x);
            }
            catch(java.lang.reflect.InvocationTargetException ite){
                exceptionMessageInvoke(ite);
            }
            catch(IllegalArgumentException iae){
                exceptionMessageInvoke(iae);
            }
            catch(IllegalAccessException iae){
                exceptionMessageInvoke(iae);
            }
        }
        catch(NoSuchMethodException nsme){
            System.out.println("Method not found.");
            System.exit(1);
        }
    }
}