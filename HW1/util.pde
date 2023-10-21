public void CGLine(float x1, float y1, float x2, float y2) {
    // Calculate differences between the coordinates
    // and the sign of the differences
    int dx = (int)abs(x2 - x1);
    int dy = (int)abs(y2 - y1);
    int sx = x1 < x2 ? 1 : -1; // sx is the sign of x
    int sy = y1 < y2 ? 1 : -1; // sy is the sign of y

    // Calculate the error
    int err = dx - dy;

    int x = (int)x1;
    int y = (int)y1;
    // Loop until the line is drawn
    while (x != (int)x2) {
        // Draw the pixel at the correct place
        drawPoint(x, y, color(0));

        // Calculate the error for the next step
        float e2 = 2 * err;

        // Update the error value based on the new error
        // and the sign of the y coordinate
        if (e2 > -dy) {
            err -= dy;
            x += sx;
        }

        // Update the error value based on the new error
        // and the sign of the x coordinate
        if (e2 < dx) {
            err += dx;
            y += sy;
        }
    }
}

public void CGCircle(float x, float y, float r) {
    float d = 1 - r;
    float x1 = 0;
    float y1 = r;
    while (x1 <= y1) {
        drawPoint(x + x1, y + y1, color(0));
        drawPoint(x + y1, y + x1, color(0));
        drawPoint(x + y1, y - x1, color(0));
        drawPoint(x + x1, y - y1, color(0));
        drawPoint(x - x1, y - y1, color(0));
        drawPoint(x - y1, y - x1, color(0));
        drawPoint(x - y1, y + x1, color(0));
        drawPoint(x - x1, y + y1, color(0));
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

public void CGEllipse(float x, float y, float r1, float r2) {
    float r1squared = r1 * r1;
    float r2squared = r2 * r2;
    float x1 = 0;
    float y1 = r2;
    float d1 = r2squared - r1squared * r2 + 0.25f * r1squared;
    float dx = 2 * r2squared * x1;
    float dy = 2 * r1squared * y1;
    while (dx < dy) {
        drawPoint(x + x1, y + y1, color(0));
        drawPoint(x - x1, y + y1, color(0));
        drawPoint(x - x1, y - y1, color(0));
        drawPoint(x + x1, y - y1, color(0));
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
        drawPoint(x + x1, y + y1, color(0));
        drawPoint(x - x1, y + y1, color(0));
        drawPoint(x - x1, y - y1, color(0));
        drawPoint(x + x1, y - y1, color(0));
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

public void CGCurve(Vector3 p1, Vector3 p2, Vector3 p3, Vector3 p4) {
    float t = 0;
    while (t <= 1) {
        float x = bezierPoint(p1.x, p2.x, p3.x, p4.x, t);
        float y = bezierPoint(p1.y, p2.y, p3.y, p4.y, t);
        drawPoint(x, y, color(0));
        t += 0.001;
    }
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
