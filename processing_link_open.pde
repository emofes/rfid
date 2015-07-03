import processing.serial.*;

Serial myPort;

int readSerial = -1;
boolean now = false;

int limit = 1;

PFont f;

void setup()
{
	myPort = new Serial(this, Serial.list()[3], 9600); // connect to arduino

	println(myPort);

	// set up background and text
	size(600, 300);
	f = createFont("Georgia", 36);
	textFont(f);
}

void draw()
{

	background(100);
	textAlign(CENTER);

	//didn't check if to see if port was connected/ availabe with
	//usual while(myPort.available() > 0), couldn't get it to work
	//might add it later but it works without it

	readSerial = myPort.read();

	// found values for on and off through trial and error
	// I'm assuming they're being sent from somewhere in the 
	// rc522 library
	if (readSerial == 49)
	{
		now = true;
		println(now);
	}

	if (readSerial == 48)
	{
		now = false;
		println(now);
	}

	if(now)
		open();

	else
		closed();
}

void open()
{
	text("ACCESS GRANTED", 300, 150);
	fill(50);
	
	//only open 1 link, learned that te hard way
	if(limit == 1)
	{
		link("http://reddit.com");
		++limit;
	}
}

void closed()
{
	text("CLOSED", 300, 150);
	fill(50);
	//reset limit
	limit = 1;
}
