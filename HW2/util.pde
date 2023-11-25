public void CGLine(float x1, float y1, float x2, float y2, color c) {
    // Calculate differences between the coordinates
    // and the sign of the differences
    boolean steep = abs(y2 - y1) > abs(x2 - x1); 

    if (steep) {
        // swap x1, y1
        float temp = x1;
        x1 = y1;
        y1 = temp;

        // swap x2, y2
        temp = x2;
        x2 = y2;
        y2 = temp;
    }

    if(x1 > x2) {
        // swap x1, x2
        float temp = x1;
        x1 = x2;
        x2 = temp;

        // swap y1, y2
        temp = y1;
        y1 = y2;
        y2 = temp;
    }

    int dx = int(x2 - x1); // the difference between x1 and x2
    int dy = int(abs(y2 - y1)); // the difference between y1 and y2
    int derror = abs(dy) * 2; // the degree of error
    int error = 0; // the error
    int ystep = (y1 < y2) ? 1 : -1; // the step size of y

    for (int x = (int)x1, y = (int)y1; x <= (int)x2; x++) {
        if (steep)
            drawPoint(y, x, c);
        else 
            drawPoint(x, y, c);

        error += derror;
        // if the delta is smaller than middle point, draw the downer pixel, otherwise draw the upper pixel
        if(error > dx) {
            y += ystep;
            error -=  dx * 2;
        }
    }
}


public void CGLine(float x1, float y1, float x2, float y2){
    CGLine(x1, y1, x2, y2, color(255, 0, 0));
}

public boolean outOfBoundary(float x,float y){
    if(x < 0 || x >= width || y < 0 || y >= height) return true;
    return false;
}

public void drawPoint(float x,float y,color c){
    int index = (int)y * width + (int)x;
    if(outOfBoundary(x,y)) return;
    pixels[index] = c;
}

public float distance(Vector3 a,Vector3 b){
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c,c));
}



boolean pnpoly(float x, float y, Vector3[] vertexes) {
  // To-Do : You need to check the coordinate p(x,v) if inside the vertexes. If yes return true.
    
  boolean c = false;

    
  return c;
}

public Vector3[] findBoundBox(Vector3[] v) {
    Vector3 recordminV=new Vector3(1.0/0.0);
    Vector3 recordmaxV=new Vector3(-1.0/0.0);
    // To-Do : You need to find the bounding box of the vertexes v.
    
   //     r1 -------
   //       |   /\  |
   //       |  /  \ |
   //       | /____\|
   //        ------- r2
    

    Vector3[] result={recordminV, recordmaxV};
    return result;
    

}


public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points,Vector3[] boundary){
    ArrayList<Vector3> input=new ArrayList<Vector3>();
    ArrayList<Vector3> output=new ArrayList<Vector3>();
    for (int i=0; i<points.length; i+=1) {
        input.add(points[i]);
    }
    
    // To-Do
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.
    
    
     output = input;
    
    
    
    Vector3[] result=new Vector3[output.size()];
    for (int i=0; i<result.length; i+=1) {
        result[i]=output.get(i);
    }
    return result;
}
