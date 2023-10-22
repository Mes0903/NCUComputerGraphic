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

public void CGCircle(float x, float y, float r, color c) {
    int d = int(1 - r);
    int x1 = 0;
    int y1 = (int)r;
    while (x1 <= y1) {
        drawPoint((int)x + x1, (int)y + y1, c);
        drawPoint((int)x + y1, (int)y + x1, c);
        drawPoint((int)x + y1, (int)y - x1, c);
        drawPoint((int)x + x1, (int)y - y1, c);
        drawPoint((int)x - x1, (int)y - y1, c);
        drawPoint((int)x - y1, (int)y - x1, c);
        drawPoint((int)x - y1, (int)y + x1, c);
        drawPoint((int)x - x1, (int)y + y1, c);
        if (d < 0) {
            d += 2 * x1 + 3;
        } 
        else {
            d += 2 * (x1 - y1) + 5;
            y1--;
        }
        x1++;
    }
}

public void CGCircle(float x, float y, float r) {
    CGCircle(x, y, r, color(255, 0, 0));
}

public void CGEllipse(float x, float y, float r1, float r2, color c) {
    float r1squared = r1 * r1;
    float r2squared = r2 * r2;
    float x1 = 0;
    float y1 = r2;
    float d1 = r2squared - r1squared * r2 + 0.25f * r1squared;
    float dx = 2 * r2squared * x1;
    float dy = 2 * r1squared * y1;
    while (dx < dy) {
        drawPoint(x + x1, y + y1, c);
        drawPoint(x - x1, y + y1, c);
        drawPoint(x - x1, y - y1, c);
        drawPoint(x + x1, y - y1, c);
        if (d1 < 0) {
            dx += 2 * r2squared;
            d1 += dx + r2squared;
        } 
        else {
            dx += 2 * r2squared;
            dy -= 2 * r1squared;
            d1 += dx - dy + r2squared;
            y1--;
        }
        x1++;
    }

    float d2 = r2squared * (x1 + 0.5f) * (x1 + 0.5f) + r1squared * (y1 - 1) * (y1 - 1) - r1squared * r2squared;
    while (y1 >= 0) {
        drawPoint(x + x1, y + y1, c);
        drawPoint(x - x1, y + y1, c);
        drawPoint(x - x1, y - y1, c);
        drawPoint(x + x1, y - y1, c);
        if (d2 > 0) {
            dy -= 2 * r1squared;
            d2 += r1squared - dy;
        } 
        else {
            dx += 2 * r2squared;
            dy -= 2 * r1squared;
            d2 += dx - dy + r1squared;
            x1++;
        }
        y1--;
    }
}

public void CGEllipse(float x, float y, float r1, float r2) {
    CGEllipse(x, y, r1, r2, color(255, 0, 0));
}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4, color c) {
    float t = 0;
    while (t <= 1) {
        float x = bezierPoint(p1.x, p2.x, p3.x, p4.x, t);
        float y = bezierPoint(p1.y, p2.y, p3.y, p4.y, t);
        drawPoint(x, y, c);
        t += 0.001;
    }
}

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    CGCurve(p1, p2, p3, p4, color(255, 0, 0));
}

public void CGEraser(Vector3 p1, Vector3 p2) {
    float x1 = min(p1.x, p2.x);
    float y1 = min(p1.y, p2.y);
    float x2 = max(p1.x, p2.x);
    float y2 = max(p1.y, p2.y);
    for (int x = (int)x1; x <= x2; x++) {
        for (int y = (int)y1; y <= y2; y++) {
            set(x, y, color(250));
        }
    }
}

public void drawPoint(float x, float y, color c){
    stroke(c);
    point(x,y);
}

public float distance(Vector3 a, Vector3 b){
    Vector3 c = a.sub(b);
    return sqrt(Vector3.dot(c,c));
}