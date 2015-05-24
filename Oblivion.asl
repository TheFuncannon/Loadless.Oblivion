state("Oblivion")
{
	bool isLoading : "Oblivion.exe", 0x074F594;
	bool notTalking : "Oblivion.exe", 0x06D25A0;
	bool gamePaused : "Oblivion.exe", 0x07480BC;
	bool midSpeech : "Oblivion.exe", 0x06E4C08;
}
start
{
	current.dontLoad = 0;
	current.mapTravel = 0;
}
isLoading
{
	
	if (current.midSpeech)
	{	
		current.dontLoad = 1;
		current.mapTravel = 0;
	}
	if (current.notTalking && current.dontLoad == 0)
	{
		return current.isLoading;
	}
	if (current.isLoading && current.gamePaused && current.dontLoad == 1)
	{
		current.mapTravel = 1;
	}
	if (current.mapTravel == 1 && current.gamePaused && !current.isLoading)
	{
		current.dontLoad = 0;
		current.resetLoad = 0;
	}
	if (!current.isLoading && !current.gamePaused)
	{
		current.dontLoad = 0;
	}
}
