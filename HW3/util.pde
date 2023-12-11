public void CGLine(float x1, float y1, float x2, float y2) {
    stroke(0);
    line(x1, y1, x2, y2);
}
public boolean outOfBoundary(float x, float y) {
    if (x < 0 || x >= width || y < 0 || y >= height) return true;
    return false;
}

public void drawPoint(float x, float y, color c) {
    int index = (int)y * width + (int)x;
    if (outOfBoundary(x, y)) return;
    pixels[index] = c;
}

public float distance(Vector3 a, Vector3 b) {
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c, c));
}

boolean pnpoly(float x, float y, Vector3[] vertexes) {
  // To-Do : You need to check the coordinate p(x,v) if inside the vertexes. If yes return true.
    
  boolean c = false;

  int i, j;
  for (i = 0, j = vertexes.length - 1; i < vertexes.length; j = i++) {
    if ( ((vertexes[i].y > y) != (vertexes[j].y > y)) &&
     (x < (vertexes[j].x - vertexes[i].x) * (y - vertexes[i].y) / (vertexes[j].y - vertexes[i].y) + vertexes[i].x) )
       c = !c;
  }

  return c;
}

public Vector3[] findBoundBox(Vector3[] v) {
    Vector3 recordminV = new Vector3(Float.MAX_VALUE);
    Vector3 recordmaxV = new Vector3(Float.MIN_VALUE);
    // To-Do : You need to find the bounding box of the vertexes v.
    
    //     r1 -------
    //       |   /\  |
    //       |  /  \ |
    //       | /____\|
    //        ------- r2
    
    for (Vector3 vertex : v) {
        if (vertex.x < recordminV.x) recordminV.x = vertex.x;
        if (vertex.y < recordminV.y) recordminV.y = vertex.y;
        if (vertex.z < recordminV.z) recordminV.z = vertex.z;

        if (vertex.x > recordmaxV.x) recordmaxV.x = vertex.x;
        if (vertex.y > recordmaxV.y) recordmaxV.y = vertex.y;
        if (vertex.z > recordmaxV.z) recordmaxV.z = vertex.z;
    }

    Vector3[] result = {recordminV, recordmaxV};

    return result;
}

public Vector3[] Sutherland_Hodgman_algorithm(Vector3[] points, Vector3[] boundary) {
    ArrayList<Vector3> input=new ArrayList<Vector3>();
    ArrayList<Vector3> output=new ArrayList<Vector3>();
    for (int i=0; i < points.length; i+=1) {
        input.add(points[i]);
    }

    // To-Do
    // You need to implement the Sutherland Hodgman Algorithm in this section.
    // The function you pass 2 parameter. One is the vertexes of the shape "points".
    // And the other is the vertexes of the "boundary".
    // The output is the vertexes of the polygon.

    // iterate through each edge of the boundary
    for (int i = 0; i < boundary.length; i++) {
        Vector3 clipEdgeStart = boundary[i]; // start point of the edge
        Vector3 clipEdgeEnd = boundary[(i + 1) % boundary.length]; // end point of the edge

        output.clear();

        // iterate through each edge of the polygon
        for (int j = 0; j < input.size(); j++) {
            Vector3 currentPoint = input.get(j); // current point
            Vector3 prevPoint = input.get((j + input.size() - 1) % input.size());  // previous point

            boolean currentInside = isInside(clipEdgeStart, clipEdgeEnd, currentPoint); // check if current point is inside the boundary
            boolean prevInside = isInside(clipEdgeStart, clipEdgeEnd, prevPoint); // check if previous point is inside the boundary

            // if current point is inside the boundary, add it to the output
            if (currentInside) {
                // if previous point is outside the boundary, add the intersection point to the output
                if (!prevInside) {
                    output.add(intersect(prevPoint, currentPoint, clipEdgeStart, clipEdgeEnd));
                }
                output.add(currentPoint);
            } 
            // if previous point is inside the boundary, add the intersection point to the output
            else if (prevInside) {
                output.add(intersect(prevPoint, currentPoint, clipEdgeStart, clipEdgeEnd));
            }
        }

        input = new ArrayList<Vector3>(output);
    }

    Vector3[] result = new Vector3[output.size()];
    for (int i=0; i < result.length; i+=1) {
        result[i] = output.get(i);
    }
    return result;
}

public float getDepth(float x, float y, Vector3[] vertex ) {
    // To - Do
    // You need to calculate the depth (z) in the triangle (vertex) based on the positions x and y. and return the z value;

    return 0.0;
}

float[] barycentric(Vector3 P, Vector4[] verts) {

    Vector3 A=verts[0].homogenized();
    Vector3 B=verts[1].homogenized();
    Vector3 C=verts[2].homogenized();

    // To - Do (HW4)
    // Calculate the barycentric coordinates of point P in the triangle verts using the barycentric coordinate system.


    float[] result={0.0, 0.0, 0.0};

    return result;
}
