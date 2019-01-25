#! /bin/bash

FILE_NAME=airtel
EXE_FILE="airtel"
DISPLAY_NAME="airtel"
SYS_PATH=/opt
INSTALL_PATH=$SYS_PATH/$FILE_NAME
#LANGUAGE=English
#QM_NAME=ondatim_lan.qm
#HELP=help
#RUN_EVINCE=$SYS_PATH/$FILE_NAME/Data/launchFirefox.sh
UPDATE_FILE=CMUpdater
QT_LIBRARY_DIR=/usr/local/qt_lib
#TAR_PACKAGE_PATH=`pwd`

#Define variable-two-phrase-production---begin---------
TWO_ON=true   # true or false
PATH_NAME=`dirname $0`
TMP_DIR_NAME=/tmp
TWO_FRASE_TEMP_DIR=$TMP_DIR_NAME/two_phase_temp
TWO_FRASE_CONFIG_FILE_MODEM=/PCCFG/Description.xml
DES_DIR=$INSTALL_PATH
ZIP_FILE_NAME=$TWO_FRASE_TEMP_DIR/lu.zip
TEMP_DIR=$TWO_FRASE_TEMP_DIR/temp
LAST_RUN=$INSTALL_PATH/last_run.sh
CHOOSE_LANGUAGE_RUN=$TEMP_DIR/choose_language.sh
#Define variable-two-phrase-production---end------------

# function defination begin

function get_distro_name {
    ISSUE_NAME="/etc/issue"
    DIS_NAME="other"
    if [ -e $ISSUE_NAME -a -f $ISSUE_NAME ]; then
        if [ "$(grep "Ubuntu" $ISSUE_NAME)" ]; then
            DIS_NAME="Ubuntu"
        elif [ "$(grep 'SUSE' $ISSUE_NAME)" ]; then
            DIS_NAME="OpenSUSE"
        elif [ "$(grep "Fedora" $ISSUE_NAME)" ]; then
            DIS_NAME="Fedora"
        elif [ "$(grep "Mandriva" $ISSUE_NAME)" ]; then
            DIS_NAME="Mandriva"
        fi
    fi
    echo $DIS_NAME
}

function getFC17
{
	ISSUE_NAME_1="/etc/issue"
    DIS_NAME_1="other"
	if [ -e $ISSUE_NAME_1 -a -f $ISSUE_NAME_1 ]; then
		if [ "$(grep "Fedora\ release\ 17" $ISSUE_NAME_1)" ]; then
			DIS_NAME_1="Fedora release 17"
		fi
	fi
	echo $DIS_NAME_1
}

function assert_software_installed
{
    if [ -f $INSTALL_PATH/$FILE_NAME ]; then
        echo "****** Fail to install !!! "
        echo the "$DISPLAY_NAME" has been installed.
        read -p "press any key to exit.... " -n 1
        exit -1
	else
		echo "..................start install................."
    fi
}

function assert_root_privilege
{
    echo -n "*** Check for root..."
    if [ $EUID -ne 0 ]; then
        echo -e "\b\b\b - failed"
        echo "*** Please retry as root user."
        read -p "press any key to exit.... " -n 1
        exit -1
	else
		echo "ok..."
    fi
}

function mymessagebox 
{
    MSG_CMD_GNOME="/usr/bin/zenity"
    MSG_CMD_KDE="kdialog"
    if [  -e $MSG_CMD_GNOME -a -f $MSG_CMD_GNOME ];then
        $MSG_CMD_GNOME --error --title="$1" --text="$2" 2>/dev/null
    else
        $MSG_CMD_KDE --error "$2" 2>/dev/null
    fi
    echo -e "\n$2\n"
    read temp
}

function check_wvdial
{
    WVDIAL="/usr/bin/wvdial"
    if [ -e $WVDIAL -a -f $WVDIAL ];then
        echo "check wvdial successfully."
    else
        mymessagebox "Sorry" "This software depends on \"wvdial\" to establish internet connection. You should install \"wvdial\" first.You can refer to Operating System installation CD or Homepage to find the \"wvdial\" installation package. This installation process will not continue until you install \"wvdial\"."
	exit -1
    fi
}

function check_qt3
{
    QT3LIB=$(find /usr/lib -name "libqt-mt.so*")
    echo $QT3LIB
    if [ "$QT3LIB" ];then
        echo "check QT3 Runtime Library successfully."
    else
	mymessagebox "Sorry" "This software will not run until you install \"QT3 Runtime Library\". You can refer to Operaing System installation CD or Homepage to find out the QT3 Runtime Library installation package. This installation process will not continue until you install QT3 Runtime Library first."
        exit -1
    fi
}

function select_language
{
    echo >/dev/null
    #Select the language for the installation form the choices below.
    #      (1) English 
    #      (2) Italian
    #      (3) Spanish
    #      (4) Simplified Chinese
    #      (5) Traditional Chinese "
    #echo "Please input number (1,2,3,4 or 5):" 
    #read S_NUMBER
    #
    #if [ $S_NUMBER == "1" ];then
    #   LANGUAGE=English
    #elif [ $S_NUMBER == "2" ];then
    #   LANGUAGE=Italian
    #elif [ $S_NUMBER == "3" ];then
    #   LANGUAGE=Spanish
    #elif [ $S_NUMBER == "4" ];then
    #   LANGUAGE=Simplified_Chinese
    #elif [ $S_NUMBER == "5" ];then
    #   LANGUAGE=Traditional_Chinese
    #else
    #   LANGUAGE=English
    #fi
}

function two_phrase_production_state1
{
    rettfp=3
    if [ $TWO_ON == 'true' ];then
        if [ -d $TWO_FRASE_TEMP_DIR ]; then
                rm -rf $TWO_FRASE_TEMP_DIR
        fi
        mkdir -p $TWO_FRASE_TEMP_DIR
            
            if [ -f $PATH_NAME/zr ];then
            chmod +x $PATH_NAME/zr
                $PATH_NAME/zr $TWO_FRASE_CONFIG_FILE_MODEM $TWO_FRASE_TEMP_DIR
                rettfp=$? 
            fi

        if [ $rettfp == '5' -o $rettfp == '6' -o $rettfp == '7' ];then
                echo -e "Stage 5"
            #   echo -e "Can not complete the installation. Installation will abort."
            #   echo -e "Please try to install again."
            #       read temp_1
            #   exit -1
        elif [  $rettfp == '3'  -o  $rettfp == '4'  ];then
                echo -e "Stage 3"
        else
                echo -e "Get resouse file successfully."
        fi

    fi
}

function delete_previous_file
{
    #delete first
    if [ -f $INSTALL_PATH/$FILE_NAME ];then
        rm -rf $INSTALL_PATH
        rm -f /bin/$FILE_NAME
    fi

#    if [ -f $INSTALL_PATH/$EXE_FILE_IN_BIN ];then
#        rm -rf $INSTALL_PATH
#        rm -f /bin/$EXE_FILE_IN_BIN
#   fi
#canceled by ww
#    TMP_FILE=/etc/defaultwvdial.conf
#     if [ -f $TMP_FILE ];then
#        rm -f $TMP_FILE
#        echo ..........delete $TMP_FILE ok...........
#   fi
#
#    TMP_FILE=/etc/ppp/defaultoptions
#    if [ -f $TMP_FILE ];then
#        rm -f $TMP_FILE
#        echo ..........delete $TMP_FILE ok...........
#    fi
#
#    TMP_FILE=/etc/ppp/defaultresolv.conf
#    if [ -f $TMP_FILE ];then
#        rm -f $TMP_FILE
#        echo ..........delete $TMP_FILE ok...........
#    fi
#
#    TMP_FILE=/etc/defaultresolv.conf
#    if [ -f $TMP_FILE ];then
#        rm -f $TMP_FILE
#          echo ..........delete $TMP_FILE ok...........
#    fi

    TMP_FILE=/usr/share/applications/$FILE_NAME*.desktop
    if [ -f $TMP_FILE ];then
		rm -f $TMP_FILE
        echo ..........delete $TMP_FILE ok...........
    fi

    TMP_FILE=/usr/share/pixmaps/$FILE_NAME*.png
    if [ -f $TMP_FILE ];then
        rm -f $TMP_FILE
        echo ..........delete $TMP_FILE ok...........
    fi
#canceled by ww
#    #delete autorun files 
#    TMP_FILE=/sbin/join-air-launch.sh
#    if [ -f $TMP_FILE ];then
#        rm -f $TMP_FILE
#          echo ..........delete $TMP_FILE ok...........
#    fi

#    TMP_FILE=/etc/udev/rules.d/998-join-air.rules
#    if [ -f $TMP_FILE ];then
#        rm -f $TMP_FILE
#          echo ..........delete $TMP_FILE ok...........
#    fi

    TMP_FILE=/etc/udev/rules.d/9-cdrom.rules
    if [ -f $TMP_FILE ];then
        rm -f $TMP_FILE
        echo ..........delete $TMP_FILE ok...........
    fi

    TMP_FILE=/etc/udev/rules.d/7-zte-mutil_port_device.rules
    if [ -f $TMP_FILE ];then
        rm -f $TMP_FILE
        echo ..........delete $TMP_FILE ok...........
    fi
}

function extract_installation_package
{
    cp -f $FILE_NAME.tar.gz $SYS_PATH/$FILE_NAME.tar.gz
    cd $SYS_PATH
    tar -zxvf $FILE_NAME.tar.gz
}

function two_phrase_production_state2
{
    if [ $TWO_ON == 'true' -a $rettfp == '0' ];then
        # unzip files
        unzip > /dev/null
        ret=$?
        if [ $ret != '0' ]; then
            echo -e "Can not find unzip."
            echo -e "Installation will abort."
            exit -1
        fi

        unzip -o $ZIP_FILE_NAME -d $TEMP_DIR
        retunz=$?
        if [ $retunz != '0' ]; then
            echo -e "unzip $ZIP_FILE_NAME failed."
            echo -e "Installation will abort."
            exit -1
        else
            echo -e "unzip $ZIP_FILE_NAME successfully."
        fi


        RETURN_CHOOSE_LANG=1
        if [ $rettfp == '0' -a -f $CHOOSE_LANGUAGE_RUN ];then
            chmod +x $CHOOSE_LANGUAGE_RUN
            $CHOOSE_LANGUAGE_RUN
            RETURN_CHOOSE_LANG=$?
        fi

        #change permission
        #chmod 0755 -R $TEMP_DIR
        #chmod u+s  -R $TEMP_DIR

        # backup destination directory
        BACKUP_DES_DIR=$TWO_FRASE_TEMP_DIR/backup_for_desDir
        if [ -d $BACKUP_DES_DIR ];then
            rm -rf $BACKUP_DES_DIR
        fi
        mkdir -p $BACKUP_DES_DIR
        cp -rf $DES_DIR/* $BACKUP_DES_DIR/

        #start to replace
        cp -rf $TEMP_DIR/* $DES_DIR/
        retplace=$?
        if [ $retplace != '0' ];then
            cp -rf $BACKUP_DES_DIR/* $DES_DIR/
            echo -e "Replacing file failed."
            echo -e "Installation will abort."
            exit -1;
        else
            echo -e "Repalcing file successfully."
            rm -rf $BACKUP_DES_DIR
        fi

    fi
}

function setup_menu
{
    chmod 0755 $INSTALL_PATH/usr/share/applications/$FILE_NAME.desktop
    cp -f $INSTALL_PATH/usr/share/applications/$FILE_NAME.desktop /usr/share/applications/$FILE_NAME.desktop

    chmod 0755 $INSTALL_PATH/usr/share/pixmaps/$FILE_NAME.png
    cp -f $INSTALL_PATH/usr/share/pixmaps/$FILE_NAME.png /usr/share/pixmaps/$FILE_NAME.png

    update_applications_menu
}

function setup_online_update
{
#    chmod 0755 $SYS_PATH/$FILE_NAME/$UPDATE_FILE
    cd $SYS_PATH/$FILE_NAME/usr/lib
    cp -rf * /usr/lib
	 cd /usr/lib
	 ln -sf libphonon.so.4.4.0 libphonon.so
	 ln -sf libphonon.so.4.4.0 libphonon.so.4
	 ln -sf libphonon.so.4.4.0 libphonon.so.4.4

	 ln -sf libQtCore.so.4.7.3 libQtCore.so
	 ln -sf libQtCore.so.4.7.3 libQtCore.so.4
	 ln -sf libQtCore.so.4.7.3 libQtCore.so.4.7

	 ln -sf libQtNetwork.so.4.7.3 libQtNetwork.so
	 ln -sf libQtNetwork.so.4.7.3 libQtNetwork.so.4
	 ln -sf libQtNetwork.so.4.7.3 libQtNetwork.so.4.7

	 ln -sf libQtDBus.so.4.7.3 libQtDBus.so
	 ln -sf libQtDBus.so.4.7.3 libQtDBus.so.4
	 ln -sf libQtDBus.so.4.7.3 libQtDBus.so.4.7

	 ln -sf libQtSql.so.4.7.3 libQtSql.so
	 ln -sf libQtSql.so.4.7.3 libQtSql.so.4
	 ln -sf libQtSql.so.4.7.3 libQtSql.so.4.7

	 ln -sf libQtGui.so.4.7.3 libQtGui.so
	 ln -sf libQtGui.so.4.7.3 libQtGui.so.4
	 ln -sf libQtGui.so.4.7.3 libQtGui.so.4.7

	 ln -sf libQtXml.so.4.7.3 libQtXml.so
	 ln -sf libQtXml.so.4.7.3 libQtXml.so.4
	 ln -sf libQtXml.so.4.7.3 libQtXml.so.4.7

	ln -sf libQtWebKit.so.4.7.3 libQtWebKit.so
	ln -sf libQtWebKit.so.4.7.3 libQtWebKit.so.4
	ln -sf libQtWebKit.so.4.7.3 libQtWebKit.so.4.7

#    if [ "$(cat /etc/lsb-release | grep Ubuntu)" != "" ];then
#        if [ ! -L /usr/lib/libcurl.so.4 ];then
#        ln -s /usr/lib/libcurl-gnutls.so.4.0.0 /usr/lib/libcurl.so.4
#       fi
#    elif [ "$(cat /etc/debian_version)"=="4.0" ];then
#        if [ ! -L /usr/lib/libcurl.so.4 ];then
#        ln -s /usr/lib/libcurl.so.3.0.0 /usr/lib/libcurl.so.4
#        fi
#	 fi
}

function copy_qt_library
{
	cd $SYS_PATH/$FILE_NAME/usr/lib
	if [ -e $QT_LIBRARY_DIR -a -d $QT_LIBRARY_DIR ];then
		cp -rf * $QT_LIBRARY_DIR
	else
		mkdir $QT_LIBRARY_DIR
		cp -rf * $QT_LIBRARY_DIR
	fi
	cd $QT_LIBRARY_DIR
	cp UniCodec.so UniDevManager.so UniSdk.so UniVousb.so /usr/lib
	rm -rf UniCodec.so UniDevManager.so UniSdk.so UniVousb.so

	ln -sf libphonon.so.4.4.0 libphonon.so
	ln -sf libphonon.so.4.4.0 libphonon.so.4
	ln -sf libphonon.so.4.4.0 libphonon.so.4.4

	ln -sf libQtCore.so.4.7.3 libQtCore.so
	ln -sf libQtCore.so.4.7.3 libQtCore.so.4
	ln -sf libQtCore.so.4.7.3 libQtCore.so.4.7

	ln -sf libQtNetwork.so.4.7.3 libQtNetwork.so
	ln -sf libQtNetwork.so.4.7.3 libQtNetwork.so.4
	ln -sf libQtNetwork.so.4.7.3 libQtNetwork.so.4.7

	ln -sf libQtDBus.so.4.7.3 libQtDBus.so
	ln -sf libQtDBus.so.4.7.3 libQtDBus.so.4
	ln -sf libQtDBus.so.4.7.3 libQtDBus.so.4.7

	ln -sf libQtSql.so.4.7.3 libQtSql.so
	ln -sf libQtSql.so.4.7.3 libQtSql.so.4
	ln -sf libQtSql.so.4.7.3 libQtSql.so.4.7

	ln -sf libQtGui.so.4.7.3 libQtGui.so
	ln -sf libQtGui.so.4.7.3 libQtGui.so.4
	ln -sf libQtGui.so.4.7.3 libQtGui.so.4.7

	ln -sf libQtXml.so.4.7.3 libQtXml.so
	ln -sf libQtXml.so.4.7.3 libQtXml.so.4
	ln -sf libQtXml.so.4.7.3 libQtXml.so.4.7

	ln -sf libQtWebKit.so.4.7.3 libQtWebKit.so
	ln -sf libQtWebKit.so.4.7.3 libQtWebKit.so.4
	ln -sf libQtWebKit.so.4.7.3 libQtWebKit.so.4.7
	if [ "Fedora release 17" == "$(getFC17)" ] ;then
		ln -sf libpng.so.3.49.0 libpng.so.3
		ln -sf libpng12.so.0.49.0 libpng12.so.0
	fi
}

function export_qt_library_path
{
	 #LD_LIBRARY_PATH=$QT_LIBRARY_DIR:$LD_LIBRARY_PATH
	 #export LD_LIBRARY_PATH
	 cp $SYS_PATH/$FILE_NAME/bin/$FILE_NAME.conf /etc/ld.so.conf.d/
	 ldconfig
	 #echo "ldconfig ..."
}

function copy_connection_files
{
    SYS_PPP_DIR="/etc/ppp"
    if [ -e $SYS_PPP_DIR -a -d $SYS_PPP_DIR ];then
        chmod a+wx $SYS_PPP_DIR
    fi

	SYS_PAP_SECRETS_FILE="/etc/ppp/pap-secrets"
    if [ -e $SYS_PAP_SECRETS_FILE -a -f $SYS_PAP_SECRETS_FILE ];then
        chmod 0666 $SYS_PAP_SECRETS_FILE
    fi

    PEERS_DIR="/etc/ppp/peers"
    if [ -e $PEERS_DIR -a -d $PEERS_DIR ];then
        chmod a+x $PEERS_DIR
    fi

    chmod 0755 $INSTALL_PATH/pppd/ip-up.local
    cp -f  $INSTALL_PATH/pppd/ip-up.local /etc/ppp/ip-up.local

    chmod 0755 $INSTALL_PATH/pppd/ip-down.local
    cp -f $INSTALL_PATH/pppd/ip-down.local /etc/ppp/ip-down.local

    chmod 0755 $INSTALL_PATH/pppd/get_route_info
    cp -f $INSTALL_PATH/pppd/get_route_info /etc/ppp/get_route_info
    
#canceled by ww
#    TMP_FILE=/etc/wvdial.conf
#    if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    else
#        cp -f $INSTALL_PATH/Data$TMP_FILE  $TMP_FILE
#        chmod 0755 $TMP_FILE   
#    fi

#    TMP_FILE=/etc/ppp/options
#	if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    else
#        cp -f $INSTALL_PATH/Data$TMP_FILE  $TMP_FILE
#        chmod 0755 $TMP_FILE
#    fi
#
#    TMP_FILE=/etc/ppp/resolv.conf
#    if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    else
#        cp -f $INSTALL_PATH/Data$TMP_FILE  $TMP_FILE
#        chmod 0755 $TMP_FILE  
#    fi

#    TMP_FILE=/etc/resolv.conf
#    if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    else
#        cp -f $INSTALL_PATH/Data$TMP_FILE  $TMP_FILE
#        chmod 0755 $TMP_FILE 
#    fi

#    #add by ChenYing 2009-3-5
#    TMP_FILE=/etc/resolv.conf.bak
#    if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    fi
#
#    TMP_FILE=/etc/resolv.conf.prev
#    if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    fi
#
#canceled by ww
#    TMP_FILE=/etc/ppp/peers/wvdial
#    if [ -f $TMP_FILE ];then
#        chmod 0755 $TMP_FILE
#    else
#        cp -f $INSTALL_PATH/Data$TMP_FILE  $TMP_FILE
#        chmod 0755 $TMP_FILE
#    fi
}

function copy_language_and_help_file
{
    echo > /dev/null
    #Language Select and help file
    #TMP_FILE=$INSTALL_PATH/bin/$LANGUAGE/$QM_NAME
    #if [ -f $TMP_FILE ];then 
    #    chmod 0755 $TMP_FILE
    #    cp -f $TMP_FILE  $INSTALL_PATH/Data/$QM_NAME
    #fi
    #TMP_FILE=$INSTALL_PATH/bin/$LANGUAGE/$HELP
    #cp -r $TMP_FILE $INSTALL_PATH/Data 
}

function chmod_files
{
    chmod 0755 $INSTALL_PATH/bin/$FILE_NAME
    cp -f $INSTALL_PATH/bin/$FILE_NAME /bin/$FILE_NAME

#    chmod 0755 /usr/bin/wvdial
#    chmod 0755 /usr/sbin/pppd   ####modified by ww 20120918
#    chmod 0755 $RUN_EVINCE

#    chmod a+x $INSTALL_PATH/Data/run_evince.sh
    chmod a+x $INSTALL_PATH/Data/aplay.sh
	chmod a+x $INSTALL_PATH/Data/launchFirefox.sh
    chmod 0777 $SYS_PATH
    chmod 0777 $INSTALL_PATH
    chown root.root $INSTALL_PATH/"$EXE_FILE"
    chmod 0755 $INSTALL_PATH/"$EXE_FILE"
    chmod u+s $INSTALL_PATH/"$EXE_FILE"
    chmod 0755 $INSTALL_PATH/uninstall.sh
    chmod 0755 $INSTALL_PATH/wirelessconfig/*
    chmod 0755 $INSTALL_PATH/scripts/*
}

function install_aplay
{
	APLAYBIN=$INSTALL_PATH/bin/aplay 
   	APLAY_TARGET="/usr/bin/aplay"
   	if [ ! -e $APLAY_TARGET ];then
		cp $APLAYBIN $APLAY_TARGET
        chmod 755 $APLAY_TARGET
   fi
}

function setup_udev_rules
{
	TMP_FILE=$INSTALL_PATH/bin/9-cdrom.rules
    cp -f $TMP_FILE  /etc/udev/rules.d/9-cdrom.rules
    TMP_FILE=$INSTALL_PATH/bin/7-zte-mutil_port_device.rules
    cp -f $TMP_FILE  /etc/udev/rules.d/7-zte-mutil_port_device.rules

    if [ -f /sbin/udevadm ]
    then
        #/sbin/udevadm control --reload-rules >/dev/null 2>&1
	    #/sbin/udevadm trigger subsystem=usb >/dev/null 2>&1
	    #/sbin/udevadm trigger system=block >/dev/null 2>&1
		/sbin/udevadm control reload_rules >/dev/null 2>&1
        /sbin/udevadm control --reload-rules >/dev/null 2>&1
        /sbin/udevadm trigger --subsystem-match=block
        echo "udevadm is exist!"
    else
        /sbin/udevcontrol reload_rules 
        /sbin/udevtrigger --subsystem-match=block 
        echo "udevadm isn't exist!"
    fi
    rm -f  $INSTALL_PATH/bin/9-cdrom.rules
    rm -f  $INSTALL_PATH/bin/7-zte-mutil_port_device.rules
}

function remove_temp_file
{
    rm -f $SYS_PATH/$FILE_NAME.tar.gz
}

function install_driver
{
    echo ******Begin to $INSTALL_PATH/driver
    cd $INSTALL_PATH/driver
    chmod 0755 driver_install.run
    ./driver_install.run
    echo ****** End to $INSTALL_PATH/driver
}

function add_selinux_rules
{
    cd $INSTALL_PATH/driver
    chmod 0755 se
    if [ -n "`uname -r |grep fc`" ];then    
        ./se "/usr/sbin/semodule -i disselfirefox.pp"
        ./se "/usr/sbin/semodule -i nm.pp"
        echo "it's ok!"
    fi
}

function change_user_group
{
    while read LINE
    do
        USER2CH=${LINE%%:*} 
        LINE=${LINE#*:}
        LINE=${LINE#*:}
        USER_ID=${LINE%%:*}
    
        if [ $USER_ID -ge 1000 ];then
            if [ $USER2CH != "nobody" ]; then
                #echo $USER2CH:$USER_ID
		if [ "OpenSUSE" == $(get_distro_name) ] ;then
                    /usr/sbin/usermod -G dialout $USER2CH
	        else
                    /usr/sbin/usermod -a -G  netdev,dialout,dip $USER2CH
	        fi
            fi
        fi
    done < /etc/passwd
}

function setup_auto_start_script
{
    TMP_FILE=$INSTALL_PATH/launch-gui.sh
    if [ -f $TMP_FILE ];then
        chown root.root $TMP_FILE
        chmod 0755  $TMP_FILE
        chmod u+s  $TMP_FILE
        cp -f $TMP_FILE  /bin
    fi
}



function handleXWindowProbOnOpenSUSE114
{
    export DISPLAY=":0.0"
    XUSER=`who | grep tty7 | awk '{print $1}'`
    if [ "" == "$XUSER" ];then
        XUSER=`who |  grep --regexp=:0[\ ] | awk '{print $1}'`
            if [ "" == "$XUSER" ];then
                XUSER=`who |  grep --regexp=:0[\)] | awk '{print $1}'`
            fi
    fi
    echo $XUSER
    su $XUSER -c "xhost +"
}

function run_program
{
    if [ $TWO_ON == 'true' -a $rettfp == '0' -a -f $LAST_RUN ];then
        chmod +x $LAST_RUN 
        $LAST_RUN $RETURN_CHOOSE_LANG
    else
        echo "install completed!!!"

        echo  "....After setup, you will find the $DISPLAY_NAME in \"Applications->Internet->$DISPLAY_NAME\". Click the $DISPLAY_NAME and the application will run"
        read -p "press any key to continue.... " -n 1
        "$FILE_NAME"
    fi
}

function update_applications_menu
{
    PARTIAL_NAME=$(locale | head -1)
    PARTIAL_NAME=${PARTIAL_NAME#*=}
    PARTIAL_NAME=${PARTIAL_NAME%.*}

    CACHE_NAME=`ls /usr/share/applications/desktop.*.cache | head -1`
    CACHE_NAME=${CACHE_NAME#*.}
    CACHE_NAME=${CACHE_NAME%.*}
    CACHE_NAME=${CACHE_NAME#*.}

    FILENAME=$PARTIAL_NAME.$CACHE_NAME
    if [ -f /usr/share/applications/desktop.$FILENAME.cache ]; then
        /usr/share/gnome-menus/update-gnome-menus-cache /usr/share/applications > /usr/share/applications/desktop.$FILENAME.cache
    fi
}


# function defination end


#main start

assert_software_installed

#echo "..................start install................."

assert_root_privilege

if [ "OpenSUSE" == $(get_distro_name) ] ;then
    handleXWindowProbOnOpenSUSE114
fi

#if [ "Fedora release 17" == "$(getFC17)" ] ;then
#	echo $TAR_PACKAGE_PATH
#	echo "Current OS is \"Fedora release 17\", \"libpng-compat\" is needed, and we install it for you!" 
#	cd $TAR_PACKAGE_PATH
#	rpm -i libpng-compat-1.5.10-1.fc17.i686.rpm
#fi
#check_qt3

#check_wvdial

#select_language

two_phrase_production_state1

delete_previous_file

extract_installation_package

two_phrase_production_state2

setup_menu

#setup_online_update
copy_qt_library
export_qt_library_path
copy_connection_files

#copy_language_and_help_file

chmod_files

install_aplay

#setup_udev_rules

remove_temp_file

#if [ "Fedora release 17" != "$(getFC17)" -a "Ubuntu 12.04" != "$(getU1204)" ] ;then
install_driver
#fi

add_selinux_rules

change_user_group

setup_auto_start_script

setup_udev_rules

run_program

exit
