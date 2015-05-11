integer kd=1;float Qt=
0.2;float gu=6.0;vector lD=<1,1
,1>;vector Rg=<0,1,1>;
string aX="8e8f2019-08f1-6200-7ae1-2b0875bf1161";string oU="cd0983ca-8e1b-e47a-9047-6a47587fc231";string YX=
"01a26e4d-735f-c8d2-eab0-988fc7352a03";integer th=1;float ts=0.5;
string Pl="249d66a9-b2cc-2f32-3673-ae251587f574";string JD="65b7c35f-f3a6-719a-d47f-79cacc0b0b16";integer WZ=1337
;integer cT;
integer Pb;integer SN;integer UX;integer FV;
integer lh;integer ov;integer doj;vector gQ
;float Wu=1.0;integer wW=0;integer
 YS=1;integer Is=0;integer Vp=0;
list xU=[];integer NX;integer HS
=0;integer Sn=2;integer pN=0;integer
 MD=-100;float QO;float Ck=1.0
;string Ls="";string xP="";string aB=""
;integer bl;Rv(){integer Ad;
for(Ad=llGetNumberOfPrims();Ad>=0;Ad--){
if("volume"==llGetLinkName(Ad)){FV=Ad;gQ
=llList2Vector(llGetLinkPrimitiveParams(Ad,[7]),0);}
if("volumei"==llGetLinkName(Ad)){lh=Ad;}
if("scroll"==llGetLinkName(Ad)){ov=Ad;
}}return;}vN(){if
(llGetInventoryNumber(1)>1){llStopSound();MD=
-100;xU=[];NX=llGetInventoryNumber(1);
integer ev;for(ev=0;ev<NX;ev++)
{xU=xU+[llGetInventoryName(1,ev)];llSetLinkPrimitiveParamsFast
(ov,[26,"[ "+(string)ev+" / "+(string)
NX+" ] ",<1,1,1>,1]);}
llSetLinkPrimitiveParamsFast(ov,[26,"Sorting...",lD,1]);xU
=llListSort(xU,1,1);llSetLinkPrimitiveParamsFast(ov,[26,
"Finished!",lD,1]);Ls="Finished!";llSetTimerEvent(0.5)
;}else{llSetLinkPrimitiveParamsFast(ov,[26,"No Sounds Found!",lD
,1]);}}pm(){
integer qI;for(qI=llGetNumberOfPrims();qI>=0;qI--
){if("volume"==llGetLinkName(qI)){FV=
qI;gQ=llList2Vector(llGetLinkPrimitiveParams(qI,[7]),0)
;}if("volumei"==llGetLinkName(qI)){lh=
qI;}if("scroll"==llGetLinkName(qI)){ov
=qI;}if("scrolli"==llGetLinkName(qI)){
doj=qI;}if("settings"==llGetLinkName(qI)){
Pb=qI;}if("looptogl"==llGetLinkName(qI))
{SN=qI;}if("texttog"==llGetLinkName(qI))
{UX=qI;}}Ls="Loading...";llSetLinkPrimitiveParamsFast
(ov,[26,Ls,lD,1,34,doj,26,
"",<1,1,1>,1]);llSetLinkTextureAnim(
Pb,1|16|32|2,-1,1,1,0,
TWO_PI,0.1*TWO_PI);llSetLinkPrimitiveParamsFast(lh,[7,<gQ
.x*2,gQ.y,gQ.z>]);llSetLinkPrimitiveParamsFast(1,
[17,3,"19956d80-1495-3456-9a69-d8caac73bab4",<0.4,0.9,0>,<0.25,
0,0>,0]);llSetLinkAlpha(FV,0,-1)
;llSetLinkAlpha(lh,0,-1);llSetLinkAlpha(SN,0,
-1);llSetLinkAlpha(UX,0,-1);if(YS
){llSetLinkPrimitiveParamsFast(SN,[17,-1,aX,<0.4,
0.9,0>,<0.25,0,0>,0]);
}else{llSetLinkPrimitiveParamsFast(SN,[17,-1,aX,<
0.4,0.9,0>,<-0.25,0,0>,0]
);}if(Vp){llSetLinkPrimitiveParamsFast(UX,[17
,-1,oU,<0.4,0.9,0>,<0.25,0,
0>,0]);}else{llSetLinkPrimitiveParamsFast(UX,
[17,-1,oU,<0.4,0.9,0>,<-0.25
,0,0>,0]);}llStopSound();
cT=(integer)("0xF"+llGetSubString(llGetOwner(),0,6
))+1337;llListen(cT,"","","");
llListen(WZ,"",llGetOwner(),"");}PG
(string KU,string xg,integer GB,float YK,integer gc)
{if(gc&&Vp){xP=xg;if(
GB){bl=1;llSetLinkPrimitiveParamsFast(ov,[26,KU
,lD,1]);llSetLinkPrimitiveParamsFast(doj,[26,xg,Rg
,1]);}else{bl=0;llSetLinkPrimitiveParamsFast
(ov,[26,KU,lD,1]);}}
else{xP=xg;if(GB){bl
=1;llSetLinkPrimitiveParamsFast(ov,[26,KU,lD,1])
;llSetLinkPrimitiveParamsFast(doj,[26,xg,Rg,1]);
llSetTimerEvent(YK);}else{bl=0;llSetLinkPrimitiveParamsFast
(ov,[26,KU,lD,1]);llSetTimerEvent(YK
);}}}default{state_entry()
{pm();vN();}attach(key
 LB){if(kd){if(LB){
llMessageLinked(-4,0,"updatepls","");}else{
llMessageLinked(-4,0,"updatepls","");}}}
link_message(integer tS,integer ES,string dh,key LB){
if(dh=="checking"){PG("Checking for update...","",0,
0.5,0);}if(dh=="allgood"){PG
("Up To Date","",0,0.3,0);}if(dh
=="updating"){PG("Requesting Update...","",0,5.0,0)
;}if(dh=="timeout"){PG("Server Timeout :(((",""
,0,0.6,0);}}listen(integer Um
,string HO,key LB,string dh){if(Um==cT
&&dh=="destinationpls"){xU=[];NX=0;
pN=0;MD=-100;llRegionSayTo(LB,cT,
(string)llGetKey());}if(Um==WZ)
{if(dh=="playstop"){if(MD<0)
{if(YS){llLoopSound(llList2String(xU,pN),
Wu);Ls="Playing: "+llList2String(xU,pN);PG(
"",Ls,1,2.0,0);MD=pN;aB
=llList2String(xU,MD);Is=1;}else
{llPlaySound(llList2String(xU,pN),Wu);Ls="Playing: "
+llList2String(xU,pN);PG("",Ls,1,2.0
,0);MD=pN;aB=llList2String(xU,MD)
;Is=1;}}else{llStopSound()
;Ls="Stopped: "+llList2String(xU,MD);PG("",
Ls,1,2.0,0);aB="";MD=-
100;Is=0;}}if(dh=="left"||
dh=="right"){if(dh=="left"){pN--
;if(th){llTriggerSound(Pl,ts);}
if(pN<0){pN=NX-1;}
}else if(dh=="right"){pN++;if
(th){llTriggerSound(JD,ts);}if(
pN>NX-1){pN=0;}}
if(pN<2){if(pN==0){
if(MD>=0){Ls="[ "+(string)(pN
+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String(xU,MD
)+" \n \n";aB=llList2String(xU,MD);}else
{Ls="[ "+(string)(pN+1)+" / "+
(string)NX+" ]\n \n";}Ls+=llList2String(xU,
NX-2)+"\n"+llList2String(xU,NX-1)+"\n \n"
+llList2String(xU,pN+1)+"\n"+llList2String(xU
,pN+2);PG(Ls,llList2String(xU,pN)
+"\n \n \n",1,3.0,0);}if(pN==1
){if(MD>=0){Ls="[ "+(
string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String
(xU,MD)+" \n \n";aB=llList2String(xU,MD);
}else{Ls="[ "+(string)(pN+1
)+" / "+(string)NX+" ]\n \n";}Ls+=
llList2String(xU,NX-1)+"\n"+llList2String(xU,0)
+"\n \n"+llList2String(xU,pN+1)+"\n"+llList2String
(xU,pN+2);PG(Ls,llList2String(xU,
pN)+"\n \n \n",1,3.0,0);}}else
 if(pN>NX-3){if(pN==NX-1
){if(MD>=0){Ls="[ "+(
string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String
(xU,MD)+" \n \n";aB=llList2String(xU,MD);
}else{Ls="[ "+(string)(pN+1
)+" / "+(string)NX+" ]\n \n";}Ls+=
llList2String(xU,NX-3)+"\n"+llList2String(xU,NX-
2)+"\n \n"+llList2String(xU,0)+"\n"+llList2String
(xU,1);PG(Ls,llList2String(xU,pN)
+"\n \n \n",1,3.0,0);}if(pN==NX
-2){if(MD>=0){Ls="[ "
+(string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "
+llList2String(xU,MD)+" \n \n";aB=llList2String(xU,MD
);}else{Ls="[ "+(string)(pN
+1)+" / "+(string)NX+" ]\n \n";}Ls
+=llList2String(xU,NX-4)+"\n"+llList2String(xU,
NX-3)+"\n \n"+llList2String(xU,NX-1)+
"\n"+llList2String(xU,0);PG(Ls,llList2String(
xU,pN)+"\n \n \n",1,3.0,0);}}
else{if(MD>=0){Ls="[ "+
(string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+
llList2String(xU,MD)+" \n \n";aB=llList2String(xU,MD)
;}else{Ls="[ "+(string)(pN+
1)+" / "+(string)NX+" ]\n \n";}Ls+=
llList2String(xU,pN-2)+"\n"+llList2String(xU,pN
-1)+"\n \n"+llList2String(xU,pN+1)+"\n"
+llList2String(xU,pN+2);PG(Ls,llList2String
(xU,pN)+"\n \n \n",1,3.0,0);}
}}}touch_start(integer ES){if(llDetectedKey
(0)==llGetOwner()){if(llDetectedLinkNumber(0)==
1){if(llDetectedTouchFace(0)==0){if
(YS){llLoopSound(llList2String(xU,pN),Wu);
Ls="Playing: "+llList2String(xU,pN);PG("",Ls
,1,2.0,0);MD=pN;aB=llList2String(
xU,MD);Is=1;}else{llPlaySound
(llList2String(xU,pN),Wu);Ls="Playing: "+llList2String(
xU,pN);PG("",Ls,1,2.0,0)
;MD=pN;aB=llList2String(xU,MD);Is
=1;}}if(llDetectedTouchFace(0)==1)
{llStopSound();if(MD>0){Ls=
"Stopped: "+llList2String(xU,MD);PG("",Ls,1,
2.0,0);aB="";}MD=-100;
Is=0;}}if(llDetectedLinkNumber(0)==Pb
){wW=!wW;if(wW){llSetLinkAlpha
(FV,1.0,-1);llSetLinkAlpha(lh,0.9,-1);
llSetLinkAlpha(SN,1.0,-1);llSetLinkAlpha(UX,1.0,-1
);}else{llSetLinkAlpha(FV,0,-1);
llSetLinkAlpha(lh,0,-1);llSetLinkAlpha(SN,0,-1
);llSetLinkAlpha(UX,0,-1);}}if
(llDetectedLinkNumber(0)==SN&&wW){YS=!YS;
if(YS){Ls="[Loop Mode]";PG(Ls,""
,1,1.0,0);llSetLinkPrimitiveParamsFast(SN,[17,-1,
aX,<0.4,0.9,0>,<0.25,0,0>,
0]);if(Is){llLoopSound(llList2String(xU,
MD),Wu);}}else{Ls="[Single Mode]"
;PG(Ls,"",1,1.0,0);llSetLinkPrimitiveParamsFast(
SN,[17,-1,aX,<0.4,0.9,0>,<
-0.25,0,0>,0]);if(Is)
{llPlaySound(llList2String(xU,MD),Wu);}}
}if(llDetectedLinkNumber(0)==UX&&wW){Vp
=!Vp;if(Vp){Ls="[Static Text Mode]";PG
(Ls,"",1,1.0,0);llSetLinkPrimitiveParamsFast(UX,[
17,-1,oU,<0.4,0.9,0>,<0.25,0
,0>,0]);}else{Ls="[Fading Text]"
;PG(Ls,"",1,1.0,0);llSetLinkPrimitiveParamsFast(
UX,[17,-1,oU,<0.4,0.9,0>,<
-0.25,0,0>,0]);}}if
(llDetectedLinkNumber(0)==ov){llResetTime();}
}}touch_end(integer ES){if(llDetectedKey(0
)==llGetOwner()){if(llDetectedLinkNumber(0)==ov)
{Ls="";float uG=llGetAndResetTime();if(
uG<=Qt){vector Pw=llDetectedTouchST(0);integer ra
=(integer)(Pw.x*Sn);integer Xc=(integer)
(Pw.y*HS);integer mW=(Xc*Sn)+ra
;if(mW==1){pN++;if(
th){llTriggerSound(JD,ts);}if(pN
>NX-1){pN=0;}}else
 if(mW==0){pN--;if(th)
{llTriggerSound(Pl,ts);}if(pN<0)
{pN=NX-1;}}}if(
pN<2){if(pN==0){if(
MD>=0){Ls="[ "+(string)(pN+1
)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String(xU,MD)+
" \n \n";aB=llList2String(xU,MD);}else{
Ls="[ "+(string)(pN+1)+" / "+(string
)NX+" ]\n \n";}Ls+=llList2String(xU,NX-
2)+"\n"+llList2String(xU,NX-1)+"\n \n"+
llList2String(xU,pN+1)+"\n"+llList2String(xU,pN
+2);PG(Ls,llList2String(xU,pN)+"\n \n \n"
,1,3.0,0);}if(pN==1)
{if(MD>=0){Ls="[ "+(string)
(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String(xU
,MD)+" \n \n";aB=llList2String(xU,MD);}
else{Ls="[ "+(string)(pN+1)+
" / "+(string)NX+" ]\n \n";}Ls+=llList2String(
xU,NX-1)+"\n"+llList2String(xU,0)+"\n \n"
+llList2String(xU,pN+1)+"\n"+llList2String(xU
,pN+2);PG(Ls,llList2String(xU,pN)
+"\n \n \n",1,3.0,0);}}else if(
pN>NX-3){if(pN==NX-1)
{if(MD>=0){Ls="[ "+(string)
(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String(xU
,MD)+" \n \n";aB=llList2String(xU,MD);}
else{Ls="[ "+(string)(pN+1)+
" / "+(string)NX+" ]\n \n";}Ls+=llList2String(
xU,NX-3)+"\n"+llList2String(xU,NX-2)
+"\n \n"+llList2String(xU,0)+"\n"+llList2String(xU
,1);PG(Ls,llList2String(xU,pN)+"\n \n \n"
,1,3.0,0);}if(pN==NX-2
){if(MD>=0){Ls="[ "+(
string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String
(xU,MD)+" \n \n";aB=llList2String(xU,MD);
}else{Ls="[ "+(string)(pN+1
)+" / "+(string)NX+" ]\n \n";}Ls+=
llList2String(xU,NX-4)+"\n"+llList2String(xU,NX-
3)+"\n \n"+llList2String(xU,NX-1)+"\n"+
llList2String(xU,0);PG(Ls,llList2String(xU,
pN)+"\n \n \n",1,3.0,0);}}else
{if(MD>=0){Ls="[ "+(string
)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String(
xU,MD)+" \n \n";aB=llList2String(xU,MD);
}else{Ls="[ "+(string)(pN+1)
+" / "+(string)NX+" ]\n \n";}Ls+=llList2String
(xU,pN-2)+"\n"+llList2String(xU,pN-1
)+"\n \n"+llList2String(xU,pN+1)+"\n"+
llList2String(xU,pN+2);PG(Ls,llList2String(xU
,pN)+"\n \n \n",1,3.0,0);}}
}}touch(integer ES){if(llDetectedKey(0
)==llGetOwner()){if(llDetectedLinkNumber(0)==FV&&
wW){vector vg=llDetectedTouchUV(0);if(vg==
TOUCH_INVALID_TEXCOORD){}else if(vg.x<=0.03)
{vg=<0,0,0>;Wu=0.0;
llSetLinkPrimitiveParamsFast(lh,[7,<vg.x,gQ.y,gQ.z>]
);llAdjustSoundVolume(Wu);}else if(vg.x>=0.97
){vg=<gQ.x*2,0,0>;
Wu=1.0;llSetLinkPrimitiveParamsFast(lh,[7,<vg.x,gQ.y
,gQ.z>]);llAdjustSoundVolume(Wu);}else
{Wu=vg.x;llSetLinkPrimitiveParamsFast(lh,[7,<vg.x
*(gQ.x*2),gQ.y,gQ.z>]);
llAdjustSoundVolume(Wu);}Ls="Vol: "+(string)llRound(Wu
*100)+"%";PG(Ls,"",1,1.0,0
);}if(llDetectedLinkNumber(0)==ov&&llGetTime()>=
Qt){vector Dq=llDetectedTouchUV(0);if(Dq
==TOUCH_INVALID_TEXCOORD){}else{vector Fi=llDetectedTouchUV
(0);vector IA=<(Fi.x-0.5)*2,
(Fi.y-0.5)*2,0>;float MB=llAtan2(
IA.y,IA.x)/TWO_PI*360.0;if(MB<0.0)
MB+=360.0;float LU=MB-QO;if(llFabs
(LU)>90.0)LU=0.0;QO=MB;
if(LU>0.0){if(LU>gu){
pN--;if(th){llTriggerSound(Pl,ts)
;}if(pN<0){pN=NX-1
;}}}else if(LU<0.0){
if(LU<-gu){pN++;if(th)
{llTriggerSound(JD,ts);}if(pN>NX
-1){pN=0;}}}}
if(pN<2){if(pN==0){
if(MD>=0){Ls="[ "+(string)(
pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+llList2String(xU,
MD)+" \n \n";aB=llList2String(xU,MD);}
else{Ls="[ "+(string)(pN+1)+" / "
+(string)NX+" ]\n \n";}Ls+=llList2String(xU
,NX-2)+"\n"+llList2String(xU,NX-1)+
"\n \n"+llList2String(xU,pN+1)+"\n"+llList2String(
xU,pN+2);PG(Ls,llList2String(xU,pN
)+"\n \n \n",1,3.0,0);}if(pN==
1){if(MD>=0){Ls="[ "+
(string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+
llList2String(xU,MD)+" \n \n";aB=llList2String(xU,MD)
;}else{Ls="[ "+(string)(pN+
1)+" / "+(string)NX+" ]\n \n";}Ls+=
llList2String(xU,NX-1)+"\n"+llList2String(xU,0
)+"\n \n"+llList2String(xU,pN+1)+"\n"+
llList2String(xU,pN+2);PG(Ls,llList2String(xU
,pN)+"\n \n \n",1,3.0,0);}}
else if(pN>NX-3){if(pN==NX-
1){if(MD>=0){Ls="[ "+
(string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "+
llList2String(xU,MD)+" \n \n";aB=llList2String(xU,MD)
;}else{Ls="[ "+(string)(pN+
1)+" / "+(string)NX+" ]\n \n";}Ls+=
llList2String(xU,NX-3)+"\n"+llList2String(xU,NX
-2)+"\n \n"+llList2String(xU,0)+"\n"+
llList2String(xU,1);PG(Ls,llList2String(xU,pN
)+"\n \n \n",1,3.0,0);}if(pN==
NX-2){if(MD>=0){Ls=
"[ "+(string)(pN+1)+" / "+(string)NX+
" ]\n \nPlaying: "+llList2String(xU,MD)+" \n \n";aB=llList2String(xU,
MD);}else{Ls="[ "+(string)(
pN+1)+" / "+(string)NX+" ]\n \n";}
Ls+=llList2String(xU,NX-4)+"\n"+llList2String(xU
,NX-3)+"\n \n"+llList2String(xU,NX-1)
+"\n"+llList2String(xU,0);PG(Ls,llList2String
(xU,pN)+"\n \n \n",1,3.0,0);}
}else{if(MD>=0){Ls="[ "
+(string)(pN+1)+" / "+(string)NX+" ]\n \nPlaying: "
+llList2String(xU,MD)+" \n \n";aB=llList2String(xU,MD
);}else{Ls="[ "+(string)(pN
+1)+" / "+(string)NX+" ]\n \n";}Ls
+=llList2String(xU,pN-2)+"\n"+llList2String(xU,
pN-1)+"\n \n"+llList2String(xU,pN+1)+
"\n"+llList2String(xU,pN+2);PG(Ls,
llList2String(xU,pN)+"\n \n \n",1,3.0,0);}
}}}changed(integer HI){if(
HI&8){Rv();}if(HI&
1){vN();}if(HI&32)
{llResetScript();}if(HI&128){
llResetScript();}}timer(){if
(bl){Ck=Ck-0.1;if(Ck>0
){llSetLinkPrimitiveParamsFast(ov,[26,Ls,lD,Ck])
;llSetLinkPrimitiveParamsFast(doj,[26,xP,Rg,Ck]);
llSetTimerEvent(0.05);}else{llSetLinkPrimitiveParamsFast(ov,[26
,Ls,lD,0]);llSetLinkPrimitiveParamsFast(doj,[26,xP
,Rg,0]);llSetTimerEvent(0);Ck=1.0;
if(Vp){if(MD>=0){llSetLinkPrimitiveParamsFast
(doj,[26,aB,Rg,1]);}
}}}else{Ck=Ck-0.1;if
(Ck>0){llSetLinkPrimitiveParamsFast(ov,[26,Ls,lD
,Ck]);llSetTimerEvent(0.05);}else{
llSetLinkPrimitiveParamsFast(ov,[26,Ls,lD,0]);llSetTimerEvent(
0);Ck=1.0;if(Vp){if(
MD>=0){llSetLinkPrimitiveParamsFast(ov,[26,aB,Rg,
1]);}}}}}}
