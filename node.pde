class node extends attractor {
  int nodeval;
  int branchval;
  int taken = -1;
  int takenCntr = 0;

  node(Vec3D _pos, int _type) {
    super (_pos, _type);
    nodeval = 0;
    branchval =0;
    range = 2000;
  }

  void update() {
    render();
    if (taken!= -1) {
      takenCntr++;
    }
    Remove();
  }

  void Remove() {

    if ((nodeval>nodetp)&&(branchval>nodebt)) {
      //  nodePop.remove(this);
    }
    if(takenCntr>200){
      taken = -1;
      takenCntr =0;
    }
    
  }

  void render() {
   if(type ==3) stroke(255, 0, 0,80);
   if(type ==2) stroke(0, 255, 0,80);
   if(type ==4) stroke(0, 0, 255,80);
    strokeWeight(3);
    point(pos.x, pos.y, pos.z);
  }
}