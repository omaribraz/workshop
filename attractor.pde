class attractor {
  Vec3D   pos;
  int     type;
  float   magnatude;
  float   attDisScale;
  float   range;
  WB_Coord posCopy; 
  WB_Coord meshPt; 

  attractor(Vec3D _pos, int _type) {
    pos = _pos;
    magnatude = 30;
    attDisScale = 0.5;  
    range = 2000;
    type = _type;
  }

  void meshmap() {
    posCopy = new WB_Point(pos.copy().x, pos.copy().y, pos.copy().z);
    meshPt = mesh.getClosestPoint(posCopy, vertexTree);
    float xPos = (Float)  meshPt.xf();
    float yPos = (Float)  meshPt.yf();
    float zPos = (Float)  meshPt.zf();
    Vec3D posNew = new Vec3D(xPos, yPos, zPos);
    pos = posNew;
  }

  void render() {
    stroke(150, 150, 0);
    strokeWeight(5);
    point(pos.x, pos.y, pos.z);
  }
}