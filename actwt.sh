
#! /bin/bash

apt=ActivityWatch
usn=$(ls -t /Users | awk 'NR==1 {print $1}')

chk(){
    if [ -d "/Applications/$apt.app" ]; then
        pkill -f "ActivityWatch"
        osascript -e 'tell application "System Events" to delete login item "ActivityWatch"'
        rm -rf "/Applications/ActivityWatch.app/"
        rm -rf "/Users/$usn/Library/Application Support/activitywatch"

    fi

}


inst(){
	hdiutil mount ActivityWatch.dmg
	cp -rvf "/Volumes/ActivityWatch/ActivityWatch.app" /Applications/
}

remve(){
	hdiutil unmount "/Volumes/ActivityWatch/"
}

perms(){
    chown -R root:wheel /Applications/ActivityWatch.app
    osascript -e 'tell application "System Events" to make login item at end with properties {path:"/Applications/ActivityWatch.app", hidden:false}'
    open x-apple.systempreferences:com.apple.preference.security?Privacy_Accessibility && open /System/Library/CoreServices/ && open /Applications/

}

setin(){
    clear
    if [ `whoami` != root ]; then
            echo "\033[0;31mPlease run this scripts as root or using sudo\033[0m "
            echo ""
            exit
    else
        chk
        inst
        remve
        perms
    fi
}

setin