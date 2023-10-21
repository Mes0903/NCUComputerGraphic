abstract public class Shape{
    abstract public void drawShape();
    public void setShapeColor() {
        float R = random(0,255);
        float G = random(0,255);
        float B = random(0,255);
        shapeColor = color(R,G,B);
    };
    public color shapeColor = color(0);
}

public class Point extends Shape{
    ArrayList<Vector3> points = new ArrayList<Vector3>();
    public Point(ArrayList<Vector3> p){
        points = p;
    }
  
    @Override
    public void drawShape(){
        if(points.size()<=1) return;  
        for(int i=0;i<points.size()-1;i++){
            Vector3 p1 = points.get(i);
            Vector3 p2 = points.get(i+1);
            CGLine(p1.x,p1.y,p2.x,p2.y,shapeColor);
        }
    }
}

public class Line extends Shape{
    Vector3 point1;
    Vector3 point2;
    
    public Line(){};
    public Line(Vector3 v1,Vector3 v2){
        point1 = v1;
        point2 = v2;
    }
    
    @Override
    public void drawShape(){
        CGLine(point1.x,point1.y,point2.x,point2.y,shapeColor);
    }
    
   
}

public class Circle extends Shape{
    Vector3 center;
    float radius;
    public Circle(){}
    public Circle(Vector3 v1,float r){
        center = v1;
        radius = r;
    }
    @Override
    public void drawShape(){
        CGCircle(center.x,center.y,radius,shapeColor);
    }   
}

public class Polygon extends Shape{
    ArrayList<Vector3> verties = new ArrayList<Vector3>();
     public Polygon(ArrayList<Vector3> v){
        verties= v;
    }
    
    @Override
    public void drawShape(){
        if(verties.size()<=0) return;
        for(int i=0;i<=verties.size();i++){
              Vector3 p1 = verties.get(i%verties.size());
              Vector3 p2 = verties.get((i+1)%verties.size());
              CGLine(p1.x,p1.y,p2.x,p2.y,shapeColor);
         }
    } 
}

public class Ellipse extends Shape{
    Vector3 center;
    float radius1,radius2;
    
    public Ellipse(){}
    public Ellipse(Vector3 cen,float r1,float r2){
        center = cen;
        radius1 = r1;
        radius2 = r2;
    }
    
    @Override
    public void drawShape(){
        CGEllipse(center.x,center.y,radius1,radius2,shapeColor);
    }
}

public class Curve extends Shape{
    Vector3 cpoint1,cpoint2,cpoint3,cpoint4;
    float radius1,radius2;
    
    public Curve(){}
    public Curve(Vector3 p1,Vector3 p2,Vector3 p3,Vector3 p4){
       cpoint1 = p1; cpoint2 = p2; cpoint3 = p3; cpoint4 = p4;
    }
    
    @Override
    public void drawShape(){
        CGCurve(cpoint1,cpoint2,cpoint3,cpoint4,shapeColor);
    }
}

public class EraseArea extends Shape{
    Vector3 point1,point2;
    public EraseArea(){}
    public EraseArea(Vector3 p1,Vector3 p2){
       point1 = p1; point2 = p2; 
    }
    @Override
    public void drawShape(){
        CGEraser(point1,point2);
    }
}
