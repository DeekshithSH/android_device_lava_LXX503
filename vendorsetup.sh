#
#	This file is part of the OrangeFox Recovery Project
# 	Copyright (C) 2021-2023 The OrangeFox Recovery Project
#
#	OrangeFox is free software: you can redistribute it and/or modify
#	it under the terms of the GNU General Public License as published by
#	the Free Software Foundation, either version 3 of the License, or
#	any later version.
#
#	OrangeFox is distributed in the hope that it will be useful,
#	but WITHOUT ANY WARRANTY; without even the implied warranty of
#	MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#	GNU General Public License for more details.
#
# 	This software is released under GPL version 3 or any later version.
#	See <http://www.gnu.org/licenses/>.
#
# 	Please maintain this if you use this script or any part of it
#
FDEVICE="LXX503"

fox_get_target_device() {
local chkdev=$(echo "$BASH_SOURCE" | grep -w \"$FDEVICE\")
   if [ -n "$chkdev" ]; then 
      FOX_BUILD_DEVICE="$FDEVICE"
   else
      chkdev=$(set | grep BASH_ARGV | grep -w \"$FDEVICE\")
      [ -n "$chkdev" ] && FOX_BUILD_DEVICE="$FDEVICE"
   fi
}

if [ -z "$1" -a -z "$FOX_BUILD_DEVICE" ]; then
   fox_get_target_device
fi

if [ "$1" = "$FDEVICE" -o "$FOX_BUILD_DEVICE" = "$FDEVICE" ]; then
    export FOX_AB_DEVICE=1
    export FOX_PORTS_TMP="/workspace/platform_manifest_twrp_aosp/ofr"
    export FOX_PORTS_INSTALLER="/workspace/platform_manifest_twrp_aosp/temp"
    export OF_MAINTAINER="Deekshith SH"
    export FOX_VERSION="12.1-Beta"
    export OF_ALLOW_DISABLE_NAVBAR=0
    export FOX_VANILLA_BUILD=1
    # export OF_DEVICE_WITHOUT_PERSIST=1
    export FOX_USE_NANO_EDITOR=1
    export OF_FORCE_PREBUILT_KERNEL=1
    export OF_NO_ADDITIONAL_MIUI_PROPS_CHECK=1
    # export OF_DEFAULT_TIMEZONE=""
    export ALLOW_MISSING_DEPENDENCIES=true


	# try to prevent potential data format errors
	export OF_UNBIND_SDCARD_F2FS=1

	# screen settings
	export OF_SCREEN_H=2400
	# export OF_STATUS_H=100
	# export OF_STATUS_INDENT_LEFT=48
	# export OF_STATUS_INDENT_RIGHT=48
  	# export OF_HIDE_NOTCH=1
	export OF_CLOCK_POS=1

	# let's see what are our build VARs
	if [ -n "$FOX_BUILD_LOG_FILE" -a -f "$FOX_BUILD_LOG_FILE" ]; then
  	   export | grep "FOX" >> $FOX_BUILD_LOG_FILE
  	   export | grep "OF_" >> $FOX_BUILD_LOG_FILE
   	   export | grep "TARGET_" >> $FOX_BUILD_LOG_FILE
  	   export | grep "TW_" >> $FOX_BUILD_LOG_FILE
 	fi
else
	if [ -z "$FOX_BUILD_DEVICE" -a -z "$BASH_SOURCE" ]; then
		echo "I: This script requires bash. Not processing the $FDEVICE $(basename $0)"
	fi
fi
#
