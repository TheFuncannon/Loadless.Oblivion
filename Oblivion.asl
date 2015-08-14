state("Oblivion")
{
	bool isLoading : "Oblivion.exe", 0x074F594;
	bool notTalking : "Oblivion.exe", 0x06D25A0;
	bool gamePaused : "Oblivion.exe", 0x07480BC;
	bool midSpeech : "Oblivion.exe", 0x06E4C08;
	bool isWaiting : "Oblivion.exe", 0x6BE410;
	uint spiesScroll : "Oblivion.exe", 0x6EA094;
	uint spiesScroll2 : "Oblivion.exe", 0x6DB898;
}
start
{
	current.dontLoad = 0;
	current.mapTravel = 0;
	current.guardWarp = 0;
	current.guardWarp2 = 0;
}
isLoading
{
	bool b = (current.isLoading && current.notTalking && current.dontLoad == 0) || current.isWaiting;
	if (current.midSpeech)
	{	
		current.dontLoad = 1;
		current.mapTravel = 0;
		current.guardWarp2 = 0;

	}
	if (current.isLoading && current.gamePaused && current.dontLoad == 1)
	{
		current.mapTravel = 1;
		current.guardWarp = 1;
	}
	if ((!current.isLoading && !current.gamePaused) || (current.gamePaused && !current.isLoading && current.mapTravel == 1))
	{
		current.dontLoad = 0;
		current.guardWarp = 0;
	}
	if (current.guardWarp == 1 && !current.gamePaused)
	{
		current.guardWarp2 = 1;
	}
	if (current.guardWarp2 == 1 && current.isLoading && current.gamePaused)
	{
		current.dontLoad = 0;
	}
	return b;
}
