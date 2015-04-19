////////////////////////////////////////////
///////////BEGIN BASIC CONFIG///////////////
////////////////////////////////////////////

integer updatecheck = TRUE; // soft update check enable/disable. Same effect as deleting updater script, except it can be re-enabled here.

float touchtime = 0.2; // time in seconds the wheel must be held down before scrolling enables
float scrollthresh = 6.0; // smaller value here = more sensitive while scrolling.
vector baseColor = <1,1,1>; // Base/common color of the hover text.
vector selectionColor = <0,1,1>; // The color of the hover text for the selected sound.

string looptogtex = "8e8f2019-08f1-6200-7ae1-2b0875bf1161"; // textures for toggles
string texttogtex = "cd0983ca-8e1b-e47a-9047-6a47587fc231";
string pubtogtex = "01a26e4d-735f-c8d2-eab0-988fc7352a03";

integer scrollclick = TRUE; // enable/disable scrolling sounds.
float clickvol = 0.5; // the volume of the left/right clicks.
string leftclick = "249d66a9-b2cc-2f32-3673-ae251587f574"; // sounds for left/right scrolling
string rightclick = "65b7c35f-f3a6-719a-d47f-79cacc0b0b16";

integer gesturechan = 1337; // channel the script listens on for

////////////////////////////////////////////
////////////END BASIC CONFIG////////////////
////////////////////////////////////////////
// ONLY EDIT BEYOND THIS LINE IF YOU KNOW WHAT'S UP //

integer local_update; // used for communicating with the transfer script.

// Link # storage.
integer settings;
integer looptogl;
integer texttog;
integer volume;
integer volumei;
integer scroll;
integer scrolli;

// Volume stuff.
vector volbarsize;
float setvol = 1.0;

// Clicky Toggles
integer settingstog = FALSE;
integer looptog = TRUE;
integer playing = FALSE;
integer statictext = FALSE;

// List population
list sounds = [];
integer totalsounds;

// Scrolling/selection junk
integer numberOfRows    = 0;
integer numberOfColumns = 2;

integer index = 0;
integer playindex = -100;

float oldAngle;

// Hovertext stuff
float textAlpha = 1.0;
string showText = "";
string showName = "";
string staticName = "";
integer displaymode;

scaleUpdate() // Allows people to resize the player without it breaking.
{
    integer j;
    for(j = llGetNumberOfPrims(); j>=0; j--)
    {
        if("volume" == llGetLinkName(j))
        {
            volume = j;
            volbarsize = llList2Vector(llGetLinkPrimitiveParams(j,[PRIM_SIZE]),0);
        }
        if("volumei" == llGetLinkName(j))
        {
            volumei = j;
        }
        if("scroll" == llGetLinkName(j))
        {
            scroll = j;
        }
    }
    return;
}

soundUpdate() // updates the sound library
{
    if(llGetInventoryNumber(INVENTORY_SOUND) > 1)
    {
        llStopSound();
        playindex = -100;
        sounds = [];
        totalsounds = llGetInventoryNumber(INVENTORY_SOUND);
        
        integer j;
        for(j = 0; j<totalsounds; j++)
        {
            sounds = sounds + [llGetInventoryName(INVENTORY_SOUND,j)];
            llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,"[ "+(string)j+" / "+(string)totalsounds+" ] ",<1,1,1>,1]);
        }
        llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,"Sorting...",baseColor,1]);
        sounds = llListSort(sounds,1,TRUE);
        llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,"Finished!",baseColor,1]);
        showText = "Finished!";
        llSetTimerEvent(0.5);
    }
    else
    {
        llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,"No Sounds Found!",baseColor,1]);
    }
}

init() //Startup function, get link numbers and store them etc etc.
{
    integer j;
    for(j = llGetNumberOfPrims(); j>=0; j--)
    {
        if("volume" == llGetLinkName(j))
        {
            volume = j;
            volbarsize = llList2Vector(llGetLinkPrimitiveParams(j,[PRIM_SIZE]),0);
        }
        if("volumei" == llGetLinkName(j))
        {
            volumei = j;
        }
        if("scroll" == llGetLinkName(j))
        {
            scroll = j;
        }
        if("scrolli" == llGetLinkName(j))
        {
            scrolli = j;
        }
        if("settings" == llGetLinkName(j))
        {
            settings = j;
        }
        if("looptogl" == llGetLinkName(j))
        {
            looptogl = j;
        }
        if("texttog" == llGetLinkName(j))
        {
            texttog = j;
        }
    }
    showText = "Loading...";
    llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,showText,baseColor,1,PRIM_LINK_TARGET,scrolli,PRIM_TEXT,"",<1,1,1>,1]);
    
    llSetLinkTextureAnim(settings, ANIM_ON | SMOOTH | ROTATE | LOOP, ALL_SIDES,1,1,0, TWO_PI, 0.1*TWO_PI);
    
    llSetLinkPrimitiveParamsFast(volumei,[PRIM_SIZE,<volbarsize.x*2,volbarsize.y,volbarsize.z>]);
    llSetLinkPrimitiveParamsFast(LINK_ROOT,[PRIM_TEXTURE,3,"19956d80-1495-3456-9a69-d8caac73bab4",<0.4,0.9,0>,<0.25,0,0>,0]);
    llSetLinkAlpha(volume,0,ALL_SIDES);
    llSetLinkAlpha(volumei,0,ALL_SIDES);
    llSetLinkAlpha(looptogl,0,ALL_SIDES);
    llSetLinkAlpha(texttog,0,ALL_SIDES);
    
    if(looptog)
    {
        llSetLinkPrimitiveParamsFast(looptogl,[PRIM_TEXTURE,ALL_SIDES,looptogtex,<0.4,0.9,0>,<0.25,0,0>,0]);
    }
    else
    {
        llSetLinkPrimitiveParamsFast(looptogl,[PRIM_TEXTURE,ALL_SIDES,looptogtex,<0.4,0.9,0>,<-0.25,0,0>,0]);
    }
    if(statictext)
    {
        llSetLinkPrimitiveParamsFast(texttog,[PRIM_TEXTURE,ALL_SIDES,texttogtex,<0.4,0.9,0>,<0.25,0,0>,0]);
    }
    else
    {
        llSetLinkPrimitiveParamsFast(texttog,[PRIM_TEXTURE,ALL_SIDES,texttogtex,<0.4,0.9,0>,<-0.25,0,0>,0]);
    }
    llStopSound();
    
    local_update = (integer)("0xF" + llGetSubString( llGetOwner(), 0, 6) ) + 1337;
    llListen(local_update,"","","");
    llListen(gesturechan,"",llGetOwner(),"");
}

displayText(string text, string text2, integer mode, float time, integer static) // Text display
{
    if(static && statictext)
    {
        showName = text2;
        if(mode)
        {
            displaymode = TRUE;
            llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,text,baseColor,1]);
            llSetLinkPrimitiveParamsFast(scrolli,[PRIM_TEXT,text2,selectionColor,1]);
        }
        else
        {
            displaymode = FALSE;
            llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,text,baseColor,1]);
        }
    }
    else
    {
        showName = text2;
        if(mode)
        {
            displaymode = TRUE;
            llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,text,baseColor,1]);
            llSetLinkPrimitiveParamsFast(scrolli,[PRIM_TEXT,text2,selectionColor,1]);
            llSetTimerEvent(time);
        }
        else
        {
            displaymode = FALSE;
            llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,text,baseColor,1]);
            llSetTimerEvent(time);
        }
    }
}

default
{
    state_entry()
    {
        init();
        soundUpdate();
    }
    
    attach(key id)
    {
        if(updatecheck)
        {
            if(id)
            {
                llMessageLinked(LINK_THIS,0,"updatepls","");
            }
            else
            {
                llMessageLinked(LINK_THIS,0,"updatepls","");
            }
        }
    }
    
    link_message(integer sendnum, integer num, string msg, key id)
    {
        if(msg == "checking")
        {
            displayText("Checking for update...","",FALSE,0.5,FALSE);
        }
        if(msg == "allgood")
        {
            displayText("Up To Date","",FALSE,0.3,FALSE);
        }
        if(msg == "updating")
        {
            displayText("Requesting Update...","",FALSE,5.0,FALSE);
        }
        if(msg == "timeout")
        {
            displayText("Server Timeout :(((","",FALSE,0.6,FALSE);
        }
    }
    
    listen(integer ch, string n, key id, string msg)
    {
        if(ch == local_update && msg == "destinationpls")
        {
            sounds = [];
            totalsounds = 0;
            index = 0;
            playindex = -100;
            llRegionSayTo(id,local_update,(string)llGetKey());
        }
        if(ch == gesturechan)
        {
            if(msg == "playstop")
            {
                if(playindex < 0)
                {
                    if(looptog)
                    {
                        llLoopSound(llList2String(sounds,index),setvol);
                        showText = "Playing: "+llList2String(sounds,index);
                        displayText("",showText,TRUE,2.0,FALSE);
                        playindex = index;
                        staticName = llList2String(sounds,playindex);
                        playing = TRUE;
                    }
                    else
                    {
                        llPlaySound(llList2String(sounds,index),setvol);
                        showText = "Playing: "+llList2String(sounds,index);
                        displayText("",showText,TRUE,2.0,FALSE);
                        playindex = index;
                        staticName = llList2String(sounds,playindex);
                        playing = TRUE;
                    }
                }
                else
                {
                    llStopSound();
                    showText = "Stopped: "+llList2String(sounds,playindex);
                    displayText("",showText,TRUE,2.0,FALSE);
                    staticName = "";
                    playindex = -100;
                    playing = FALSE;
                }
            }
            if(msg == "left" || msg == "right")
            {
                if(msg == "left")
                {
                    index--;
                    if(scrollclick)
                    {
                        llTriggerSound(leftclick,clickvol);
                    }
                    if(index < 0)
                    {
                        index = totalsounds-1;
                    }
                }
                else if(msg == "right")
                {
                    index++;
                    if(scrollclick)
                    {
                        llTriggerSound(rightclick,clickvol);
                    }
                    if(index > totalsounds-1)
                    {
                        index = 0;
                    }
                }
                if(index < 2)
                {
                    if(index == 0)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-2)+"\n"+
                        llList2String(sounds,totalsounds-1)+"\n \n"+ // skip middle line, that goes on scrolli to allow for colored text;
                        llList2String(sounds,index+1)+"\n"+
                        llList2String(sounds,index+2);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                    if(index == 1)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-1)+"\n"+
                        llList2String(sounds,0)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,index+1)+"\n"+
                        llList2String(sounds,index+2);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                }
                else if(index > totalsounds-3)
                {
                    if(index == totalsounds-1)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-3)+"\n"+
                        llList2String(sounds,totalsounds-2)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,0)+"\n"+
                        llList2String(sounds,1);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                    if(index == totalsounds-2)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-4)+"\n"+
                        llList2String(sounds,totalsounds-3)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,totalsounds-1)+"\n"+
                        llList2String(sounds,0);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                }
                else
                {
                    if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,index-2)+"\n"+
                    llList2String(sounds,index-1)+"\n \n"+ // skip middle line, that goes on scrolli;
                    llList2String(sounds,index+1)+"\n"+
                    llList2String(sounds,index+2);

                    displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                }
            }
        }
    }
    
    touch_start(integer num)
    {
        if(llDetectedKey(0) == llGetOwner())
        {
            if(llDetectedLinkNumber(0) == LINK_ROOT)
            {
                if(llDetectedTouchFace(0) == 0)
                {
                    if(looptog)
                    {
                        llLoopSound(llList2String(sounds,index),setvol);
                        showText = "Playing: "+llList2String(sounds,index);
                        displayText("",showText,TRUE,2.0,FALSE);
                        playindex = index;
                        staticName = llList2String(sounds,playindex);
                        playing = TRUE;
                    }
                    else
                    {
                        llPlaySound(llList2String(sounds,index),setvol);
                        showText = "Playing: "+llList2String(sounds,index);
                        displayText("",showText,TRUE,2.0,FALSE);
                        playindex = index;
                        staticName = llList2String(sounds,playindex);
                        playing = TRUE;
                    }
                }
                if(llDetectedTouchFace(0) == 1)
                {
                    llStopSound();
                    if(playindex > 0)
                    {
                        showText = "Stopped: "+llList2String(sounds,playindex);
                        displayText("",showText,TRUE,2.0,FALSE);
                        staticName = "";
                    }
                    playindex = -100;
                    playing = FALSE;
                }
            }
            if(llDetectedLinkNumber(0) == settings)
            {
                settingstog=!settingstog;
                if(settingstog)
                {
                    llSetLinkAlpha(volume,1.0,ALL_SIDES);
                    llSetLinkAlpha(volumei,0.9,ALL_SIDES);
                    llSetLinkAlpha(looptogl,1.0,ALL_SIDES);
                    llSetLinkAlpha(texttog,1.0,ALL_SIDES);
                }
                else
                {
                    llSetLinkAlpha(volume,0,ALL_SIDES);
                    llSetLinkAlpha(volumei,0,ALL_SIDES);
                    llSetLinkAlpha(looptogl,0,ALL_SIDES);
                    llSetLinkAlpha(texttog,0,ALL_SIDES);
                }
            }
            if(llDetectedLinkNumber(0) == looptogl && settingstog)
            {
                looptog=!looptog;
                if(looptog)
                {
                    showText = "[Loop Mode]";
                    displayText(showText,"",TRUE,1.0,FALSE);
                    llSetLinkPrimitiveParamsFast(looptogl,[PRIM_TEXTURE,ALL_SIDES,looptogtex,<0.4,0.9,0>,<0.25,0,0>,0]);
                    if(playing)
                    {
                        llLoopSound(llList2String(sounds,playindex),setvol);
                    }
                }
                else
                {
                    showText = "[Single Mode]";
                    displayText(showText,"",TRUE,1.0,FALSE);
                    llSetLinkPrimitiveParamsFast(looptogl,[PRIM_TEXTURE,ALL_SIDES,looptogtex,<0.4,0.9,0>,<-0.25,0,0>,0]);
                    if(playing)
                    {
                        llPlaySound(llList2String(sounds,playindex),setvol);
                    }
                }
            }
            if(llDetectedLinkNumber(0) == texttog && settingstog)
            {
                statictext=!statictext;
                if(statictext)
                {
                    showText = "[Static Text Mode]";
                    displayText(showText,"",TRUE,1.0,FALSE);
                    llSetLinkPrimitiveParamsFast(texttog,[PRIM_TEXTURE,ALL_SIDES,texttogtex,<0.4,0.9,0>,<0.25,0,0>,0]);
                }
                else
                {
                    showText = "[Fading Text]";
                    displayText(showText,"",TRUE,1.0,FALSE);
                    llSetLinkPrimitiveParamsFast(texttog,[PRIM_TEXTURE,ALL_SIDES,texttogtex,<0.4,0.9,0>,<-0.25,0,0>,0]);
                }
            }
            if(llDetectedLinkNumber(0) == scroll)
            {
                llResetTime();      
            }
        }
    }
    
    touch_end(integer num)
    {
        if(llDetectedKey(0) == llGetOwner())
        {
            if(llDetectedLinkNumber(0) == scroll)
            {
                showText = "";
                float temp = llGetAndResetTime();
                if(temp <= touchtime)
                {
                    vector  touchST     = llDetectedTouchST(0);
                    integer columnIndex = (integer) (touchST.x * numberOfColumns);
                    integer rowIndex    = (integer) (touchST.y * numberOfRows);
                    integer cellIndex   = (rowIndex * numberOfColumns) + columnIndex;
 
                    if(cellIndex == 1)
                    {
                        index++;
                        if(scrollclick)
                        {
                            llTriggerSound(rightclick,clickvol);
                        }
                        if(index > totalsounds-1)
                        {
                            index = 0;
                        }
                    }
                    else if(cellIndex == 0)
                    {
                        index--;
                        if(scrollclick)
                        {
                            llTriggerSound(leftclick,clickvol);
                        }
                        if(index < 0)
                        {
                            index = totalsounds-1;
                        }
                    }
                }
                if(index < 2)
                {
                    if(index == 0)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-2)+"\n"+
                        llList2String(sounds,totalsounds-1)+"\n \n"+ // skip middle line, that goes on scrolli to allow for colored text;
                        llList2String(sounds,index+1)+"\n"+
                        llList2String(sounds,index+2);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                    if(index == 1)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-1)+"\n"+
                        llList2String(sounds,0)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,index+1)+"\n"+
                        llList2String(sounds,index+2);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                }
                else if(index > totalsounds-3)
                {
                    if(index == totalsounds-1)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-3)+"\n"+
                        llList2String(sounds,totalsounds-2)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,0)+"\n"+
                        llList2String(sounds,1);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                    if(index == totalsounds-2)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-4)+"\n"+
                        llList2String(sounds,totalsounds-3)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,totalsounds-1)+"\n"+
                        llList2String(sounds,0);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                }
                else
                {
                    if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,index-2)+"\n"+
                    llList2String(sounds,index-1)+"\n \n"+ // skip middle line, that goes on scrolli;
                    llList2String(sounds,index+1)+"\n"+
                    llList2String(sounds,index+2);

                    displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                }
            }
        }
    }

    touch(integer num)
    {
        if(llDetectedKey(0) == llGetOwner())
        {
            if(llDetectedLinkNumber(0) == volume && settingstog)
            {
                vector temp = llDetectedTouchUV(0);
                if(temp == TOUCH_INVALID_TEXCOORD)
                {
                    // Nothing! We moved off the face.
                }
                else if(temp.x <= 0.03)
                {
                    temp = <0,0,0>;
                    setvol = 0.0;
                    llSetLinkPrimitiveParamsFast(volumei,[PRIM_SIZE,<temp.x,volbarsize.y,volbarsize.z>]);
                    llAdjustSoundVolume(setvol);
                }
                else if(temp.x >= 0.97)
                {
                    temp = <volbarsize.x*2,0,0>;
                    setvol = 1.0;
                    llSetLinkPrimitiveParamsFast(volumei,[PRIM_SIZE,<temp.x,volbarsize.y,volbarsize.z>]);
                    llAdjustSoundVolume(setvol);
                }
                else
                {
                    setvol = temp.x;
                    llSetLinkPrimitiveParamsFast(volumei,[PRIM_SIZE,<temp.x*(volbarsize.x*2),volbarsize.y,volbarsize.z>]);
                    llAdjustSoundVolume(setvol);
                }
                showText = "Vol: "+(string)llRound(setvol*100)+"%";
                displayText(showText,"",TRUE,1.0,FALSE);
            }
            if(llDetectedLinkNumber(0) == scroll && llGetTime() >= touchtime)
            {
                vector temp = llDetectedTouchUV(0);
                
                if(temp == TOUCH_INVALID_TEXCOORD)
                {
                    // Nothing! We moved off the face.
                }
                else
                {
                    vector touchUv = llDetectedTouchUV(0);
                    
                    vector touchUvNormalized=<(touchUv.x-0.5)*2,(touchUv.y-0.5)*2,0>;
                    float angle=llAtan2(touchUvNormalized.y,touchUvNormalized.x)/TWO_PI*360.0;
                    if(angle<0.0)angle+=360.0;
                    
                    float spinningDir=angle-oldAngle;
                    
                    if(llFabs(spinningDir)>90.0)spinningDir=0.0f;
                    
                    oldAngle=angle;
                    
                    if(spinningDir > 0.0)
                    {
                        if(spinningDir > scrollthresh)
                        {
                            index--;
                            if(scrollclick)
                            {
                                llTriggerSound(leftclick,clickvol);
                            }
                            if(index < 0)
                            {
                                index = totalsounds-1;
                            }
                        }
                    }
                    else if(spinningDir < 0.0)
                    {
                        if(spinningDir < -scrollthresh)
                        {
                            index++;
                            if(scrollclick)
                            {
                                llTriggerSound(rightclick,clickvol);
                            }
                            if(index > totalsounds-1)
                            {
                                index = 0;
                            }
                        }
                    }
                }
                if(index < 2)
                {
                    if(index == 0)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-2)+"\n"+
                        llList2String(sounds,totalsounds-1)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,index+1)+"\n"+
                        llList2String(sounds,index+2);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                    if(index == 1)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-1)+"\n"+
                        llList2String(sounds,0)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,index+1)+"\n"+
                        llList2String(sounds,index+2);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                }
                else if(index > totalsounds-3)
                {
                    if(index == totalsounds-1)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-3)+"\n"+
                        llList2String(sounds,totalsounds-2)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,0)+"\n"+
                        llList2String(sounds,1);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                    if(index == totalsounds-2)
                    {
                        if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,totalsounds-4)+"\n"+
                        llList2String(sounds,totalsounds-3)+"\n \n"+ // skip middle line, that goes on scrolli;
                        llList2String(sounds,totalsounds-1)+"\n"+
                        llList2String(sounds,0);
                        
                        displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                    }
                }
                else
                {
                    if(playindex >= 0)
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \nPlaying: "+llList2String(sounds,playindex)+" \n \n";
                            staticName = llList2String(sounds,playindex);
                        }
                        else
                        {
                            showText = "[ "+(string)(index+1)+" / "+(string)totalsounds+" ]\n \n";
                        }

                        showText += 
                        llList2String(sounds,index-2)+"\n"+
                    llList2String(sounds,index-1)+"\n \n"+ // skip middle line, that goes on scrolli;
                    llList2String(sounds,index+1)+"\n"+
                    llList2String(sounds,index+2);
                    
                    displayText(showText,llList2String(sounds,index)+"\n \n \n",TRUE,3.0,FALSE);
                }
            }
        }
    }
    
    changed(integer change)
    {
        if(change & CHANGED_SCALE)
        {
            scaleUpdate();
        }
        if(change & CHANGED_INVENTORY)
        {
            soundUpdate();
        }
        if(change & CHANGED_LINK)
        {
            llResetScript();
        }
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
    
    timer()
    {
        if(displaymode)
        {
            textAlpha = textAlpha - 0.1;
            if(textAlpha > 0)
            {
                llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,showText,baseColor,textAlpha]);
                llSetLinkPrimitiveParamsFast(scrolli,[PRIM_TEXT,showName,selectionColor,textAlpha]);
                llSetTimerEvent(0.05);
            }
            else
            {
                llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,showText,baseColor,0]);
                llSetLinkPrimitiveParamsFast(scrolli,[PRIM_TEXT,showName,selectionColor,0]);
                llSetTimerEvent(0);
                textAlpha = 1.0;
                if(statictext)
                {
                    if(playindex >= 0)
                    {
                        llSetLinkPrimitiveParamsFast(scrolli,[PRIM_TEXT,staticName,selectionColor,1]);
                    }

                }
            }
        }
        else
        {
            textAlpha = textAlpha - 0.1;
            if(textAlpha > 0)
            {
                llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,showText,baseColor,textAlpha]);
                llSetTimerEvent(0.05);
            }
            else
            {
                llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,showText,baseColor,0]);
                llSetTimerEvent(0);
                textAlpha = 1.0;
                if(statictext)
                {
                    if(playindex >= 0)
                    {
                        llSetLinkPrimitiveParamsFast(scroll,[PRIM_TEXT,staticName,selectionColor,1]);
                    }

                }
            }
        }
    }
}