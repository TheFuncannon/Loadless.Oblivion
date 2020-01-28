state("Oblivion")
{
    // TES 4: Oblivion, unknown version
}

state("Oblivion", "1.0")
{
    // TES 4: Oblivion, original version
    // version 1.0.228
    // size 7704576
    bool isLoadingScreen: "Oblivion.exe", 0x6BE428;
    bool mainMenu: "Oblivion.exe", 0x6E63E8;
    bool mainMenu2: "Oblivion.exe", 0x74F594;
    bool quitOuts: "Oblivion.exe", 0x6D6F88;
    bool isWaiting:"Oblivion.exe", 0x6BE410;

}

state("Oblivion", "1.2")
{
    // TES 4: Oblivion, steam version
    // version 1.2.0416
    // size 8409088

    // Puri's vars
    // bool isLoadingScreen : 0x3CD4B0, 0x8, 0xEC;
    // byte isWaiting : 0x172DCC, 0x10;
    // byte startingPrompt : 0x73BD60, 0x48, 0xC8, 0xB8, 0xDC;

    // TFC's vars
    // bool isLoadingScreen : 0x742D54;
    // bool notTalking : 0x72D91C;
    // bool notPaused : 0x73341C;
    // bool isWaiting : 0x712DE0;

    // FDH's vars
    int isLoadingScreen : 0x00738C9C, 0x28C;
    bool isWaiting : 0x712DE0;
}

init
{
    version = modules.First().FileVersionInfo.FileVersion;
    if (version == "1.0.228") {
        version = "1.0";
    } else if (version == "1.2.0416") {
        version = "1.2";
    } else {
        version = "";
    }

    vars.prevPhase = timer.CurrentPhase;
    vars.isLoading = false;
    vars.dontLoad = false;
    vars.mapTravel = false;
    vars.guardWarp = false;
    vars.guardWarp2 = false;
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    if (version == "") {
        // unsupported version
        return;
    }

    if (timer.CurrentPhase == TimerPhase.Running && vars.prevPhase == TimerPhase.NotRunning) {
        vars.dontLoad = false;
        vars.mapTravel = false;
        vars.guardWarp = false;
        vars.guardWarp2 = false;
    }

    if (version == "1.0") {
        vars.isLoading = (current.isLoadingScreen || current.quitOuts || (current.mainMenu && current.mainMenu2)) || current.isWaiting;     
        
    } else {
        // for FromDarkHell's vars
        vars.isLoading = current.isLoadingScreen == 3 || current.isWaiting == true;
        
        // for Puri's vars
        // vars.isLoading = current.isLoadingScreen || current.isWaiting != 0;

        // for TFC's vars
        // if (current.isLoadingScreen && !current.notTalking) {
        //     vars.dontLoad = true;
        //     vars.mapTravel = false;
        // }
        // if (current.isLoadingScreen && !current.notPaused && vars.dontLoad && current.notTalking) {
        //     vars.mapTravel = true;
        // }
        // if (vars.mapTravel && !current.notPaused && !current.isLoadingScreen || (current.notTalking && !current.isLoadingScreen)) {
        //     vars.dontLoad = false;
        // }
        // if (!current.isLoadingScreen && current.notPaused) {
        //     vars.dontLoad = false;
        // }
    }

    vars.prevPhase = timer.CurrentPhase;
}

isLoading
{
    return vars.isLoading;
}
