import flash.display.Graphics;
import flash.geom.Point;
import flash.events.MouseEvent;
import flash.display.MovieClip;
import fl.controls.Label;



var rbsrPositionAtDna: Array = new Array();
var crpPositionAtDna: Array = new Array();
var rnaPositionAtDna: Array = new Array();
var strelkaPosition: Array = new Array();

rbsrPositionAtDna.push(new Point(556.10, 86));
rbsrPositionAtDna.push(new Point(556.10, 263));
rbsrPositionAtDna.push(new Point(556.10, 436));
rbsrPositionAtDna.push(new Point(556.10, 614));

crpPositionAtDna.push(new Point(479, 87));
crpPositionAtDna.push(new Point(479, 265));
crpPositionAtDna.push(new Point(479, 438));
crpPositionAtDna.push(new Point(479, 614));


rnaPositionAtDna.push(new Point(494.5+ 1, 14-1));
rnaPositionAtDna.push(new Point(494.5 + 1   , 190 + 1));
rnaPositionAtDna.push(new Point(494.5 +2, 366-2));
rnaPositionAtDna.push(new Point(494.5 + 2, 542 - 2));

strelkaPosition.push(new Point(880, 46.50));
strelkaPosition.push(new Point(880, 223.50));
strelkaPosition.push(new Point(880, 396.50));
strelkaPosition.push(new Point(880, 572.50));

var otherStrelka: OtherStrelka;
var moovingObjects: Array = new Array();

for (var i = 0; i < 4; i++) {

	rbsrPositionAtDna[i] = new Point(rbsrPositionAtDna[i].x, rbsrPositionAtDna[i].y + 58);
	crpPositionAtDna[i] = new Point(crpPositionAtDna[i].x , crpPositionAtDna[i].y + 58 + 6);
	rnaPositionAtDna[i] = new Point(rnaPositionAtDna[i].x, rnaPositionAtDna[i].y + 58);
	strelkaPosition[i] = new Point(strelkaPosition[i].x, strelkaPosition[i].y + 58);
}

var takenSpaces: Array = new Array();
var rbsrOnStage: Array = new Array();
var crpOnStage: Array = new Array();
var rnaOnStage: Array = new Array();
var strelki: Array = new Array();




var timeFade = 24 * 3;
var count=0;
arrow.addEventListener(Event.ENTER_FRAME, count3);
function count3(e:Event){
	count++;
	if(count==24){
		arrow.addEventListener(Event.ENTER_FRAME, fadeOut);
		arrow.removeEventListener(Event.ENTER_FRAME, count3);
	}
	
}

function fadeOut(e: Event) {
			arrow.alpha -= 1 / timeFade;
			scroll.alpha -=1 / timeFade
			if (scroll.alpha <= 0) {
				arrow.removeEventListener(Event.ENTER_FRAME, fadeOut);
				arrow.parent.removeChild(arrow);
				scroll.parent.removeChild(scroll);
			}


}

var takenDna: Array = new Array();

var rbsrAtDNA: Array = new Array();
var newRbsr = new Array();

var otherEndTakenSpaces = new Array();


var prevVal;
trace(upDown.value);
prevVal = upDown.value;
upDown.addEventListener(Event.CHANGE, stepChange);

Start.addEventListener(MouseEvent.CLICK, onClick);
continuousPlay.addEventListener(MouseEvent.CLICK, onClickCont);
var cont: Boolean = false;

function onClickCont(e: MouseEvent) {

	if (!hasEventListener(Event.ENTER_FRAME)) {
		continuousPlay.label = "Stop";
		Start.label = "Stop";
		cont = true;
		addEventListener(Event.ENTER_FRAME, move);


		for (var i = 0; i < moovingObjects.length; i++) {
			moovingObjects[i].resume();
			//trace("ja");
		}
		moovingObjects.length = 0;
	} else {


		continuousPlay.label = "Continuous Play";
		Start.label = "Start";
		cont = false;
		removeEventListener(Event.ENTER_FRAME, move);

		for (i = 0; i < stage.numChildren; i++) {
			var mc: MovieClip = stage.getChildAt(i) as MovieClip
			trace(mc.getChildAt(1));
			if (mc.getChildAt(1) is DrawPic) {

				if (DrawPic(mc.getChildAt(1)).hasListener())
					moovingObjects.push(DrawPic(mc.getChildAt(1)));
				DrawPic(mc.getChildAt(1)).pause();
			}
		}
	}

}

function onClick(e: MouseEvent) {

	if (!hasEventListener(Event.ENTER_FRAME)) {
		continuousPlay.label = "Stop";
		Start.label = "Stop";
		addEventListener(Event.ENTER_FRAME, move);

		cont=false;
		for (var i = 0; i < moovingObjects.length; i++) {
			moovingObjects[i].resume();
			//trace("ja");
		}
		moovingObjects.length = 0;
	} else {
		
		continuousPlay.label = "Continuous Play";
		Start.label = "Start";
		removeEventListener(Event.ENTER_FRAME, move);

		for (i = 0; i < stage.numChildren; i++) {
			var mc: MovieClip = stage.getChildAt(i) as MovieClip
			trace(mc.getChildAt(1));
			if (mc.getChildAt(1) is DrawPic) {

				if (DrawPic(mc.getChildAt(1)).hasListener())
					moovingObjects.push(DrawPic(mc.getChildAt(1)));
				DrawPic(mc.getChildAt(1)).pause();
			}
			//mc.stop();

		}
		/*for(i=0;i<moovingObjects.length;i++){
				moovingObjects[i].pause();
				//trace("ja");
				}*/

	}


}

function stepChange(e: Event) {


	var diff = upDown.value - prevVal
	trace(diff);

	var i: int;
	var meshW: int = stage.stageWidth / 3;
	meshW -= 150;
	var meshH: int = stage.stageHeight;
	meshH -= 75;
	if (diff > 0) {
		while (diff > 0) {

			var addLok: Number = getRandomLocation();

			var xLok: int = addLok % 3;
			var yLok: int = addLok / 3;

			var rbsr: RbsR = new RbsR();

			rbsr.x = ((xLok) * meshW / 3) + ((meshW / 3) / 2);
			rbsr.y = ((yLok) * meshH / 4) + ((meshH / 4) / 2) + 75;

			rbsr.x += getRandomNumber(-20, 20);
			rbsr.y += getRandomNumber(-20, 20);

			var d: DrawPic = new DrawPic(rbsr, new Point(rbsr.x, rbsr.y), new Point(854, 92), 2, stage.height);
			rbsrOnStage.push(d);
			stage.addChild(rbsr);
			diff--;
		}


	} else if (diff < 0) {
		diff *= -1;
		while (diff > 0) {
			d = rbsrOnStage.pop();
			var r: RbsR = RbsR(d.obj);
			stage.removeChild(r);
			takenSpaces.pop();
			diff--;
		}
	}


	/*
	for (var i = 0; i < rbsrOnStage.length; i++) {
		
	stage.removeChild(rbsrOnStage[i].obj);
	}
	
	rbsrOnStage.length=0;
	takenSpaces.length=0;
	
	setupStartLocations(upDown.value);*/
	addInitalEventListener();
	prevVal = upDown.value;

}

setupStartLocations(upDown.value);
addInitalEventListener();


function getNoOfRbsrMove(): int {

	var percent: Number = 4 * (rbsrOnStage.length / 9);

	var tmp1: int, tmp2: int;
	if (percent > 1)
		tmp1 = percent - 1;
	else tmp1 = 0;

	if (percent < 3)
		tmp2 = percent + 1;
	else tmp2 = 4;

	var noOfRbsrMove = getRandomNumber(tmp1, tmp2);

	return noOfRbsrMove;

}

function setupStartLocations(howMany: Number) {
	if (howMany > 12) return; //exception

	var i: int;
	var meshW: int = stage.stageWidth / 3;
	meshW -= 150;
	var meshH: int = stage.stageHeight;
	meshH -= 75;
	/*var g: Graphics = graphics;
	
	for (i = 0; i < 4; i++) {
		g.lineStyle(3, 0x00ff00);
		g.beginFill(0x0000FF);
		if (i < 4) {
			g.moveTo((meshW / 3) * i, 75);
			g.lineTo((meshW / 3) * i, meshH + 75);
		}
		g.moveTo(0, (meshH / 4) * i + 75);
		g.lineTo(meshW, (meshH / 4) * i + 75);
		g.endFill();
	}*/

	for (i = 0; i < howMany; i++) {
		var addLok: Number = getRandomLocation();

		var xLok: int = addLok % 3;
		var yLok: int = addLok / 3;

		var rbsr: RbsR = new RbsR();

		rbsr.x = ((xLok) * meshW / 3) + ((meshW / 3) / 2);
		rbsr.y = ((yLok) * meshH / 4) + ((meshH / 4) / 2) + 75;

		rbsr.x += getRandomNumber(-20, 20);
		rbsr.y += getRandomNumber(-20, 20);

		var d: DrawPic = new DrawPic(rbsr, new Point(rbsr.x, rbsr.y), new Point(854, 92), 2, stage.height);
		rbsrOnStage.push(d);
		stage.addChild(rbsr);

	}

	/*crpOnStage.length = 0;
	takenDna.length = 0;
	rnaOnStage.length = 0;
	rbsrAtDNA.length = 0;*/




}



function otherEndLocation() {


	var i: int;
	var meshW: int = stage.stageWidth / 3;
	meshW -= 150;
	var meshH: int = stage.stageHeight;
	meshH -= 75;
	/*var g: Graphics = graphics;

	for (i = 0; i < 5; i++) {
		g.lineStyle(3, 0x990000);
		g.beginFill(0x0000FF);
		if (i < 4) {
			g.moveTo(stage.stageWidth - ((meshW / 3) * i), 75);
			g.lineTo(stage.stageWidth - ((meshW / 3) * i), meshH + 75);
		}
		g.moveTo(stage.stageWidth, (meshH / 4) * i + 75);
		g.lineTo(stage.stageWidth - meshW, (meshH / 4) * i + 75);
		g.endFill();
	}*/


	for (i = 0; i < newRbsr.length; i++) {
		var addLok: Number = getRandomLocation2();

		var xLok: int = addLok % 3;
		var yLok: int = addLok / 3;

		var posX = stage.stageWidth - (((meshW / 3) * xLok) + ((meshW / 3) / 2));
		var posY = ((meshH / 4) * yLok) + ((meshH / 4) / 2) + 75;

		posX += getRandomNumber(-20, 20);
		posY += getRandomNumber(-20, 20);

		newRbsr[i].setUpEndPoint(new Point(posX, posY));
		newRbsr[i].startMove();
	}

}




function getRandomLocation() {
	while (1) {
		var rand: Number = (Math.floor(Math.random() * (11 - 0 + 1)) + 0);
		var index: int = takenSpaces.indexOf(rand);
		if (index == -1) {
			takenSpaces.push(rand);
			return rand;
		}
	}

}

function getRandomLocation2() {
	while (1) {
		var rand: Number = (Math.floor(Math.random() * (11 - 0 + 1)) + 0);
		var index: int = otherEndTakenSpaces.indexOf(rand);
		if (index == -1) {
			otherEndTakenSpaces.push(rand);
			return rand;
		}
	}

}

function getRandomNumber(min: int, max: int) {
	var rand: Number = (Math.floor(Math.random() * (max - min + 1)) + min);
	return rand;
}



var phase: Number = 1;
var phaseDone: Boolean = true;

//stage.addEventListener(MouseEvent.CLICK, onClick)
//stage.addEventListener(Event.ENTER_FRAME, move);





function getCrpOnStage() {

	var a = 20;
	for (var i = 0; i < 4; i++) {
		if (takenDna.indexOf(i) == -1) {
			var crp = new Crp();
			crp.x = 400 + getRandomNumber(-10, 10);
			crp.y = 100 + a;
			a += crp.height + 5;
			//stage.addChild(crp);
			var dcrp = new DrawPic(crp, new Point(crp.x, crp.y), new Point(854, 92), 2, stage.height);
			dcrp.setUpEndPoint(crpPositionAtDna[i]);
			crpOnStage.push(dcrp);
		}

	}

}

function addInitalEventListener() {
	for (i = 0; i < rbsrOnStage.length; i++) {
		rbsrOnStage[i].obj.addEventListener(MouseEvent.CLICK, onClick);
	}
}

function startOne() {
	myText.text = text[1];
	trace("One started");
	/*for (i = 0; i < takenSpaces.length; i++) {
		trace(takenSpaces[i]);
	}*/


	var noOfRbsrMove = getNoOfRbsrMove();
	trace();
	trace(rbsrOnStage.length);
	trace(noOfRbsrMove);



	for (var i = 0; i < noOfRbsrMove; i++) {
		while (1) {

			var rand = getRandomNumber(0, 3);
			if (takenDna.indexOf(rand) == -1) {

				takenDna.push(rand);
				rbsrOnStage[i].setUpEndPoint(rbsrPositionAtDna[rand]);
				break;
			}
		}

	}



	for (i = 0; i < noOfRbsrMove; i++) {
		var tmp = rbsrOnStage.shift();
		//tmp.obj.removeEventListener(MouseEvent.CLICK, onClick);
		tmp.startMove();
		//moovingObjects.push(tmp);
		rbsrAtDNA.push(tmp);
		takenSpaces.shift();

	}



	//
	/*for (i = 0; i < takenSpaces.length; i++) {
		trace(takenSpaces[i]);
	}*/

}




function startTwo() {
	trace("Two started");
	//myText.text = text[2];
	getCrpOnStage();

	for (var i = 0; i < crpOnStage.length; i++) {
		stage.addChild(crpOnStage[i].obj);
		crpOnStage[i].startFadeIn(1);
	}


}



function startThree() {
	myText.text = text[2];
	trace("Three started");
	for (var i = 0; i < crpOnStage.length; i++) {
		//stage.addChild(crpOnStage[i].obj);
		//crpOnStage[i].obj.removeEventListener(MouseEvent.CLICK, onClick);

				
				crpOnStage[i].startMove();
		//moovingObjects.push(crpOnStage[i]);
	}

}



function startFour() {
	//myText.text = text[4];
	trace("Four started");
	for (var i = 0; i < 4; i++) {

		var r = new RNA();
		r.x = rnaPositionAtDna[i].x - 200;
		r.y = rnaPositionAtDna[i].y + 5;
		stage.addChild(r);
		var dr = new DrawPic(r, new Point(r.x, r.y), new Point(rnaPositionAtDna[i].x, rnaPositionAtDna[i].y), 2, stage.height);
		dr.startFadeIn(1);
		dr.obj.addEventListener(MouseEvent.CLICK, onClick);
		rnaOnStage.push(dr);
		
		
	}
	
	

}

function startFive() {
	myText.text = text[3];
	trace("Five started");
	for (var i = 0; i < 4; i++) {

		//moovingObjects.push(rnaOnStage[i]);
		if (takenDna.indexOf(i) == -1)
			rnaOnStage[i].startMove();
		else
			rnaOnStage[i].startMoveAndBounce();
	}
	
	
	

}

function startSix() {
	myText.text = text[4];
	trace("Six started");
	while (rbsrAtDNA.length > 0) {
		//trace(removeAtPhase2.length);
		var a = rbsrAtDNA.pop();
		a.startFadeOut(1);

	}

	while (crpOnStage.length > 0) {
		//trace(removeAtPhase2.length);
		a = crpOnStage.pop();
		a.startFadeOut(1);

	}

	for (var i = 0; i < rnaOnStage.length; i++) {
		
		if (takenDna.indexOf(i) == -1)
			rnaOnStage[i].startMoveStraight(1.5);
		else rnaOnStage[i].startFadeOut();
	}

}
var addMore;

var dotherStrelka: DrawPic;
function startSeven() {
	//myText.text = text[7];
	trace("Seven started");

	//make fade in and then out
	otherStrelka = new OtherStrelka();
	otherStrelka.x = 890.25;
	otherStrelka.y = 30;
	dotherStrelka = new DrawPic(otherStrelka, null, null, 1, NaN);
	dotherStrelka.startFadeIn();
	stage.addChild(otherStrelka);



	for (var i = 0; i < rnaOnStage.length; i++) {
		if (takenDna.indexOf(i) == -1) {
			rnaOnStage[i].startFadeOut();
			var strelka: Strelka = new Strelka();
			strelka.x = strelkaPosition[i].x;
			strelka.y = strelkaPosition[i].y;
			stage.addChild(strelka);
			var dstrelka = new DrawPic(strelka, null, null, 1, NaN);
			dstrelka.startFadeIn();
			strelki.push(dstrelka);

			var rbsr = new RbsR();
			rbsr.x = strelka.x + strelka.width + 30;
			rbsr.y = strelka.y + strelka.height / 2;
			rbsr.addEventListener(MouseEvent.CLICK, onClick);
			stage.addChild(rbsr);
			var nrbsr = new DrawPic(rbsr, new Point(rbsr.x, rbsr.y), new Point(rbsr.x, rbsr.y), 2, stage.height);
			nrbsr.startFadeIn();
			newRbsr.push(nrbsr);


		}
	}
	
	var left = 12-newRbsr.length;
	
	if(left<10)
		addMore=2;
	else addMore=3;
	
	for (i = 0; i < addMore; i++) {
		rbsr = new RbsR();
		rbsr.x = 880 + 97 + 30;
		rbsr.y = 50 + 30;
		stage.addChild(rbsr);
		rbsr.addEventListener(MouseEvent.CLICK, onClick);
		nrbsr = new DrawPic(rbsr, new Point(rbsr.x, rbsr.y), new Point(rbsr.x, rbsr.y), 2, stage.height);
		nrbsr.startFadeIn();
		newRbsr.push(nrbsr);
	}




}

function startEight() {
	myText.text = text[5];
	trace("Eight started");

	otherEndLocation();
	for (var i = 0; i < strelki.length; i++) {

		strelki[i].startFadeOut();
	}
	strelki.length = 0;
	dotherStrelka.startFadeOut();



}






var riboseOnStage = new Array();

function startNine() {

	//myText.text = text[9];
	trace("Nine started");
	
	

	for (var i = 0; i < newRbsr.length; i++) {

		newRbsr[i].obj.removeEventListener(MouseEvent.CLICK, onClick);
	}
	
	
	
	var nrib;
	//if(newRbsr.length>1)
	//		nrib = getRandomNumber(addMore,addMore+1);
	//else 	
		nrib = addMore;	
	

	for (i = 0; i < nrib; i++) {
		var ribose = new Ribose();
		ribose.x = 881;
		ribose.y = 30
		stage.addChild(ribose);
		var dribose = new DrawPic(ribose, new Point(ribose.x, ribose.y), new Point(ribose.x, ribose.y), 1.5, stage.height);
		riboseOnStage.push(dribose);
		dribose.startFadeIn();
		//dribose.obj.addEventListener(MouseEvent.CLICK, onClick);
	}

}

var chosenRbsr = new Array();
function startTen() {
	myText.text = text[6];
	trace("Ten started");
	for (i = 0; i < riboseOnStage.length; i++) {

		riboseOnStage[i].obj.addEventListener(MouseEvent.CLICK, onClick);
		while (1) {
			var rand = getRandomNumber(0, newRbsr.length - 1);
			if (chosenRbsr.indexOf(rand) == -1) {
				chosenRbsr.push(rand);
				riboseOnStage[i].setUpEndPoint(new Point(newRbsr[rand].getPos().x - 82.5, newRbsr[rand].getPos().y - 97.1));
				riboseOnStage[i].startMove();

				break;
			}
		}
	}

}

function startEleven() {
	trace("Eleven started");
	//myText.text = text[11];
	for (var i = 0; i < newRbsr.length; i++) {
		if (chosenRbsr.indexOf(i) != -1)
			newRbsr[i].startFadeOut();
	}

	for (i = 0; i < riboseOnStage.length; i++) {
		riboseOnStage[i].startFadeOut();
		riboseOnStage[i].obj.removeEventListener(MouseEvent.CLICK, onClick);
	}
	
	for(i=0;i<newRbsr.length;i++){
		if (chosenRbsr.indexOf(i) == -1) {
			newRbsr[i].obj.addEventListener(MouseEvent.CLICK,onClick);
		}
	}
	
	

}

function startTwelve() {
	trace("Twelve started");
	myText.text = text[7];
	for (var i = 0; i < newRbsr.length; i++) {
		if (chosenRbsr.indexOf(i) == -1) {
			var meshW: int = stage.stageWidth / 3;
			meshW -= 150;
			var meshH: int = stage.stageHeight;
			meshH -= 75;
			var addLok: Number = getRandomLocation();

			var xLok: int = addLok % 3;
			var yLok: int = addLok / 3;

			var tempRbsr = newRbsr[i];

			var posX = ((xLok) * meshW / 3) + ((meshW / 3) / 2);
			var posY = ((yLok) * meshH / 4) + ((meshH / 4) / 2) + 75;

			posX += getRandomNumber(-20, 20);
			posY += getRandomNumber(-20, 20);


			tempRbsr.setUpEndPoint(new Point(posX, posY));
			var r = new RbsR();
			r.x = posX;
			r.y = posY;


			var a = new DrawPic(r, tempRbsr.endPoint, tempRbsr.endPoint, 2, stage.height);

			stage.addChild(r);
			rbsrOnStage.push(a);
			a.startFadeIn();
			tempRbsr.startFadeOut();

			//---------------

			/*var addLok: Number = getRandomLocation();

			var xLok: int = addLok % 3;
			var yLok: int = addLok / 3;

			var rbsr: RbsR = new RbsR();

			rbsr.x = ((xLok) * meshW / 3) + ((meshW / 3) / 2);
			rbsr.y = ((yLok) * meshH / 4) + ((meshH / 4) / 2) + 75;

			rbsr.x += getRandomNumber(-20, 20);
			rbsr.y += getRandomNumber(-20, 20);*/


		}

	}

	


	/*for (i = 0; i < takenSpaces.length; i++) {
		trace(takenSpaces[i]);
	}*/

}

var text: Array = new Array();
var txtInst: String = "??? ? ?????????? ?? ???????? ?? ??????";
text.push(txtInst);
txtInst = "?? ??????? RbsR ?? ????????????? ?? ???????. ???? ??????? ?? ??? ?? ?? ????? ?? DNA ???????. ";
txtInst += "????? ?? ?????????? ???????????? (CRP) ??????????? ?? ???????? ???????.";
text.push(txtInst);
txtInst = "???????????? ?? ???????? ???? ???? ???? ??? ???? rbsR ? ???? ?? ??? ????? ? ????? ?????????????. ";
txtInst+="??????????? ???????????? ???? ????? ?? ????? ?? ?????????????.";
text.push(txtInst);
txtInst = "???????????? ?? ?????? ???? ?? ???? ????? ???? ??? ?? ???? ??????????? Rbsr ? ???? ??? ??? ????????? CRP.";
text.push(txtInst);
txtInst = "??? ????????????? ?? ????????????? ???? ???????? ??? ?? ???????? ?? ???????????? ?? ??????, ???? ??? ? RbsR";
text.push(txtInst);
txtInst = "??????? ?? ???????? ????????.";
text.push(txtInst);
txtInst = "?? ???? ??? ?? rbsR ?? ?? ???? ???????? ? ???? ?? ?????????? ??? rbsR ?? ???????? ???? ?????????. ";
txtInst += "??? ????? ???? ???? ??? ?????? ??????????? ?? ??????, ??? ??????? ???? ? ?????? ?????????????.";

text.push(txtInst);
txtInst = "?????????? ??? ?? rbsR ?? ?? ????? ?? ??????? ?? ???????? ??????????.";
text.push(txtInst);
/*descr.Add("??? ? ?????????? ?? ???????? ?? ??????");
            descr.Add("?? ??????? RbsR ?? ????????????? ?? ???????. ???? ??????? ?? ??? ?? ?? ????? ?? DNA ???????");
            descr.Add("????? ?? ?????????? ???????????? (CRP) ??????????? ?? ???????? ???????");
            descr.Add("???????????? ?? ???????? ???? ???? ???? ??? ???? rbsR ? ???? ?? ??? ????? ? ????? ?????????????");
            descr.Add("????? ??????????? ???????????? ???? ????? ?? ????? ?? ?????????????");
            descr.Add("???????????? ?? ???????? ???? ?? ???? ????? ???? ??? ???? ???? ? ???? ??? ??? ?????????");
            descr.Add("?? ?????? ?? ???????, ----");
            descr.Add("??????? ?????????????");
            descr.Add("?? ????????????? ???? ???????? ??? ?? ???????? ?? ???????????? ?? ??????, ???? ??? ? RbsR");
            descr.Add("???????????? ????????? ----");
            descr.Add("???? ?? ?????????");
            descr.Add("?? ???? ??? ?? rbsR ?? ?? ???? ???????? ? ???? ?? ?????????? ??? rbsR ?? ???????? ???? ?????????");
            descr.Add("???????? ?? ?? ???? ?? ???? ??? ??? ???? ??? ?????? ??????????? ?? ??????, ??? ??????? ???? ? ?????? ?????????????");
            descr.Add("??????? ???? ?????????");
            descr.Add("???? rbsR ?? ????? ?? ???????");
            descr.Add("?? ??????? ?????????");*/



var myText: TextField = new TextField();
myText.autoSize = TextFieldAutoSize.LEFT;
myText.width=1366;
//myText.height=50;
myText.wordWrap = true;
myText.multiline = true; 


var inputFormat: TextFormat = new TextFormat();
inputFormat.align = TextFormatAlign.LEFT;
inputFormat.font = "Century Schoolbook";
inputFormat.italic = true;
inputFormat.bold = true;
inputFormat.color = 0x1BC2FA;
inputFormat.size = 20;
myText.defaultTextFormat = inputFormat;


var inp: TextFormat = new TextFormat();
inp.align = TextFormatAlign.LEFT;
inp.font = "Century Schoolbook";
inp.italic = true;
inp.bold = true;
inp.color = 0xD624D3;
inp.size = 16;



inputFormat.size = 16;
inputFormat.color = 0xAEC910;
var click: TextField = new TextField();
click.autoSize = TextFieldAutoSize.LEFT;
//click.defaultTextFormat = inputFormat;
click.text = "?????? ??";
click.x = 322;
click.y=50;

click.setTextFormat(inputFormat);
addChild(click);


var clickOn: TextField = new TextField();
clickOn.autoSize = TextFieldAutoSize.LEFT;
clickOn.defaultTextFormat = inp;
clickOn.text = "RbsR";
clickOn.x = 2 +click.x+click.width;
clickOn.y=50;
addChild(clickOn);

var contd: TextField = new TextField();
contd.autoSize = TextFieldAutoSize.LEFT;
//contd.defaultTextFormat = inputFormat;
contd.text = "?? ?? ???????? ?????????";
contd.x = clickOn.x + 2 +  clickOn.width;
contd.y=50;
contd.setTextFormat(inputFormat);

addChild(contd);




myText.text = text[0];
addChild(myText);

function move(e: Event) {


	var finished;
	if (phase == 1) {
		if (phaseDone == true) {
			startOne();
			phaseDone = false;
			upDown.enabled = false;

		}

		finished = true;
		for (var i = 0; i < rbsrAtDNA.length; i++) {

			finished = finished & rbsrAtDNA[i].finished;

		}

		if (finished) {

			/*for (i = 0; i < rbsrAtDNA.length; i++) {
				moovingObjects.pop();
			}*/


			phase++;
			phaseDone = true;


		}

	}

	if (phase == 2) {
		if (phaseDone == true) {
			//myText.text = text[2];
			startTwo();
			phaseDone = false;




		}


		finished = true;
		for (i = 0; i < crpOnStage.length; i++) {

			finished = finished & crpOnStage[i].finishFade;

		}

		if (finished) {
			//removeEventListener(Event.ENTER_FRAME, move);
			
				for(i=0;i<crpOnStage.length;i++)
			crpOnStage[i].obj.addEventListener(MouseEvent.CLICK, onClick);
			
			
			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				Start.label = "Start";
				continuousPlay.label = "Continuous Play";
				}

			for (i = 0; i < rbsrOnStage.length; i++) {
				rbsrOnStage[i].obj.removeEventListener(MouseEvent.CLICK, onClick);

			}

			for (i = 0; i < rbsrAtDNA.length; i++) {
				rbsrAtDNA[i].obj.removeEventListener(MouseEvent.CLICK, onClick);

			}
			
			
			inp.color = 0x3DC41B;
			clickOn.text = "Crp";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;
			
			if(crpOnStage.length==0){
					clickOn.text = "???????";
				
				inp.color = 0x3DC41B;
				clickOn.setTextFormat(inp);
				contd.x = clickOn.x + clickOn.width;
				}
			phase++;
			phaseDone = true;

			return;

		}

	}

	if (phase == 3) {

		if (phaseDone == true) {

			startThree();
			phaseDone = false;

		}

		finished = true;
		for (i = 0; i < crpOnStage.length; i++) {
			finished = finished & crpOnStage[i].finished;

		}

		if (finished) {


			/*for (i = 0; i < crpOnStage.length; i++) {
			moovingObjects.pop();
			}*/
			//removeEventListener(Event.ENTER_FRAME, move);
			
			phase++;
			phaseDone = true;

		}
	}

	if (phase == 4) {

		if (phaseDone == true) {
			startFour();
			phaseDone = false;
			
		}

		finished = true;
		for (i = 0; i < rnaOnStage.length; i++) {

			finished = finished & rnaOnStage[i].finishFade;

		}

		if (finished) {
			//removeEventListener(Event.ENTER_FRAME, move);
			
			
			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				
				Start.label = "Start";
			continuousPlay.label = "Continuous Play";
			}
			
			
			inp.color = 0xF7AA02;
			clickOn.text = "Polymerase";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;

			
			for(i=0;i<crpOnStage.length;i++)
			crpOnStage[i].obj.removeEventListener(MouseEvent.CLICK, onClick);
			
			phase++;
			phaseDone = true;
			
			
			
			return;

		}


	}

	if (phase == 5) {
		if (phaseDone == true) {

			startFive();
			phaseDone = false;

		}

		finished = true;
		for (i = 0; i < rnaOnStage.length; i++) {


			finished = finished & rnaOnStage[i].finished;

		}

		if (finished) {

			/*for (i = 0; i < rnaOnStage.length; i++) {
			moovingObjects.pop();
			}*/
			
			

			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				Start.label = "Start";
			continuousPlay.label = "Continuous Play";
				
			}
			
			inp.color = 0xF7AA02;
			clickOn.text = "Polymerase";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;
			
			

			/*for (i = 0; i < rnaOnStage.length; i++) {
			rnaOnStage[i].obj.addEventListener(MouseEvent.CLICK, onClick);
			}*/



			phase++;
			phaseDone = true;

			return;

		}


	}

	if (phase == 6) {
		if (phaseDone == true) {
			startSix();
			phaseDone = false;
		}

		finished = true;
		for (i = 0; i < rnaOnStage.length; i++) {
			if (takenDna.indexOf(i) == -1)
				finished = finished & rnaOnStage[i].finishedStraight;

		}
		/*trace();
		trace(crpOnStage.length); 0
		trace();
		trace(rnaOnStage.length);
		trace(rbsrAtDNA.length); 0*/
		if (rbsrAtDNA.length == 0 && finished == true) {
			//trace("eee");

			phase++;
			phaseDone = true;

		}

	}

	if (phase == 7) {
		if (phaseDone == true) {
			startSeven();
			phaseDone = false;
			
		}

		finished = true;
		//trace(rnaOnStage.length);


		for (i = 0; i < strelki.length; i++) {
			finished = finished & strelki[i].finishFade;

		}

		var a: Boolean = dotherStrelka.finishFade;
		if (a == false) {
			finished = false;
		}

		for (i = 0; i < rnaOnStage.length; i++) {
			if (takenDna.indexOf(i) == -1)
				finished = finished & rnaOnStage[i].finishFadeOut;

		}

		for (i = 0; i < newRbsr.length; i++) {

			finished = finished & newRbsr[i].finishFade;

		}




		if (finished == true) {
			//trace("eee");
			//removeEventListener(Event.ENTER_FRAME, move);
			
			for(i=0;i<rnaOnStage.length;i++)
			rnaOnStage[i].obj.removeEventListener(MouseEvent.CLICK, onClick);
			
			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				Start.label = "Start";
			continuousPlay.label = "Continuous Play";
				
				
			}
			
			
			inp.color = 0xD624D3;
			clickOn.text = "a new Rbsr";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;
			
			rnaOnStage.length = 0;
			takenDna.length = 0;
			phase++;
			phaseDone = true;
			return;
		}

	}

	if (phase == 8) {
		if (phaseDone == true) {
			/*trace(takenDna.length);
			trace(rbsrAtDNA.length);
			trace(crpOnStage.length);
			trace(rnaOnStage.length);
			trace();*/
			/*trace(rbsrOnStage.length);
			trace(newRbsr.length);
			trace(takenSpaces.length);*/

			startEight();
			phaseDone = false;


		}


		finished = true;

		for (i = 0; i < strelki.length; i++) {
			finished = finished & strelki[i].finishFadeOut;

		}
		a = dotherStrelka.finishFadeOut;
		if (a == false) {
			finished = false;
		};

		for (i = 0; i < newRbsr.length; i++) {
			finished = finished & newRbsr[i].finished;

		}


		if (finished == true) {
			//trace("eee");

			//removeEventListener(Event.ENTER_FRAME, move);
			otherEndTakenSpaces.length = 0;

			phase = 9;
			phaseDone = true;
			/*trace();
			trace(rbsrOnStage.length);
			trace(newRbsr.length);
			trace(takenSpaces.length);*/

			//removeEventListener(Event.ENTER_FRAME, move);

		}
	}

	if (phase == 9) {
		if (phaseDone == true) {
			/*trace(takenDna.length);
			trace(rbsrAtDNA.length);
			trace(crpOnStage.length);
			trace(rnaOnStage.length);
			trace();*/
			/*trace(rbsrOnStage.length);
			trace(newRbsr.length);
			trace(takenSpaces.length);*/

			startNine();
			phaseDone = false;
			//here or down

			


		}


		finished = true;
		for (i = 0; i < riboseOnStage.length; i++) {
			finished = finished & riboseOnStage[i].finishFade;

		}

		if (finished == true) {

			//removeEventListener(Event.ENTER_FRAME, move);
			//trace("eee");

			/*for (i = 0; i < newRbsr.length; i++) {

				rbsrOnStage.push(newRbsr[i]);

			}

			newRbsr.length = 0;*/
			for(i=0;i<riboseOnStage.length;i++){
				riboseOnStage[i].obj.addEventListener(MouseEvent.CLICK, onClick);
			}
			
			
			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				Start.label = "Start";
			continuousPlay.label = "Continuous Play";
			}
			
			
			inp.color = 0xE0DDD5;
			clickOn.text = "Ribose";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;


			phase = 10;
			phaseDone = true;

			/*trace();
			trace(rbsrOnStage.length);
			trace(newRbsr.length);
			trace(takenSpaces.length);*/
			return;
			//removeEventListener(Event.ENTER_FRAME, move);

		}
	}


	if (phase == 10) {
		if (phaseDone == true) {
			/*trace(takenDna.length);
			trace(rbsrAtDNA.length);
			trace(crpOnStage.length);
			trace(rnaOnStage.length);
			trace();*/
			/*trace(rbsrOnStage.length);
			trace(newRbsr.length);
			trace(takenSpaces.length);*/

			startTen();
			phaseDone = false;


		}

		finished = true;
		for (i = 0; i < riboseOnStage.length; i++) {
			finished = finished & riboseOnStage[i].finished;

		}

		if (finished == true) {
			//removeEventListener(Event.ENTER_FRAME, move);
			phase = 11;
			phaseDone = true;

		}
	}

	if (phase == 11) {
		if (phaseDone == true) {
			startEleven();
			phaseDone = false;

		}

		finished = true;
		for (i = 0; i < riboseOnStage.length; i++) {
			finished = finished & riboseOnStage[i].finishFadeOut;

		}


		for (i = 0; i < newRbsr.length; i++) {
			if (chosenRbsr.indexOf(i) != -1)
				finished = finished & newRbsr[i].finishFadeOut;

		}

		if (finished == true) {
			//removeEventListener(Event.ENTER_FRAME, move);
			riboseOnStage.length = 0;
			phase = 12;
			phaseDone = true;
				if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);}
				
				
				
				
				inp.color = 0xD624D3;
			clickOn.text = "a new RbsR";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;

				
				if(newRbsr.length-chosenRbsr.length==0){
					clickOn.text = "???????";
					contd.x = clickOn.x + clickOn.width;
				}
					
					
			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				Start.label = "Start";
			continuousPlay.label = "Continuous Play";
			}
					
				
				
				
				return;
			
			}


	}

	if (phase == 12) {
		if (phaseDone == true) {
			startTwelve();
			phaseDone = false;

		}

		finished = true;
		for (i = 0; i < newRbsr.length; i++) {
			if (chosenRbsr.indexOf(i) == -1)
				finished = finished & newRbsr[i].finishFadeOut;

		}
		if (finished == true) {
			//removeEventListener(Event.ENTER_FRAME, move);
			
			
			for (i = 0; i < rbsrOnStage.length; i++) {

		rbsrOnStage[i].obj.addEventListener(MouseEvent.CLICK, onClick);
			}
	
			for(i=0;i<newRbsr.length;i++){
				if(chosenRbsr.indexOf(i)==-1){
					newRbsr[i].obj.removeEventListener(MouseEvent.CLICK, onClick);
					}
				}
			newRbsr.length = 0;
			chosenRbsr.length = 0;
			phase = 1;
			phaseDone = true;
			
			
			inp.color = 0xD624D3;
			clickOn.text = "RbsR";
			clickOn.setTextFormat(inp);
			contd.x = clickOn.x + clickOn.width;

			if (cont == false){
				removeEventListener(Event.ENTER_FRAME, move);
				Start.label = "Start";
			continuousPlay.label = "Continuous Play";
			}
			
			//upDown.enabled=true;
			//upDown.value=rbsrOnStage.length;
			
			return;

		}






	}






}