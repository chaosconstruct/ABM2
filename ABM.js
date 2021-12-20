const canvas = document.getElementById('canvas');
const ctx = canvas.getContext("2d");
canvas.width = window.innerWidth;
canvas.height = window.innerHeight;
let ParticleP = [];

// create particles

class Particle{
      constructor(x,y,vx,vy,ax,ay){
      this.x = x;
      this.y = y;
      this.vx = vx;
      this.vy = vy;
      this.ax = ax;
      this.ay = ay;

    }
    draw(){
      ctx.beginPath();
      ctx.arc(this.x,this.y,15,0,Math.PI*2,false);
      
      ctx.fill();
    }
    update(){
         this.vx += this.ax;
         this.vy += this.ay;
         this.x += this.vx;
         this.y += this.vy;
         this.ax = 0;
         this.ay = 0;
    }

    applyforce(dx,dy){
        this.ax += dx;
        this.ay += dy;
    }
  
    borders(){
    if (this.x < -0) this.x = canvas.width;
    if (this.y < -0) this.y = canvas.height;
    if (this.x > canvas.width) this.x = 0;
    if (this.y > canvas.height) this.y = 0;
    }
}


function init(){
    ParticleP = [];
    for(let i = 0 ; i < 100 ; i++){
      let x = canvas.width/2;
      let y = canvas.height/2;
      let vx = 0;
      let vy = 0;
      let ax = 0;
      let ay = 0;
      ParticleP.push(new Particle(x,y,vx,vy,ax,ay));
    }
}

function getRandomIntInclusive(min, max) {
  min = min;
  max = max;
  return Math.floor(Math.random() * (max - min+1) + min); //The maximum is inclusive and the minimum is inclusive
}

function animate(){
      ctx.clearRect(0,0,canvas.width,canvas.height);
      for(let i = 0 ; i < 100 ; i++){
      ParticleP[i].applyforce(getRandomIntInclusive(-1, 1)*0.1,getRandomIntInclusive(-1, 1)*0.1);
      ParticleP[i].update();
      ParticleP[i].borders();
      ParticleP[i].draw();
      
      }

      requestAnimationFrame(animate);
}

init();
animate();




