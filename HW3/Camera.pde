public class Camera {
    Matrix4 projection=new Matrix4();
    Matrix4 worldView=new Matrix4();
    int wid;
    int hei;
    float near;
    float far;
    Transform transform;
    Camera() {
        wid=256;
        hei=256;
        worldView.makeIdentity();
        projection.makeIdentity();
        transform = new Transform();
    }

    Matrix4 inverseProjection() {
        Matrix4 invProjection = Matrix4.Zero();
        float a = projection.m[0];
        float b = projection.m[5];
        float c = projection.m[10];
        float d = projection.m[11];
        float e = projection.m[14];
        invProjection.m[0] = 1.0f / a;
        invProjection.m[5] = 1.0f / b;
        invProjection.m[11] = 1.0f / e;
        invProjection.m[14] = 1.0f / d;
        invProjection.m[15] = -c / (d * e);
        return invProjection;
    }

    Matrix4 Matrix() {
        return projection.mult(worldView);
    }


    void setSize(int w, int h, float n, float f) {
        // Setting the camera's width, height, near and far planes
        wid = w;
        hei = h;
        near = n;
        far = f;

        println("Camera size: " + wid + "x" + hei + " near: " + near + " far: " + far);
        

        // Calculate the aspect ratio and the field of view in radians
        float e = 1.0f / tan(GH_FOV * 2*PI / 360.0f);
        float a = float(h) / float(w);
        float d = near - far;

        // Creating the projection matrix for a perspective projection
        projection.makeZero(); // Resetting the projection matrix to zero
        projection.m[0] = 1;
        projection.m[5] = a;
        projection.m[10] = far / -d * (1/e);
        projection.m[11] = (near * far) / d * (1/e);
        projection.m[14] = 1/e;
    }

    void setPositionOrientation(Vector3 pos, float rotX, float rotY) {}

    void setPositionOrientation(Vector3 pos, Vector3 lookat) {
        // T
        Matrix4 T = Matrix4.Trans(pos.mult(-1));

        // Calculate the forward vector (lookat - position)
        Vector3 forward = Vector3.sub(lookat, pos).unit_vector();

        // Define the up vector (world's up forward)
        Vector3 up = new Vector3(0, 1, 0);

        // Calculate the right vector (cross product of up and forward)
        Vector3 right = Vector3.cross(forward, up).unit_vector();

        // Calculate the real up vector (cross product of forward and right)
        up = Vector3.cross(right, forward).unit_vector();

        // GRM
        Matrix4 GRM = Matrix4.Identity();
        GRM.m[0] = right.x;   GRM.m[1] = right.y;   GRM.m[2] = right.z;
        GRM.m[4] = up.x;      GRM.m[5] = up.y;      GRM.m[6] = up.z;
        GRM.m[8] = forward.x; GRM.m[9] = forward.y; GRM.m[10] = forward.z;

        worldView = GRM.mult(T);
    }
}
