class Boid {
  Vec3D pos;
  Vec3D vel;
  Vec3D acc;
  float r;
  float maxforce;   
  float maxspeed;  

  Boid(float x, float y, float z) {
    acc = new Vec3D(0, 0, 0);
    vel = new Vec3D(random(TWO_PI), random(TWO_PI), random(TWO_PI));
    pos = new Vec3D(x, y, z);
    r = 7.0;
    maxspeed = 10;
    maxforce = 0.07;
  }

  void run(ArrayList<Boid> boids) {
    flock(boids);
    if (frameCount%1==0) trail();
    if (frameCount%3==0) Print();
    update();
    borders();
    render();
  }

  void applyForce(Vec3D force) {
    acc.addSelf(force);
  }


  void flock(ArrayList<Boid> boids) {
    //Vec3D sep = separate(boids);   
    //Vec3D ali = align(boids);      
    //Vec3D coh = cohesion(boids);
    Vec3D wan = wander();
    //Vec3D stig = seektrail(flock.trailPop);

    //sep.scaleSelf(3.0);
    //ali.scaleSelf(0.6);
    // coh.scaleSelf(0.1);
    //stig.scaleSelf(0.5);
    wan.scaleSelf(9.0);



    //applyForce(sep);
    //applyForce(ali);
    //applyForce(coh);
    //applyForce(stig);
    applyForce(wan);
  }


  void update() {

    vel.addSelf(acc);
    vel.limit(maxspeed);
    pos.addSelf(vel);
    acc.scaleSelf(0);
  }

  Vec3D seek(Vec3D target) {
    Vec3D desired = target.subSelf(pos);  
    desired.normalize();
    desired.scaleSelf(maxspeed);
    Vec3D steer = desired.subSelf(vel);
    steer.limit(maxforce);  
    return steer;
  }

  void trail() {
    trail tr = new trail(pos.copy(), vel.copy());
    flock.addTrail(tr);
  }
  
   void Print() {
    printed tr = new printed(pos.copy(), vel.copy());
    flock.addPrint(tr);
  }

  void render() {
    float theta = vel.headingXY() + radians(90);

    stroke(255);
    pushMatrix();
    translate(pos.x, pos.y, pos.z);
    rotate(theta);
    lights();
    obj.setFill(color(250, 250, 250));
    obj.setStroke(100);
    obj.scale(1);
    shape(obj);
    popMatrix();
  }

  // Separation
  Vec3D separate (ArrayList<Boid> boids) {
    float desiredseparation = 45.0f*45.0f;
    Vec3D steer = new Vec3D(0, 0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = pos.distanceToSquared(other.pos);
      if ((d > 0) && (d < desiredseparation)) {
        Vec3D diff = pos.sub(other.pos);
        diff.normalize();
        diff.scaleSelf(1/d);    
        steer.add(diff);
        count++;
      }
    }
    if (count > 0) {
      steer.scaleSelf(1/(float)count);
    }
    if (steer.magnitude() > 0) {
      steer.normalize();
      steer.scaleSelf(maxspeed);
      steer.subSelf(vel);
      steer.limit(maxforce);
    }
    return steer;
  }

  // Alignment
  Vec3D align (ArrayList<Boid> boids) {
    float neighbordist = 70.0f*70.0f;
    Vec3D sum = new Vec3D(0, 0, 0);
    int count = 0;
    for (Boid other : boids) {
      float d = pos.distanceToSquared(other.pos);
      if ((d > 0) && (d < neighbordist)) {
        sum.addSelf(other.vel);
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1/(float)count);
      sum.normalize();
      sum.scaleSelf(maxspeed);
      Vec3D steer = sum.subSelf(vel);
      steer.limit(maxforce);
      return steer;
    } else {
      return new Vec3D(0, 0, 0);
    }
  }


  // Cohesion
  Vec3D cohesion (ArrayList<Boid> boids) {
    float neighbordist = 80.0f*80.0f;
    Vec3D sum = new Vec3D(0, 0, 0);   
    int count = 0;
    for (Boid other : boids) {
      float d = pos.distanceToSquared(other.pos);
      if ((d > 0) && (d < neighbordist)) {
        sum.addSelf(other.pos); 
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1/(float)count);
      return seek(sum);
    } else {
      return new Vec3D(0, 0, 0);
    }
  }

  Vec3D seektrail(ArrayList tPop) {
    float neighbordist = 90;
    Vec3D sum = new Vec3D(0, 0, 0);  
    int count = 0;

    for (int i = 0; i < tPop.size(); i++) {
      trail t = (trail) tPop.get(i); 
      float distance = pos.distanceTo(t.pos);
      if ((distance < neighbordist)&&(inView(t.pos, 60))) {
        sum.addSelf(t.pos); 
        count++;
      }
    }
    if (count > 0) {
      sum.scaleSelf(1/(float)count);
      return seek(sum);
    }    
    return sum;
  }


  Vec3D wander() {
    float wanderR = 70;      
    float wanderD = 60;       
    float change = 60.25;
    float wandertheta = 0;
    wandertheta += random(-change, change);    
    Vec3D circleloc = vel.copy();
    circleloc.normalize();
    circleloc.scaleSelf(wanderD);  
    circleloc.addSelf(pos);   
    Vec3D circleOffSet = new Vec3D(wanderR*cos(wandertheta), wanderR*sin(wandertheta), 0);
    circleOffSet.addSelf(circleloc);
    return seek(circleOffSet);
  }

  boolean inView(Vec3D target, float angle) {
    boolean resultBool; 
    Vec3D vec = target.copy().subSelf(pos.copy());
    float result = vel.copy().angleBetween(vec);
    result = degrees(result);
    if (result < angle) {
      resultBool = true;
    } else { 
      resultBool = false;
    }
    return resultBool;
  }

  // Wraparound
  void borders() {
    if (pos.x < 0) vel.scaleSelf(-1);
    if (pos.y < 0) vel.scaleSelf(-1);
    if (pos.x > 4000) vel.scaleSelf(-1);
    if (pos.y > 4000) vel.scaleSelf(-1);
    if (pos.z >2000) vel.scaleSelf(-1);

    if (pos.x < 0) pos.x = 0;
    if (pos.y < 0) pos.y = 0;
    if (pos.x > 4000) pos.x = 4000;
    if (pos.y > 4000) pos.y = 4000;
    if (pos.z < zmaxint+40) {
      WB_Point tpos = new WB_Point(pos.copy().x, pos.copy().y, pos.copy().z);
      WB_Coord ptonmesh = mesh.getClosestPoint(tpos, vertexTree);
      if (pos.z < ptonmesh.zf()+40) {
        vel.scaleSelf(-1);
      }
      if (pos.z < ptonmesh.zf()+40) pos.z = ptonmesh.zf()+40;
    }
    if (pos.z > 2000) pos.z = 2000;
  }
}