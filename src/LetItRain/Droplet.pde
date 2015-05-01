class Droplet {

    long id;

    float currX;
    float currY;

    float prevX;
    float prevY;

    PVector velocity;
    color dropletColor;

    Droplet(int id) {
        this.id = id;
        this.initialize();
    }

    void initialize() {
        this.velocity = new PVector(5,10);
        this.currX = random(displayWidth);
        this.currY = random(displayHeight);
        this.prevX = this.currX;
        this.prevY = this.currY;

        int c = (int)random(90, 255);
        this.dropletColor = color(c, c);
    }

    void update() {
        this.prevX = this.currX;
        this.prevY = this.currY;
        this.currY += this.velocity.y;
        this.currX += this.velocity.x;

        if (this.currY >= displayHeight || this.currX < 0 || this.currX >= displayWidth) {
          this.reset();
          return;
        }
    }

    void draw(PGraphics pg) {
        this.drawPixel(pg, this.currX, this.currY, this.dropletColor);
    }

    void drawPixel(PGraphics pg, float fx, float fy, color c) {

        int ix = round(fx);
        int iy = round(fy);

        if (ix < 0 || ix >= displayWidth || iy < 0 || iy >= displayHeight) {
            return;
        }

        pg.pixels[ix + iy * displayWidth] = c;
    }

    void reset() {
        this.initialize();
    }
}
