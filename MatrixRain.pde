public static String katakana = "GXYPMKbi/?^\"-([";
int start = 200;
PFont font;
Matrix[] instance = new Matrix[start];
int width = 1920;
int height = 1080;
void setup(){
  size(1920,1080);
  font = createFont("katakana.ttf", 1000);
  for(int i =0;i<start;i++){
    instance[i] = new Matrix(new PVector(int(random(-10,width+10)),0),int(random(20,50)),int(random(2,50)),random(4,13), int(random(2,4)), int(random(20,50)), int(random(20,256)));
    //instance[i] = new Matrix(new PVector(100,0),20,100,4,2,20,255);
  }
}

int endPoint;

void draw(){
  background(0);
  for(int i =0;i<start;i++){
    instance[i].draw();
  }
  saveFrame("MatrixRain-######.jpg");
  
  for(int i =0;i<start;i++){
     endPoint = int(instance[i].getYposition()) - int(instance[i].getNoOfLetter()*(instance[i].getSize()/2) + (instance[i].getNoOfLetter()-1)*4);
    if(endPoint>=height){ //<>//
      instance[i].setPosition(random(-10,width+10),instance[i].getStartPosition().y);
      instance[i].setInitialSpeed(random(4,13));
      instance[i].setSize(int(random(2,50)));
      instance[i].setOpacity(int(random(20,256)));
    }
  }
}

class Matrix{

  private PVector startPosition;
  private PVector position;
  private int noOfLetter;
  private char[] letters;
  private int[] counter;
  private int size;
  private float initialSpeed;
  private float speed;
  private int motionBlur;
  private int speedCounter;
  private int opacity;
  
  public Matrix(PVector startPosition, int noOfLetter, int size,float speed, int motionBlur, int speedCounter, int opacity){
    this.startPosition = startPosition;
    this.position = new PVector(startPosition.x,startPosition.y);
    this.noOfLetter = noOfLetter;
    letters = new char[noOfLetter];
    counter = new int[noOfLetter];
    this.size = size;
    this.initialSpeed = speed;
    this.speed = speed;
    this.motionBlur = motionBlur;
    this.speedCounter = speedCounter;
    this.opacity = opacity;
    initialize();
  }
  
  int getSize(){
    return this.size;
  }
  
  int getNoOfLetter(){
    return this.noOfLetter;
  }
  
  float getYposition(){
    return this.position.y;
  }
  
  PVector getStartPosition(){
    return this.startPosition;
  }
  
  void setPosition(float x, float y){
    this.position.x = x;
    this.position.y = y;
  }
  
  void setInitialSpeed(float speed){
    this.initialSpeed = speed;
  }
  
  void setOpacity(int opacity){
    this.opacity = opacity;
  }
  
  void setSize(int size){
    this.size = size;
  }
  
  void draw(){
    
    push();
      textAlign(CENTER, BOTTOM);
      counterCheckAndLetterRandomize();
      speedRandomize();
      translate(position.x,position.y);
      position.y = position.y+speed;
      int alphaMax;
      int colorMax;
      for(int i =0;i<noOfLetter;i++){
        alphaMax = opacity - int(pow(i,3)*(opacity/pow(noOfLetter,3)));
        //alphaMax = 255;
        colorMax = int(pow(noOfLetter - i,5)*(255/pow(noOfLetter,5)));
        push();
          fill(colorMax,255,colorMax,alphaMax);
          textFont(font);
          textSize(size);
          //text(tempChar, 0,0,100);
          text(letters[i], 0,-i*(int(size/2)+4));
        pop();
        //Motion Blur on top
        for(int j =0;j<motionBlur;j++){
          push();
            fill(colorMax,255,colorMax,alphaMax - int(pow(j,1)*(alphaMax/pow(motionBlur,1))));
            textFont(font);
            textSize(size);
            //text(tempChar, 0,0,100);
            text(letters[i], 0,-i*(int(size/2)+4) - int(j*int(speed)));
          pop();
        }
        
        //Glow kinda
        push();
          fill(colorMax,255,colorMax,alphaMax/3.5);
          textFont(font);
          textSize(size+int(size/10));
          //text(tempChar, 0,0,100);
          text(letters[i], 0,-i*(int(size/2)+4));
        pop();
      }
    pop();
  }
  
  private void speedRandomize(){
    if(speedCounter<0){
      speedCounter = int(random(20,50));
      speed = initialSpeed + int(random(-abs(initialSpeed)/4,abs(initialSpeed)/4));
    }
    speedCounter--;
  }
  
  private void initialize(){
    for(int i =0;i<noOfLetter;i++){
      counter[i] = int(random(15,40));
    }
    for(int i =0;i<noOfLetter;i++){
      letters[i] = katakana.charAt(int(random(katakana.length()-1+0.1)));
    }
  }
  
  private void counterCheckAndLetterRandomize(){
    for(int i =0;i<noOfLetter;i++){
      if(counter[i] < 0){
        counter[i] = int(random(10,20));
        characterRandomize(i);
      }
      counter[i]--;
    }
  }
  
  private void characterRandomize(int index){
    letters[index] = katakana.charAt(int(random(katakana.length()-1+0.1)));
  }
  
}
