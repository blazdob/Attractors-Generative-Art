void showMenu() {
  background(140, 200, 120);
  //
  // draw a square if the mouse curser is over the button
  // draw the button in the window
  textSize(15);
  button_Lorenz.Draw();
  button_QiChen.Draw();
  Glasba.Draw();
  textSize(20);
  fill(255);
  text(tekst_glasba, 300, 400, 3);
  textSize(15);
  text("Najprej izberi, ali želiš uporabiti audio datoteko ali sistemski zvok.", 430, 290, 3);
} // func
