#! /vendor/bin/sh

# Copyright (c) 2012-2013, 2016-2020, The Linux Foundation. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions are met:
#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in the
#       documentation and/or other materials provided with the distribution.
#     * Neither the name of The Linux Foundation nor
#       the names of its contributors may be used to endorse or promote
#       products derived from this software without specific prior written
#       permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NON-INFRINGEMENT ARE DISCLAIMED.  IN NO EVENT SHALL THE COPYRIGHT OWNER OR
# CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
# EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
# PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS;
# OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
# WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR
# OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
# ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

function create_vram_swapfile() {        
 if [ "$(getprop persist.vendor.vramenable)" == "true" ]; then
 	
	 if [ -f /data/vendor/swap/swapfile ]; then
		filesize=`wc -c < /data/vendor/swap/swapfile`
		m=1048576
		fileM=`expr $filesize / $m`
		echo $fileM

		vramsize=$(getprop persist.vendor.vramsize)
		echo $vramsize
		  if [ $fileM = $vramsize ]; then
		    mkswap /data/vendor/swap/swapfile
	    else
	      rm -fr  /data/vendor/swap/swapfile
	      dd if=/dev/zero of=/data/vendor/swap/swapfile bs=1M count=$vramsize
			  mkswap /data/vendor/swap/swapfile
	    fi
	  else
		 vramsize=$(getprop persist.vendor.vramsize)
		 echo $vramsize
		 dd if=/dev/zero of=/data/vendor/swap/swapfile bs=1M count=$vramsize
		 mkswap /data/vendor/swap/swapfile
        fi
 fi
}

setprop persist.vendor.vramconfigdone false

create_vram_swapfile

setprop persist.vendor.vramconfigdone true
