#!/bin/bash

JDK_file_path=$1;
JDK_HOME="/usr/lib/jvm"

echo "STRAT TO INSTALL JDK_VERSION_7 AUTOMATIC!"

echo "------------------------------------------------------"
echo "JDK_FILE_ADDRESS IS $JDK_file_path"

#### TEST THE USER##################

userinfo=`whoami`

if [ "$userinfo" != "root" ]; then
    echo " $userinfo Please run this script with root user, Thanks!"
	exit
fi

#### TEST JDK FILE EXSITS OR NOT ############
if test  -e $JDK_file_path  
then 
	echo "the file is exist!" 
else 
	echo "the file is not exist!" 
	exit
fi

###### ROOT USER AND FILE IS READY , NOW START TO INSTALL JDK ########################
echo "Now,you run this scrip with ROOT"

####CREATE JVM DOCUMENT THEN DEFAUL PATH IS /usr/liv/jvm ###########
if test -e $JDK_HOME 
then 
	echo "JDK HOME path exsits, do you want to install JDK on this path --- /usr/lib/jvm ? (YES/NO)"
	read answer
	if test $answer = "NO"
		then 
			echo "Install JDK failed, because of you choose option that don't install JDK on the exsist directory ($JDK_HOME)"
			exit
    fi
else 
	`mkdir $JDK_HOME`
	echo "JDK HOME document is created !" 
fi

####UNZIP JDK TRA FILE and then move to JDK_HOME ，rename to java ###########

tar -zxvf $JDK_file_path -C $JDK_HOME

cd $JDK_HOME

directory_name=$( ls )

mv $JDK_HOME/${directory_name} $JDK_HOME/java

echo "CHAGE THE USER OF FILE TO ROOT"

chown root:root -R $JDK_HOME/java

###SETUP JAVA ENVIREMENT#######

echo "Start to setup java enviroment!"

echo "export JAVA_HOME=${JDK_HOME}/java" >> /etc/profile
echo "export JRE_HOME=\${JAVA_HOME}/jre" >> /etc/profile
echo "export CLASSPATH=.:\${JAVA_HOME}/lib:\${JRE_HOME}/lib" >> /etc/profile
echo "export JRE_HOME=\${JAVA_HOME}/jre" >> /etc/profile
echo "export PATH=\${JAVA_HOME}/bin:\$PATH" >> /etc/profile

source /etc/profile

sudo update-alternatives --install /usr/bin/java java $JDK_HOME/java/bin/java 300  
sudo update-alternatives --install /usr/bin/javac javac $JDK_HOME/java/bin/javac 300  
sudo update-alternatives --install /usr/bin/jar jar $JDK_HOME/java/bin/jar 300   
sudo update-alternatives --install /usr/bin/javah javah $JDK_HOME/java/bin/javah 300   
sudo update-alternatives --install /usr/bin/javap javap $JDK_HOME/java/bin/javap 300

sudo update-alternatives --config java 

java -version

echo "JDK INSTALLATION DONE !"









