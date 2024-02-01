ArrayList<Integer>I = new ArrayList<Integer>();
ArrayList<Integer>J = new ArrayList<Integer>();
ArrayList<Integer>ansI = new ArrayList<Integer>();
ArrayList<Integer>ansJ = new ArrayList<Integer>();
boolean [][]visited = new boolean[512][512];
void setup(){
  size(512, 512);
  background(255);
}

void draw(){

}

void mouseDragged(){
  fill(0);
  ellipse(mouseX, mouseY, 20, 20);
}
int drawI = 0;
void keyPressed(){
  if (key=='1'){
    stroke(255, 0, 0);
    int ii=ansI.get(drawI), jj=ansJ.get(drawI);
    ellipse(jj, ii, 3, 3);
    drawI++;
    println(drawI);
  }
  if (key == 'r'){
    background(255);
    PImage now = loadImage("image.png");
    image(now, 0, 0);
  }
  if (key == 's') saveFrame("image.png");
  if (key == 'c'){
    int white=0, black=0;
    loadPixels();
    for (int i=0; i<512*512; i++){
      color c = pixels[i];
      if (c==-1) white++;
      if (c==-16777216){
        black++;
        int ii=int(i/512), jj=i%512;
        I.add(ii);
        J.add(jj);
        visited[ii][jj] = true;
      }
    }
    updatePixels();
    println("white:" + white +  "black:" + black);
    println("ArrayList<Integer>I no size is:"+I.size());
    while(I.size()>0){
      int ii=I.get(0), jj=J.get(0);
      I.remove(0);
      J.remove(0);
      testAndAdd(ii+1, jj);
      testAndAdd(ii-1, jj);
      testAndAdd(ii, jj+1);
      testAndAdd(ii, jj-1);
    }
  }
  print("color 255 is:" + color(255));
  print("color 0 is:" + color(0));
  //for (int i=0; i<ansI.size(); i++){
  //  int ii = ansI.get(i), jj = ansJ.get(i);
  //  stroke(0, 255, 0);
  //  ellipse(jj, ii, 3, 3);
  //}
}
void testAndAdd(int i, int j){
  if (i<0 || j<0 || i>=512 || j>=512) return;
  if (visited[i][j]) return;
  if (pixels[i*512+j]!=-16777216){ // if it's white
    ansI.add(i);
    ansJ.add(j);
    visited[i][j] = true;
  }
}
