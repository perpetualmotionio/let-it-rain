class Drop {

    boolean shouldDieAfterRender = false;

    long id;

    float currX;
    float currY;

    float prevX;
    float prevY;

    PVector velocity;
    SimpleOpenNI context;
    color dropletColor;

    Drop(int id, SimpleOpenNI context) {
        this.id = id;
        this.context = context;
        this.initialize();
    }

    void initialize() {
        this.shouldDieAfterRender = false;
        this.velocity = new PVector(random(1, 6), random(10, 30));
        this.currX = random(width);
        this.currY = random(-height);
        this.prevX = this.currX;
        this.prevY = this.currY;

        int c = (int)random(90, 255);
        this.dropletColor = color(c, c);
    }

    void update() {
        this.prevX = this.currX;
        this.prevY = this.currY;

        this.currX += this.velocity.x;
        this.currY += this.velocity.y;

        if (this.isOutsideViewport(this.currX, this.currY))
        {
          this.reset();
          return;
        }
    }

    boolean isOutsideViewport(float fx, float fy)
    {
        return fy >= height || fx < 0 || fx >= width;
    }

    boolean hasImpactedUser(int ix, int iy)
    {
        return (this.context.userMap()[(int)((ix + (iy * width))/scale)]) != 0;
    }

    void draw(PGraphics pg) {
        this.drawSilhouette(pg, (int)this.currX, (int)this.currY, this.dropletColor);

        if (this.shouldDieAfterRender)
        {
            this.initialize();
        }
    }

    void drawSilhouette(PGraphics pg, int ix, int iy, color c) {
        if (iy < 0) return;
        if (this.hasImpactedUser(ix, iy))
        {
          this.shouldDieAfterRender = true;
          this.drawSilhouette(pg, ix, iy - 1, c);
        } else {
          this.drawPixel(pg, ix, iy, c);
        }
    }

    void drawPixel(PGraphics pg, float fx, float fy, color c) {

        int ix = round(fx);
        int iy = round(fy);

        if (ix < 0 || ix >= width || iy < 0 || iy >= height) {
            return;
        }

        pg.pixels[ix + iy * width] = c;
    }

    void reset() {
        this.initialize();
    }
}
