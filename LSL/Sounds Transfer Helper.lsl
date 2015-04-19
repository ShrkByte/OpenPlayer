// INSTRUCTIONS: place this script inside any object that contains sounds. Be sure that if the object you place the script inside also has scripts, that they don't use click/touch events. If they do, either remove or disable the scripts.




integer local_update;
list library = [];
key sendto = NULL_KEY;

init()
{
    local_update = (integer)("0xF" + llGetSubString( llGetOwner(), 0, 6) ) + 1337;
    llListen(local_update,"","","");
}

default
{
    state_entry()
    {
        init();
        llOwnerSay("Rez out the replacement player and click me to continue.\n \n NOTE: If you are putting this transfer script into an older player, delete any other scripts that might take control of clicking.");
    }
    
    on_rez(integer start)
    {
        llOwnerSay("Rez out the replacement player and click me to continue.\n \n NOTE: If you are putting this transfer script into an older player, delete any other scripts that might take control of clicking.");
    }
    
    touch_start(integer num)
    {
        if(llDetectedKey(0) == llGetOwner())
        {
            llRegionSay(local_update,"destinationpls");
        }
    }
    
    listen(integer ch, string n, key id, string msg)
    {
        sendto = msg;
        
        if(llGetInventoryNumber(INVENTORY_SOUND) > 1)
        {
            integer totalsounds = llGetInventoryNumber(INVENTORY_SOUND);
            
            integer j;
            for(j = 0; j<totalsounds; j++)
            {
                library = library + [llGetInventoryName(INVENTORY_SOUND,j)];
            }
            llOwnerSay("transferring "+(string)totalsounds+" sounds...");
            for(j = 0; j<totalsounds; j++)
            {
                llGiveInventory(sendto,llList2String(library,j));
            }
            llOwnerSay("Done. If you had a lot of sounds, it might take a little while for everything to sync back up. Be patient.");
        }
        else
        {
            llOwnerSay("You need to place more than 1 sounds in this object before a transfer can be made.");
        }
    }
    
    changed(integer change)
    {
        if(change & CHANGED_OWNER)
        {
            llResetScript();
        }
    }
}
