#!/bin/bash

function successLog() {
	if [ $? == 0 ]
	then
		echo "installUnreal.sh: $1";
	else
		echo "installUnreal.sh: $2";
		exit;
	fi
}

function successCheck() {
if [ $? -eq 1 ]; then
	$@;
fi
}

echo "This command will download and install unreal. Are you in the parent directory where you would like the UnrealEngine directory to be set up?(Y/n)";
read goAhead
if [ goAhead == "n" ]
then
	exit
fi

echo "What version of UE4 should be installed? (version number only)";
read versionNumber;

dpkg -s git &> /dev/null;
successCheck 'sudo apt-get install -y git';

dpkg -s build-essential &> /dev/null;                                                                                                     
successCheck 'sudo apt-get install -y build-essential'; 

dpkg -s mono &> /dev/null;                                                                                                                
successCheck 'sudo apt-get install -y mono';

git clone git@github.com:EpicGames/UnrealEngine.git;
successLog "Git Clone Success" "Git Clone Fail"

git checkout origin/$versionNumber;
successLog "Git Checkout Success" "Git Checkout Fail"

cd ./UnrealEngine/;

./GenerateProjectFiles.sh;
successLog "GenerateProjectFiles.sh Success" "GenerateProjectFiles.sh Failed";

./Setup.sh;
successLog "Setup.sh Success" "Setup.sh Failed";

make;
successLog "Make Success" "Make Failed";
