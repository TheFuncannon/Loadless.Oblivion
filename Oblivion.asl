state("Oblivion")
{
	bool isLoading : "Oblivion.exe", 0x074F594;
	bool notTalking : "Oblivion.exe", 0x06D25A0;
	bool gamePaused : "Oblivion.exe", 0x07480BC;
	bool midSpeech : "Oblivion.exe", 0x06E4C08;
	bool isWaiting : "Oblivion.exe", 0x6BE410;
	uint spiesScroll : "Oblivion.exe", 0x6EA094;
}
start
{
	current.dontLoad = 0;
	current.mapTravel = 0;
}
isLoading
{
	bool b = (current.isLoading && current.notTalking && current.dontLoad == 0) || current.isWaiting;
	if (current.spiesScroll == 1)
	{
		current.dontLoad = 1;
	}
	if (current.midSpeech)
	{	
		current.dontLoad = 1;
		current.mapTravel = 0;
	}
	if (current.isLoading && current.gamePaused && current.dontLoad == 1)
	{
		current.mapTravel = 1;
	}
	if (current.mapTravel == 1 && current.gamePaused && !current.isLoading)
	{
		current.dontLoad = 0;
	}
	if (!current.isLoading && !current.gamePaused)
	{
		current.dontLoad = 0;
	}
	return b;
}
