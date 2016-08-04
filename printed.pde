class printed {
  Vec3D pos;
  Vec3D orientation;
  WB_Coord posCopy; 
  WB_Coord meshPt;
  boolean fallb = true;
  Vec3D vel = new Vec3D(0, 0, -15);

  printed(Vec3D p, Vec3D o) {
    pos = p.copy();
    orientation = o.copy();
    orientation = orientation.normalize();
  }

  void update() {
    if (fallb == true) fall();
    render();
  }

  void fall() {
    posCopy = new WB_Point(pos.copy().x, pos.copy().y, pos.copy().z);
    meshPt = mesh.getClosestPoint(posCopy, vertexTree);
    float xPos = (Float)  meshPt.xf();
    float yPos = (Float)  meshPt.yf();
    float zPos = (Float)  meshPt.zf();
    Vec3D posNew = new Vec3D(xPos, yPos, zPos);
    float mdist = pos.distanceTo(posNew);
    if ((mdist<10)) {
      fallb = false;
    }
    if (mdist>10) {
      pos.addSelf(vel);
    }
    if (pos.z<1) {
      fallb = false;
    }
  }


  void render() {
    stroke(255, 0, 0);
    strokeWeight(6);
    point(pos.x, pos.y, pos.z);
  }
}