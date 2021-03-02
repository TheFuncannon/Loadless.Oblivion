  
state("Oblivion")
{
    // TES 4: Oblivion, unknown version
}

state("Oblivion", "1.0.228")
{
    // Version 1.0.228, Size 7704576
    int isLoadingScreen : "Oblivion.exe", 0x006E4F00, 0x58, 0x114, 0x114, 0x114, 0x04;
    bool quickLoad      : "Oblivion.exe", 0x6BE428;
    bool isWaiting      : "Oblivion.exe", 0x6BE410;
}

state("Oblivion", "1.1.425")
{
    // See: https://en.uesp.net/wiki/Oblivion:Patch#Version_1.1.425_.28Beta.29
    int isLoadingScreen : "Oblivion.exe", 0x006EABB0, 0x188, 0x2C, 0x4;
    bool quickLoad      : "Oblivion.exe", 0x6D3A18;
    bool isWaiting      : "Oblivion.exe", 0x6D3A00;
}


state("Oblivion", "1.2.0416")
{
    // TES 4: Oblivion, 1.2.0416
    // Version 1.2.0416, Size 8409088

    int isLoadingScreen : 0x00738C9C, 0x28C;
    bool quickLoad : 0x712DF8;
    bool isWaiting : 0x712DE0;
}

init
{
    timer.IsGameTimePaused = false; // You need to do this in order to unpause the timer if the game closes mid-run

    version = modules.First().FileVersionInfo.ProductVersion;

    vars.isLoading = false;
}

exit
{
    timer.IsGameTimePaused = true;
}

update
{
    if (version == "") 
        return; // Unknown reversion

    vars.isLoading = (current.isLoadingScreen == 3 || current.isWaiting || current.quickLoad);
}

isLoading
{
    return vars.isLoading;
}

