// how to find the contour
ArrayList<Integer>I = new ArrayList<Integer>();
ArrayList<Integer>J = new ArrayList<Integer>();
ArrayList<Integer>ansI = new ArrayList<Integer>();
ArrayList<Integer>ansJ = new ArrayList<Integer>();
boolean [][]visited = new boolean[512][512];
boolean [][]contour = new boolean[512][512];

void setup(){
  size(512, 512);
  background(255);
}
int animation=0;
void draw(){
  if (contourI.size()>0){
    fill(255, 0, 255);
    stroke(255, 0, 255);
    int ii=contourI.get(animation), jj=contourJ.get(animation);
    ellipse(jj, ii, 3, 3);
    animation=(animation+1)%contourI.size();
  }
}
void mouseDragged(){ // use mouse to draw
  fill(0);
  ellipse(mouseX, mouseY, 10, 10);
}
void keyPressed(){
  if (key=='r'){ // read the image which you saved
    background(255); 
    PImage now = loadImage("image.png");
    image(now, 0, 0);
  }
  if (key=='s') saveFrame("image.png");
  if (key=='c') {
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
        visited[ii][jj]=true;
      }
    } 
    updatePixels();
    println("white:"+white+ " black:"+black);
    println("ArrayList<Integer>I no size is:" + I.size());
    while(I.size()>0){
      int ii=I.get(0), jj=J.get(0);
      I.remove(0);
      J.remove(0);
      testAndAdd(ii+1, jj);
      testAndAdd(ii-1, jj);
      testAndAdd(ii, jj+1);
      testAndAdd(ii, jj-1);
    }
    println("color 255 is:" + color(255));
    println("color 0 is:" + color(0));
    for (int i=0; i<ansI.size(); i++){
      int ii=ansI.get(i), jj=ansJ.get(i);
      stroke(0, 255, 0);
      ellipse(jj, ii, 3, 3); // point(jj, ii);
      contour[ii][jj]=true; // contour
    }
  }
  if (key=='d'){ // DFS
    ArrayList<Integer> stackI = new ArrayList<Integer>();
    ArrayList<Integer> stackJ = new ArrayList<Integer>();
    for (int i=0; i<512; i++){
      for (int j=0; j<512; j++){
        if (contour[i][j]==true){
          stackI.add(i);
          stackJ.add(j);
          contourI.add(i);
          contourJ.add(j);
          // exit the lood then do DFS
          while (stackI.size()>0){ // if stack still have point, then do
            print(".");
            int last = stackI.size()-1;
            int ii=stackI.get(last), jj=stackJ.get(last);
            stackI.remove(last);
            stackJ.remove(last);
            testAndAddStack(ii-1, jj-1, stackI, stackJ);
            testAndAddStack(ii-1, jj+0, stackI, stackJ);
            testAndAddStack(ii-1, jj+1, stackI, stackJ);
            testAndAddStack(ii, jj-1, stackI, stackJ);
            testAndAddStack(ii, jj+1, stackI, stackJ);
            testAndAddStack(ii+1, jj-1, stackI, stackJ);
            testAndAddStack(ii+1, jj+0, stackI, stackJ);
            testAndAddStack(ii+1, jj+1, stackI, stackJ);
          }
        }
      }
    }  
    print("contourI.size():"+contourI.size()); 
  }
}

ArrayList<Integer>contourI = new ArrayList<Integer>(); // stack for DFS
ArrayList<Integer>contourJ = new ArrayList<Integer>(); // stack for DFS
void testAndAdd(int i, int j){
  if (i<0 || j<0 || i>=512 || j >=512) return;
  if (visited[i][j]) return;
  if (pixels[i*512+j]!=-16777216){
    ansI.add(i);
    ansJ.add(j);
    visited[i][j]=true;
  }
}
void testAndAddStack(int i, int  j, ArrayList<Integer>stackI, ArrayList<Integer>stackJ){
  if (i<0 || j<0 || i>=512 | j>=512) return;
  if (stackI.size()>0 && i==stackI.get(0) && j==stackJ.get(0)){
    
  }
  if (contour[i][j]==true){
    contourI.add(i);
    contourJ.add(j);
    contour[i][j] = false;
    stackI.add(i);
    stackJ.add(j);
  }
}
