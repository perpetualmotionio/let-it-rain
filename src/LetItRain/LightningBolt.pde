float maxDTheta = PI/10;
float minDTheta = PI/20;
float maxTheta = PI/2;
float childGenOdds = .01;

class LightningBolt {

  float lineWidth0,theta,x0,y0,x1,y1,x2,y2,straightJump,straightJumpMax,straightJumpMin,lineWidth;
  color myColor;

  LightningBolt(float x0I, float y0I, float width0, float theta0, float jumpMin, float jumpMax, color inputColor){

    lineWidth0 = width0;
    lineWidth = width0;
    theta = theta0;
    x0 = x0I;
    y0 = y0I;
    x1 = x0I;
    y1 = y0I;
    x2 = x0I;
    y2 = y0I;
    straightJumpMin = jumpMin;
    straightJumpMax = jumpMax;
    myColor = inputColor;
    straightJump = random(straightJumpMin,straightJumpMax);
  }

  void draw()
  {
    while(y2<height && (x2>0 && x2<width))
    {
      strokeWeight(1);

      theta += randomSign()*random(minDTheta, maxDTheta);
      if(theta>maxTheta)
        theta = maxTheta;
      if(theta<-maxTheta)
        theta = -maxTheta;

      straightJump = random(straightJumpMin,straightJumpMax);
      x2 = x1-straightJump*cos(theta-HALF_PI);
      y2 = y1-straightJump*sin(theta-HALF_PI);

      lineWidth = map(y2, height,y0, 1,lineWidth0);
      if(lineWidth<0)
        lineWidth = 0;
      stroke(myColor);
      strokeWeight(lineWidth);
      line(x1,y1,x2,y2);
      x1=x2;
      y1=y2;

      if(random(0,1)<childGenOdds) {
        float newTheta = theta;
        newTheta += randomSign()*random(minDTheta, maxDTheta);
        if(theta>maxTheta)
          theta = maxTheta;
        if(theta<-maxTheta)
          theta = -maxTheta;

        (new LightningBolt(x2, y2, lineWidth, newTheta, straightJumpMin, straightJumpMax,color(0,0,99))).draw();
      }
    }
  }

  int randomSign() //returns +1 or -1
  {
    float num = random(-1,1);
    if(num==0)
      return -1;
    else
      return (int)(num/abs(num));
  }
}
