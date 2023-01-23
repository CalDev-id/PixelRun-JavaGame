// deklarasi variable untuk time
int milisecs;
int seconds;
int minutes;
int startTime;
int endTime;
int elapsedTime;
boolean runOnce = true;
boolean startTimer = true;

// deklarasi variable untuk gambar atau graphics
PImage[] characterRun;
PImage[] characterRunAttack;
PImage[] characterHurt;
PImage[] enemyRun1;
PImage[] enemyRun2;
PImage[] enemyRun3;
PImage[] boulder;
PImage[] mainMenuBackground;
PImage howtoplayimage;
PImage background;
PImage heal;
PImage objective1;
PImage objective2;
PImage objective3;
PImage control;

// deklarasi variable untuk menenentukan panjang frame dan variable untuk menghitung frame ke-berapa yang sedang ditampilkan
int characterRunLength = 8;
int characterRunAttackLength = 8;
int characterHurtLength = 4;
int enemyRun1Length = 6;
int enemyRun2Length = 6;
int enemyRun3Length = 5;
int boulderLength = 8;
int mainMenuBackgroundLength = 8;
int animationCounterRun = 0;
int animationCounterRunAttack = 0;
int animationCounterHurt = 0;
int enemyanimationCounterRun1 = 0;
int enemyanimationCounterRun2 = 0;
int enemyanimationCounterRun3 = 0;
int boulderCounter = 0;
int mainMenuBackgroundCounter = 0;

// deklarasi variable untuk score, randomizer kemunculan musuh, waktu interval antar heal, healthPoints, counter musuh, menentukan animasi yang ditampilkan ketika game pertama kali dijalankan, dan font
int score = 0;
int random = 1;
int healInterval = 30;
int lastHeal;
int healthPoints = 100;
int fullhealthPoints = 100;
int enemy1Counter;
int enemy2Counter;
int enemy3Counter;
String AnimState = "run";
PFont font;

// deklarasi variable untuk kecepatan gerak background, posisi karakter, musuh, boulder, dan heal, variable yang memunculkan musuh, variable alive, dan variable win
int groundOffset = 0;
int scrollSpeed = 0;
float playerPosition = height/1.45;
int playerHeight = 400;
int enemyPosition = 1280;
float enemyHeight;
int randomEnemyHeight;
boolean enemyVisible = false;
int boulderPosition = 1280;
int randomBoulderHeight;
boolean boulderVisible = false;
int healPosition = 1280;
int randomHealHeight;
boolean healVisible = false;
boolean alive = false;
boolean win = false;

// deklarasi variable how to play
int page = 0;
boolean howtoPlay = false;
String howtoplaytext1;
String howtoplaytext2;

// deklarasi variable untuk controls
int view = 5; // view 5 = tampilan controls
boolean controls = true;

// deklarasi variable untuk menu
int currentSelection = 0;
boolean mainMenu = false;
String[] menu = {"Play Game", "How To Play", "Credit", "Quit"};
String[] gameOverWin = {"Play Again", "Main Menu"};

// deklarasi variable untuk credits
int creditY = 0;
int creditSpeed = 5;
boolean credits = false;

// deklarasi variable untuk sound dan music
import processing.sound.*;
SoundFile slash, healing, boulderHit, bgmGame, bgmMenu, menuSelect, gameOver, gameCompleted, objectiveCompleted;

// void atau procedure untuk mendeklarasikan resolusi, framerate, font, sound, music, dan gambar
void setup() {
  size(1280, 720);
  frameRate(15);
  font = createFont ("/Assets/Font/Font.ttf", 25 );
  slash = new SoundFile(this, "/Assets/Sound/swordSlash.wav");
  healing = new SoundFile(this, "/Assets/Sound/Heart.wav");
  boulderHit = new SoundFile(this, "/Assets/Sound/boulderHit.wav");
  bgmGame = new SoundFile(this, "/Assets/Music/bgmGame.wav");
  bgmMenu = new SoundFile (this, "/Assets/Music/bgmMenu.wav");
  menuSelect = new SoundFile(this, "/Assets/Sound/menuSelect.wav");
  gameOver = new SoundFile(this, "/Assets/Sound/gameOver.wav");
  gameCompleted = new SoundFile(this, "/Assets/Sound/gameCompleted.wav");
  objectiveCompleted = new SoundFile(this, "/Assets/Sound/objectiveCompleted.wav");
  background = loadImage("/Assets/gameBackground/gameBackground.png");
  heal = loadImage("/Assets/Heart/Heart.png");
  objective1 = loadImage("/Assets/Objective/Objective1.png");
  objective2 = loadImage("/Assets/Objective/Objective2.png");
  objective3 = loadImage("/Assets/Objective/Objective3.png");
  control = loadImage("/Assets/Control/Control.png");
  startTime = millis();
  lastHeal = millis();
  
  // melakukan load frame karakter run
  characterRun = new PImage[characterRunLength];
  for (int i = 0; i < characterRunLength; i++) {
    characterRun[i] = loadImage("/Assets/Knight/Run/Run" + i + ".png");
  }
  
  // melakukan load frame karakter runattack
  characterRunAttack = new PImage[characterRunAttackLength];
  for (int i = 0; i < characterRunAttackLength; i++) {
    characterRunAttack[i] = loadImage("/Assets/Knight/runAttack/runAttack" + i + ".png");
  }
  
  // melakukan load frame karakter hurt
  characterHurt = new PImage[characterHurtLength];
  for (int i = 0; i < characterHurtLength; i++) {
    characterHurt[i] = loadImage("/Assets/Knight/Hurt/Hurt" + i + ".png");  
  }
  
  // melakukan load frame musuh ke-1 run
  enemyRun1 = new PImage[enemyRun1Length];
  for (int i = 0; i < enemyRun1Length; i++) {
    enemyRun1[i] = loadImage("/Assets/Demon/Walk" + i + ".png");
  }
  
  // melakukan load frame musuh ke-2 run
  enemyRun2 = new PImage[enemyRun2Length];
  for (int i = 0; i < enemyRun2Length; i++) {
    enemyRun2[i] = loadImage("/Assets/Lizard/Walk" + i + ".png");
  }
  
  // melakukan load frame musuh ke-3 run
  enemyRun3 = new PImage[enemyRun3Length];
  for (int i = 0; i < enemyRun3Length; i++) {
    enemyRun3[i] = loadImage("/Assets/Dragon/Walk" + i + ".png"); 
  }
  
  // melakukan load frame boulder
  boulder = new PImage[boulderLength];
  for (int i = 0; i < boulderLength; i++) {
    boulder[i] = loadImage("/Assets/Boulder/Boulder" + i + ".png"); 
  }
  
  // melakukan load frame main menu background
  mainMenuBackground = new PImage[mainMenuBackgroundLength];
  for (int i = 0; i < mainMenuBackgroundLength; i++) {
    mainMenuBackground[i] = loadImage("/Assets/mainMenu/mainMenu" + i + ".png");
  }
}

// void atau procedure untuk menampilkan tampilan controls pada saat memulai game
void controls() {
  background(0);
  fill(255, 255, 0);
  textFont(font, 80);
  textAlign(CENTER);
  text("-- CONTROLS --", width/2, 110);
  imageMode(CENTER);
  image(control, width/2, 305);
  fill(255);
  textFont(font, 40);
  text("NAVIGATE MENU USING YOUR ARROW KEYS", width/2, 480);
  fill(255, 255, 0);
  textFont(font, 55);
  text("-- PRESS ENTER TO CONTINUE --", width/2, 630);
}

// void atau procedure untuk menampilkan tampilan main menu
void mainMenu() {
  frameRate(15);
  imageMode(CORNER);
  image(mainMenuBackground[mainMenuBackgroundCounter], 0, 0);
  mainMenuBackgroundCounter++;
  if (mainMenuBackgroundCounter == mainMenuBackgroundLength) {
    mainMenuBackgroundCounter = 0;
  }
  alive = false;
  win = false;
  howtoPlay = false;
  credits = false;
  view = 0;
  textFont(font, 80);
  fill(209, 186, 52);
  rectMode(CENTER);
  rect(width/2, 190, 535, 185, 10);
  fill(148, 104, 24);
  rect(width/2, 190, 500, 150, 5);
  fill(250, 239, 217);
  textAlign(CENTER);
  text("PIXELRUN", width/2, 210);
  textFont(font, 50);
  fill(255);
  for (int i = 0; i < menu.length; i++) {
    if (i == currentSelection) {
      fill(255, 255, 0);
    }
    textAlign(CENTER);
    text(menu[i], width/2, 360 + i * 70);
    fill(255);
  }  
}

// void atau procedure untuk menampilkan tampilan how to play
void howtoPlay() {
  alive = false;
  win = false;
  mainMenu = false;
  frameRate(60);
  background(0);
  if (page == 0) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay0.png");
    howtoplaytext1 = "\"NAVIGATE YOUR CHARACTER USING";
    howtoplaytext2 = " UP AND DOWN ARROW KEYS\"";
  } else if (page == 1) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay1.png");
    howtoplaytext1 = "\"THIS ENEMY IS CALLED \"DEMON\"";
    howtoplaytext2 = "IT WILL REDUCE YOUR HEALTH POINTS BY 5\""; 
  } else if (page == 2) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay2.png");
    howtoplaytext1 = "\"THIS ENEMY IS CALLED \"LIZARD\"";
    howtoplaytext2 = "IT WILL REDUCE YOUR HEALTH POINTS BY 15\"";
  } else if (page == 3) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay3.png");
    howtoplaytext1 = "\"THIS ENEMY IS CALLED \"DRAGON\"";
    howtoplaytext2 = "IT WILL REDUCE YOUR HEALTH POINTS BY 30\"";
  } else if (page == 4) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay4.png");
    howtoplaytext1 = "\"AVOID THE BOULDER BECAUSE IF IT HIT YOU,";
    howtoplaytext2 = "IT WILL REDUCE YOUR HEALTH POINTS BY 50\"";
  } else if (page == 5) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay5.png");
    howtoplaytext1 = "\"AIM FOR THE HEART BECAUSE IT WILL";
    howtoplaytext2 = "INCREASE YOUR HEALTH POINTS BY 25\""; 
  } else if (page == 6) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay6.png");
    howtoplaytext1 = "\"THE GAME WILL BE OVER IF YOUR";
    howtoplaytext2 = "HEALTH POINTS IS / BELOW 0\"";
  } else if (page == 7) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay7.png");
    howtoplaytext1 = "\"TO WIN THE GAME YOU MUST COMPLETE THE";
    howtoplaytext2 = "OBJECTIVE ON THE TOP RIGHT OF THE SCREEN\""; 
  } else if (page == 8) {
    howtoplayimage = loadImage("/Assets/howtoPlay/howtoPlay8.png");
    howtoplaytext1 = "\"YOU WILL GET YOUR SCORE BASED ON THE";
    howtoplaytext2 = "ELAPSED TIME AND REMAINING HEALTH POINTS\""; 
  }
  if (page < 0) {
    page = 0;  
  } else if (page > 9) {
    page = 9; 
  }
  view = 6; // view 6 = tampilan how to play
  imageMode(CENTER);
  image(howtoplayimage, width/2, 280);
  fill(255, 255, 0);
  textFont(font, 65);
  textAlign(CENTER);
  text("-- HOW TO PLAY --", width/2, 80);
  fill(255);
  textFont(font, 40);
  text(howtoplaytext1, width/2, 470);
  text(howtoplaytext2, width/2, 510);
  text("PRESS <- TO GO BACK | PRESS -> TO GO FORWARD", width/2, 605);
  fill(255, 255, 0);
  textFont(font, 55);
  text("-- PRESS ESC TO EXIT --", width/2, 675);
}

// void atau procedure untuk menampilkan tampilan credits
void credits() {
  alive = false;
  win = false;
  mainMenu = false;
  frameRate(60);
  background(0);
  fill(255, 255, 0);
  textFont(font, 80);
  textAlign(CENTER);
  text("-- CREDITS --", width/2, creditY+110);
  fill(255);
  textFont(font, 55);
  text("* PROGRAMMERS *", width/2, creditY+200);
  textFont(font, 35);
  text("SANDHI KARUNIA SUGIHARTANA", width/2, creditY+240);
  text("CUT AZIMAH NOOR HANIFAH", width/2, creditY+280);
  text("HEICAL CHANDRA SYAHPUTRA", width/2, creditY+320);
  text("MUHAMMAD HAIKAL AL RASYID", width/2, creditY+360);
  textFont(font, 55);
  text("* GRAPHICS *", width/2, creditY+440);
  textFont(font, 35);
  text("MAIN MENU BACKGROUND - https://www.tenor.com/", width/2, creditY+480);
  text("GAME BACKGROUND - https://www.craftpix.net/", width/2, creditY+520);
  text("ENEMY - https://www.craftpix.net/", width/2, creditY+560);
  text("CHARACTER - https://www.craftpix.net/", width/2, creditY+600);
  text("BOULDER - https://www.gamedeveloperstudio.com/", width/2, creditY+640);
  text("HEART - https://www.vecteezy.com/", width/2, creditY+680);
  textFont(font, 55);
  text("* SOUND *", width/2, creditY+760);
  textFont(font, 35);
  text("MENU SELECTION - https://www.motionarray.com/", width/2, creditY+800);
  text("SWORD SLASH - By mani creation", width/2, creditY+840);
  text("BOULDER HIT - By Ctske", width/2, creditY+880);
  text("OBTAIN HEART - https://www.creativecommons.org/", width/2, creditY+920);
  text("OBJECTIVE COMPLETE - https://www.creatorassets.com/", width/2, creditY+960);
  text("GAME OVER - https://www.mixkit.co/", width/2, creditY+1000);
  text("VICTORY -  https://www.mixkit.co/", width/2, creditY+1040);
  textFont(font, 55);
  text("* MUSIC *", width/2, creditY+1120);
  textFont(font, 35);
  text("MAIN MENU MUSIC - \"8 Bit Adventure\" By HeatleyBros", width/2, creditY+1160);
  text("GAME MUSIC - By Marllon Silva (xDeviruchi)", width/2, creditY+1200);
  fill(255, 255, 0);
  textFont(font, 55);
  text("-- PRESS ESC TO EXIT -- ", width/2, creditY+1290);
}

// void atau procedure untuk memunculkan musuh
void enemy() {
  
  // penggunaan if dimana apabila posisi musuh berada tepat di depan karakter, maka akan menjalankan animasi "runAttack" dan menjalankan sound "slash"
  if (enemyPosition == 260 && playerHeight == enemyHeight) {
     AnimState = "runattack";
     slash.amp(0.3);
     slash.play();
  }
  
  // penggunaan if dimana apabila posisi musuh berada di ujung kiri layar, maka akan memunculkan kembali musuh dari arah kanan
  if (enemyPosition < 0) {
    enemyVisible = false;
    enemyPosition = 1280;
  }
  
  // penggunaan if dimana apabila posisi boulder berada tepat di depan karakter, maka akan menjalankan animasi "hurt", mengurangi health points sebesar 50, memunculkan kembali boulder dari arah kanan, dan menjalankan sound "boulderHit"
  if (boulderPosition == 220 && playerHeight == randomBoulderHeight) {
    AnimState = "hurt";
    healthPoints -= 50;
    boulderVisible = false;
    boulderPosition = 1310;
    boulderHit.play();
    boulderHit.amp(0.2);
  }
  
  // penggunaan if dimana apabila posisi boulder berada di ujung kiri layar, maka akan memunculkan kembali boulder dari arah kanan
  if (boulderPosition < 0) {
    boulderVisible = false;
    boulderPosition = 1280;
  }
  
  // penggunaan if dimana apabila posisi boulder sama dengan 1280, maka akan menjalankan animasi "run"
  if (boulderPosition == 1280) {
    AnimState = "run";
  }
  
  // penggunaan if dimana apabila posisi heal berada di ujung kiri layar, maka akan memunculkan kembali heal dari arah kanan
  if (healPosition < 0) {
    healVisible = false;
    healPosition = 1280;
  }
  
  // penggunaan if dimana apabila posisi heal berada di depan karakter, maka akan menambah health points sebesar 25, memunculkan kembali heal dari arah kanan, dan menjalankan sound "healing"
  if (healPosition == 220 && playerHeight == randomHealHeight) {
    healthPoints += 25;
    healVisible = false;
    healPosition = 1280;
    healing.play();
    healing.amp(0.3);
  }
  
  // penggunaan if dimana apabila posisi musuh berada tepat di depan karakter, maka musuh akan menghilang kemudian memunculkan kembali musuh dari arah kanan dan berkurangnya healthPoints sesuai yang sudah ditentukan
  if (enemyPosition == 220 && playerHeight == enemyHeight) {
    
    // penggunaan if dimana apabila musuh ke-1 yang muncul, maka healthPoints akan berkurang 5
    if (random == 1) {
      enemy1Counter++;
      healthPoints -= 5;
      enemyVisible = false;
      AnimState = "run";
      enemyPosition = 1280;
    }
    
    // penggunaan if dimana apabila musuh ke-1 yang muncul dan sudah membunuh musuh ke-1 tersebut sebanyak lebih dari 4 kali, maka akan menjalankan sound "objectiveCompleted"
    if (random == 1 && enemy1Counter > 4) {
      objectiveCompleted.play();
      objectiveCompleted.amp(0.3);
    }
    
    // penggunaan if dimana apabila musuh ke-2 yang muncul, maka healthPoints akan berkurang 10
    if (random == 2) {
      enemy2Counter++;
      healthPoints -= 10;
      enemyVisible = false;
      AnimState = "run";
      enemyPosition = 1280;
    }
    
    // penggunaan if dimana apabila musuh ke-2 yang muncul dan sudah membunuh musuh ke-2 tersebut sebanyak lebih dari 2 kali, maka akan menjalankan sound "objectiveCompleted"
    if (random == 2 && enemy2Counter > 2) {
      objectiveCompleted.play();
      objectiveCompleted.amp(0.3);  
    }
    
    // penggunaan if dimana apabila musuh ke-3 yang muncul, maka healthPoints akan berkurang 30
    if (random == 3) {
      enemy3Counter++;
      healthPoints -= 30;
      enemyVisible = false;
      AnimState = "run";
      enemyPosition = 1280;
    }
    
    // penggunaan if dimana apabila musuh ke-3 yang muncul dan sudah membunuh musuh ke-3 tersebut sebanyak lebih dari 1 kali, maka akan menjalankan sound "objectiveCompleted"
    if (random == 3 && enemy3Counter > 1) {
      objectiveCompleted.play();
      objectiveCompleted.amp(0.3);  
    }
  }

  // penggunaan if dimana apabila healthPoints bernilai kurang dari 1, maka variable alive akan bernilai false, menjalankan sound "gameOver", dan game akan selesai dengan status kalah / game over
  if(healthPoints < 1) {
    alive = false;
    gameOver.play();
    gameOver.amp(0.1);
  }
  
  // penggunaan if dimana apabila sudah membunuh musuh ke-1 sebanyak lebih dari 4 kali, musuh ke-2 sebanyak lebih dari 2 kali, musuh ke-3 sebanyak lebih dari 3 kali, maka variable win akan bernilai true, menjalanlan sound "gameCompleted", dam game akan selesai dengan status menang
  if (enemy1Counter > 4 && enemy2Counter > 2 && enemy3Counter > 1) {
    win = true;
    gameCompleted.play();
    gameCompleted.amp(0.1);
  }
  
  // penggunaan if ketika musuh muncul
  if (enemyVisible) {
    
    // penggunaan if untuk menentukan jeda munculnya musuh
    if (enemyPosition <= -20) {
      enemyVisible = true;
      enemyPosition = 1280;
    }
    
    // penggunana if sebagai randomizer kemunculan antara musuh ke-1, ke-2, dan ke-3
    if (random == 1) {
      pushMatrix();
      scale(-1.0, 1.0);
      imageMode(CENTER);
      enemyHeight = randomEnemyHeight;
      image(enemyRun1[enemyanimationCounterRun1], -enemyPosition/1, enemyHeight/0.98);
      enemyanimationCounterRun1++;
      enemyPosition -= 10;
      if (enemyanimationCounterRun1 == enemyRun1Length) {
        enemyanimationCounterRun1 = 0;
      }
      popMatrix();
    } else if (random == 2) {
      pushMatrix();
      scale(-1.0, 1.0);
      imageMode(CENTER);
      enemyHeight = randomEnemyHeight;
      image(enemyRun2[enemyanimationCounterRun2], -enemyPosition/1, enemyHeight/0.93);
      enemyanimationCounterRun2++;
      enemyPosition -= 10;
      if (enemyanimationCounterRun2 == enemyRun2Length) {
        enemyanimationCounterRun2 = 0;
      }
      popMatrix();
    } else if (random == 3) {
      pushMatrix();
      scale(-1.0, 1.0);
      imageMode(CENTER);
      enemyHeight = randomEnemyHeight;
      image(enemyRun3[enemyanimationCounterRun3], -enemyPosition/0.8, enemyHeight/1.24);
      enemyanimationCounterRun3++;
      enemyPosition -= 10;
      if (enemyanimationCounterRun3 == enemyRun3Length) {
        enemyanimationCounterRun3 = 0;
      }
      popMatrix();
    }
  }
  
  // penggunaan if dimana apabila kemunculan musuh bernilai false atau tidak ada musuh, maka akan menjalankan kembali randomizer dan memunculkan musuh
  if (!enemyVisible) {
    if (random(0f, 1.0f) < 0.04f) {
      random = int(random(1, 4)); // menentukan nilai dari variable random dengan menggunakan fungsi random dari 1 sampai 4
      randomEnemyHeight = round(random(250, 500) / 50) * 50;
      enemyVisible = true; // memunculkan musuh kembali
    }
  }

  // penggunaan if ketika boulder muncul
  if (boulderVisible) {
    
    // penggunaan if untuk menentukan jeda munculnya musuh
    if (boulderPosition <= -20) {
      boulderVisible = true;
      boulderPosition = 1280;
    }
    pushMatrix();
    scale(-1.0, 1.0);
    imageMode(CENTER);
    image(boulder[boulderCounter], -boulderPosition/1, randomBoulderHeight+10);
    boulderCounter++;
    boulderPosition -= 10;
    if (boulderCounter == boulderLength) {
      boulderCounter = 0;  
    }
    popMatrix();
  }
  
  // penggunaan if dimana apabila kemunculan boulder bernilai false atau tidak ada boulder, maka akan memunculkan kembali boulder
  if (!boulderVisible) {
    if (random(0f, 0.04f) < 0.04f) {
      randomBoulderHeight = round(random(250, 500) / 50) * 50;
      boulderVisible = true;
    }
  }
  
  // penggunaan if ketika heal muncul
  if (healVisible) {
    
    // penggunaan if untuk menentukan jeda munculnya heal selain menggunakan waktu interval
    if (healPosition <= -20) {
      healVisible = true;
      healPosition = 1280;
    }
    pushMatrix();
    imageMode(CENTER);
    image(heal, healPosition/1, randomHealHeight+30);
    healPosition -= 10;
    popMatrix();
  }
  
  // penggunaan if dimana apabila kemunculan heal bernilai false atau tidak ada heal, maka akan memunculkan kembali heal setelah 30 detik dari kemunculan heal terakhir
  if (!healVisible) {
    if (millis() - lastHeal > healInterval * 1000) {
      randomHealHeight = round(random(250, 500) / 50) * 50;
      healVisible = true;
      lastHeal = millis();
    }
  }
}

// void atau procedure dalam menampilkan background yang berjalan
void ground() {
  groundOffset += scrollSpeed;
  if (groundOffset >= 1280) groundOffset = 0;
  
  if (enemy1Counter > 5) {
    enemy1Counter = 5;
  }
  if (enemy2Counter > 3) {
    enemy2Counter = 3;  
  }
  if (enemy3Counter > 2) {
    enemy3Counter = 2;  
  }
  if (healthPoints > 100) {
    healthPoints = 100;  
  }

  // penggunaan for loop untuk menampilkan background sebanyak 10 kali
  for (int i = 0; i < 10; i++)
  {
    textFont(font, 30);
    image(background, 1280 * i - groundOffset, height/2);
    fill(209, 186, 52);
    rectMode(CENTER);
    rect(width/2, 20, 158, 185, 10);
    fill(148, 104, 24);
    rect(width/2, 20, 140, 170, 5);
    fill(250, 239, 217);
    textAlign(CENTER);
    text("Time", width/2, 39);
    text(nf(minutes, 2) + ":" + nf(seconds, 2) + "." + nf(milisecs, 1), width/2, 78);
    fill(209, 186, 52);
    rect(width/2+362, 20, 298, 185, 10);
    fill(148, 104, 24);
    rect(width/2+362, 20, 280, 170, 5);
    fill(250, 239, 217);
    image(objective1, width/1.385, 32);
    if (enemy1Counter > 4) {
      fill(0, 255, 0);
      text(enemy1Counter + "/5", width/1.4025, 85);
    } else {
      fill(250, 239, 217);
      text(enemy1Counter + "/5", width/1.4025, 85);
    }
    image(objective2, width/1.27, 33);
    if (enemy2Counter > 2) {
      fill(0, 255, 0);
      text(enemy2Counter + "/3", width/1.275, 85);
    } else {
      fill(250, 239, 217);
      text(enemy2Counter + "/3", width/1.275, 85);
    }
    image(objective3, width/1.175, 22);
    if (enemy3Counter > 1) {
      fill(0, 255, 0);
      text(enemy3Counter + "/2", width/1.170, 85);
    } else {
      fill(250, 239, 217);
      text(enemy3Counter + "/2", width/1.170, 85);
    }
    fill(209, 186, 52);
    rect(width/2-362, 20, 298, 185, 10);
    fill(148, 104, 24);
    rect(width/2-362, 20, 280, 170, 5);
    fill(250, 239, 217);
    text("Health Points", width/2-372.5, 34);
    fill(0);
    rectMode(CORNER);
    rect(width/2-483, 53, fullhealthPoints*2.40, 32, 5);
    fill(255, 0, 0);
    rect(width/2-483, 53, healthPoints*2.40, 32, 5);
    fill(255);
    text(healthPoints + "/" + fullhealthPoints, width/2-420.75, 77);
  }
}

// void atau procedure dalam menampilkan tampilan ketika play game
void draw() { 
  textFont(font, 30); // merubah font menjadi variable "font" yang sebelumnya telah dideklarasikan dan merubah ukuran font menjadi 30

  // penggunaan if untuk perhitungan Time
  if (startTimer) {
    if (int(millis()/100) % 10 != milisecs) {
      milisecs++;
    }
    if (milisecs >= 10) {
      milisecs -= 10;
      seconds++;
    }
    if (seconds >= 60) {
      seconds -= 60;
      minutes++;
    }
  }

  // penggunaan if dimana apabila variable controls bernilai true, maka akan memanggil void controls()
  if (controls) {
    controls();  
  }
  
  // penggunaan if dimana apabila variable alive bernilai false dan variable main menu bernilai true, maka akan memanggil void mainMenu()
  if (!alive && mainMenu) {
    mainMenu();  
  }
  
  // penggunaan if dimana apabila variable mainMenu bernilai false dan variable howtoPlay bernilai true, maka akan memanggil void howtoPlay()
  if (!mainMenu && howtoPlay) {
    howtoPlay();  
  }
  
  // penggunaan if dimana apabila variable mainMenu bernilai false dan variable credits bernilai true, maka akan memanggil void credits()
  if (!mainMenu && credits) {
    credits();  
  }
  
  // penggunaan if dimana apabila variable win bernilai true, maka variable alive bernilai false dan akan menampilkan tampilan menang, dan melakukan perhitungan score melalui waktu yang berlalu dan juga sisa dari health points
  if (win) {
    endTime = millis();
    elapsedTime = endTime - startTime;
    if (runOnce) {
      score = (healthPoints * 100 + (fullhealthPoints - elapsedTime / 1000));
      runOnce = false;
    }
    textFont(font, 50);
    background(0);
    view = 3; // view 3 = tampilan menang
    bgmGame.stop();
    alive = false;
    fill(255);
    textAlign(CENTER);
    fill(0, 255, 0);
    text("-- CONGRATULATION ON WINNING --", width/2, 250);
    fill(255);
    text("YOUR SCORE: " + score, width/2, 320);
    for (int i = 0; i < gameOverWin.length; i++) {
      if (i == currentSelection) {
        fill(255, 255, 0);
      }
      text(gameOverWin[i], width/2, 390 + i * 70);
      fill(255);
    } 
  }

  // penggunaan if dimana apabila variable alive bernilai false dan variable healthPoints bernilai kurang dari 1, maka akan menampilkan tampilan kalah
  if (!alive && healthPoints < 1) {
    textFont(font, 50);
    background(0);
    view = 2; // view 2 = tampilan kalah / game over
    bgmGame.stop();
    fill(255);
    textAlign(CENTER);
    fill(255, 0, 0);
    text("-- GAME OVER --", width/2, 300);
    fill(255);
    for (int i = 0; i < gameOverWin.length; i++) {
      if (i == currentSelection) {
        fill(255, 255, 0);
      }
      text(gameOverWin[i], width/2, 370 + i * 70);
      fill(255);
    }
  }

  // penggunaan if dimana apabila variable alive bernilai true
  if (alive) {

    ground(); // memanggil void ground()
    enemy(); // memanggil void enemy()
    
    // penggunaan if untuk menentukan animasi "run" dengan menggunakan variable AnimState
    if (AnimState == "run") {
      scrollSpeed = 12; // variable scrollSpeed menjadi 12 yang berarti background akan berjalan dengan kecepatan 12
      imageMode(CENTER);
      image(characterRun[animationCounterRun], width/6, playerHeight);
      animationCounterRun++;
      if (animationCounterRun == characterRunLength) {
        animationCounterRun = 0;
      }    
    }
    
    // penggunaan if untuk menentukan animasi "runAttack" dengan menggunakan variable AnimState
    if (AnimState == "runattack") {
      scrollSpeed = 12; // variable scrollSpeed menjadi 12 yang berarti background akan berjalan dengan kecepatan 12
      imageMode(CENTER);
      image(characterRunAttack[animationCounterRunAttack], width/6, playerHeight);
      animationCounterRunAttack++;
      if (animationCounterRunAttack == characterRunAttackLength) {
        animationCounterRunAttack = 0; 
      }
    }
    
    // penggunaan if untuk menentukan animasi "hurt" dengan menggunakan variable AnimState
    if (AnimState == "hurt") {
      scrollSpeed = 4;
      imageMode(CENTER);
      image(characterHurt[animationCounterHurt], width/6, playerHeight);
      animationCounterHurt++;
      if (animationCounterHurt == characterHurtLength) {
        animationCounterHurt = 0;  
      }
    }
  }
}

// void atau procedure untuk aksi keyPressed (ketika menekan sebuah tombol di keyboard)
void keyPressed() {
  
  // penggunaan if dimana apabila view sama dengan 0 atau tampilan main menu
  if (view == 0) {
    startTime = 0;
    
    // penggunaan if dimana apabila tombol UP ditekan, maka variable currentSelection akan decrement dan menjalankan sound "menuSelect"
    if (keyCode == UP) {
      currentSelection--;
      menuSelect.play();
      menuSelect.amp(0.3);
      if (currentSelection < 0) {
        currentSelection = menu.length - 1;  
      }
    }
    
    // penggunaan if dimana apabila tombol down ditekan, maka variable currentSelection akan increment dan menjalankan sound "menuSelect"
    if (keyCode == DOWN) {
      currentSelection++;
      menuSelect.play();
      menuSelect.amp(0.3);
      if (currentSelection >= menu.length) {
        currentSelection = 0; 
      }
    }
    
    // penggunaan if dimana apabila tombol ENTER ditekan
    if (keyCode == ENTER) {
      
      // penggunaan if dimana apabila variable currentSelection sama dengan 0, maka akan memulai game kembali
      if (currentSelection == 0) {
        view = 1;
        random = 1;
        score = 0;
        milisecs = seconds = minutes = 0;
        healPosition = 1280;
        boulderPosition = 1280;
        enemyPosition = 1280;
        enemy1Counter = 0;
        enemy2Counter = 0;
        enemy3Counter = 0;
        startTime = millis();
        runOnce = true;
        mainMenu = false;
        alive = true;
        bgmMenu.stop();
        bgmGame.loop();
        bgmGame.amp(0.1);
        
      // penggunaan if dimana apabila variable currentSelection sama dengan 1, maka akan beralih ke how to play  
      } else if (currentSelection == 1) {
        view = 6;
        mainMenu = false;
        howtoPlay = true;
      
      // penggunaan if dimana apabila variable currentSelection sama dengan 2, maka akan beralih ke credits
      } else if (currentSelection == 2) {
        view = 4;
        mainMenu = false;
        credits = true;

      // penggunaan if dimana apabila variable currentSelection sama dengan 3, maka akan menutup program
      } else if (currentSelection == 3) {
        exit();
      }
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 1 atau tampilan game dan variable playerHeight lebih dari 250
  if (view == 1 && playerHeight > 250) {
    
    // penggunaan if dimana apabila tombol UP ditekan, maka variable playerHeight akan berkurang sebesar 50
    if (keyCode == UP) {
      playerHeight -= 50;
    }
  } 
  
  // penggunaan if dimana apabila view sama dengan 1 atau tampilan game dan variable playerHeight kurang dari 500
  if (view == 1 && playerHeight < 500) {
    
    // penggunaan if dimana apabila tombol DOWN ditekan, maka variable playerHeight akan bertambah sebesar 50
    if (keyCode == DOWN) {
      playerHeight += 50; 
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 2 atau tampilan kalah / game over
  if (view == 2) {
    startTime = 0;
    
    // penggunaan if dimana apabila tombol UP ditekan, maka variable currentSelection akan decrement dan menjalankan sound "menuSelect"
    if (keyCode == UP) {
      currentSelection--;
      menuSelect.play();
      menuSelect.amp(0.3);
      if (currentSelection < 0) {
        currentSelection = gameOverWin.length - 1;  
      }
    }
    
    // penggunaan if dimana apabila tombol DOWN ditekan, maka variable currentSelection akan increment dan menjalankan sound "menuSelect"
    if (keyCode == DOWN) {
      currentSelection++;
      menuSelect.play();
      menuSelect.amp(0.3);
      if (currentSelection >= gameOverWin.length) {
        currentSelection = 0; 
      }
    }
    
    // penggunaan if dimana apabila tombol ENTER ditekan
    if (keyCode == ENTER) {
      
      // penggunaan if dimana apabila variable currentSelection sama dengan 0, maka akan memulai game kembali
      if (currentSelection == 0) {
        view = 1;
        random = 1;
        score = 0;
        milisecs = seconds = minutes = 0;
        healthPoints = 100;
        boulderPosition = 1280;
        healPosition = 1280;
        enemyPosition = 1280;
        enemy1Counter = 0;
        enemy2Counter = 0;
        enemy3Counter = 0;
        currentSelection = 0;
        alive = true;
        win = false;
        runOnce = true;
        startTime = millis();
        bgmGame.loop();
        bgmGame.amp(0.1);       
      
      // penggunaan if dimana apabila variable currentSelection sama dengan 1, maka akan kembali ke main menu
      } else if (currentSelection == 1) {
        view = 0;
        healthPoints = 100;
        currentSelection = 0;
        mainMenu = true;
        bgmMenu.loop();
        bgmMenu.amp(0.1);
      }
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 3 atau tampilan menang
  if (view == 3) {
    startTime = 0;
    
    // penggunaan if dimana apabila tombol UP ditekan, maka variable currentSelection akan decrement dan menjalankan sound "menuSelect"
    if (keyCode == UP) {
      currentSelection--;
      menuSelect.play();
      menuSelect.amp(0.3);
      if (currentSelection < 0) {
        currentSelection = gameOverWin.length - 1;  
      }
    }
    
    // penggunaan if dimana apabila tombol DOWN ditekan, maka variable currentSelection akan increment dan menjalankan sound "menuSelect"
    if (keyCode == DOWN) {
      currentSelection++;
      menuSelect.play();
      menuSelect.amp(0.3);
      if (currentSelection >= gameOverWin.length) {
        currentSelection = 0; 
      }
    }
    
    // penggunaan if dimana apabila tombol ENTER ditekan
    if (keyCode == ENTER) {
      
      // penggunaan if dimana apabila variable currentSelection sama dengan 0, maka akan memulai game kembali
      if (currentSelection == 0) {
        view = 1;
        score = 0;
        milisecs = seconds = minutes = 0;
        healthPoints = 100;
        boulderPosition = 1280;
        healPosition = 1280;
        enemyPosition = 1280;
        enemy1Counter = 0;
        enemy2Counter = 0;
        enemy3Counter = 0;
        random = 1;
        currentSelection = 0;
        startTime = millis(); 
        alive = true;
        runOnce = true;
        win = false;
        bgmGame.loop();
        bgmGame.amp(0.1);
        
      // penggunaan if dimana apabila variable currentSelection sama dengan 1, maka beralih ke main menu
      } else if (currentSelection == 1) {
        view = 0; // view 0 = tampilan main menu
        healthPoints = 100;
        currentSelection = 0;
        mainMenu = true;
        bgmMenu.loop();
        bgmMenu.amp(0.1);
      }
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 4 atau tampilan credits
  if (view == 4) {
    
    // penggunaan if dimana apabila tombol ESC ditekan, maka akan keluar dari tampilan credits dan kembali ke tampilan main menu
    if (key == ESC) {
      key = 0;
      creditY = 0;
      currentSelection = 0;
      mainMenu = true;
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 4 atau tampilan credits dan variable creditY kurang dari 0
  if (view == 4 && creditY < 0) {
    
    // penggunaan if dimana apabila tombol UP ditekan, maka variable creditY akan ditambahkan dengan variable creditSpeed
    if (keyCode == UP) {
      creditY += creditSpeed;
    }
  } 
  
  // penggunaan if dimana apabila view sama dengan 4 atau tampilan credits dan variable creditY lebih dari -635
  if (view == 4 && creditY > -635) {
    
    // penggunaan if dimana apabila tombol DOWN ditekan, maka variable creditY akan dikurangkan dengan variable creditSpeed
    if (keyCode == DOWN) {
      creditY -= creditSpeed;
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 5 atau tampilan controls
  if (view == 5) {
    
    // penggunaan if dimana apabila tombol ENTER ditekan, maka akan beralih ke main menu dan menjalankan sound "bgmMenu"
    if (keyCode == ENTER) {
      view = 0; // view 0 = tampilan main menu
      currentSelection = 0;
      mainMenu = true;
      bgmMenu.loop();
      bgmMenu.amp(0.1);
    }
  }
  
  // penggunaan if dimana apabila view sama dengan 6 atau tampilan how to play
  if (view == 6) {
    
    // penggunaan if dimana apabila tombol RIGHT ditekan, maka variable page akan increment
    if (keyCode == RIGHT) {
      page++;  
    }
    
    // penggunaan if dimana apabila tombol LEFT ditekan, maka variable page akan decrement
    if (keyCode == LEFT) {
      page--;  
    }
    
    // penggunaan if dimana apabila tombol ESC ditekan, maka akan keluar dari tampilan how to play dan kembali ke tampilan main menu
    if (key == ESC) {
      key = 0;
      currentSelection = 0;
      mainMenu = true;
    }
  }
}
