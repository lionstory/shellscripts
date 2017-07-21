#!/bin/bash

Maven_file_path=$1;
Maven_Home=$2;

userinfo=`whoami`;
if ["$userinfo" != "root"]; then 
		echo "$userinfo Please run this script with root user!"
		exit
fi

if test -e $Maven_file_path 
	then
		echo "the file is exist"
else
	  echo "the file is not exit"
		exit
fi

if test -e $Maven_Home
	then 
		echo "Mave_Home path exsits,do you want install Maven on this path ---$Mave_file_path?(YES/NO)"
		read answer
		if test $answer = "NO"
		then 
			exit
		fi
else
	 mkdir $Maven_Home
fi
tar -zxvf $Maven_file_path -C $Maven_Home

cd $Maven_Home

directory_name=$( ls )

cp -rf $Maven_Home/${directory_name}/* $Maven_Home

rm -rf $Maven_Home/${directory_name}

cd /bin

ln -s $Maven_Home/bin/mvn mvn


echo "export M2_HOME=${Maven_Home}">> /etc/profile
echo "export PATH=\${M2_HOME}/bin:\$PATH" >> /etc/profile

source /etc/profile

echo $PATH



