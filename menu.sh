
#!/bin/bash

clear

get_platform() {
  uname_str=`uname -a`

  if [[ "$uname_str" ==  "Linux raspberrypi"* ]]
  then
    result="pi"
  elif [[ "$uname_str" ==  "MINGW64"* ]]
  then
    result="mingw64"
  elif [[ "$uname_str" =~  "qcom"* ]]
  then
    result="db410c"
  else
    result=""
  fi
}

get_platform
PLATFORM=$result

#if [ "$PLATFORM" == "pi" ]
#then
#  source pi.sh
#elif [ "$PLATFORM" == "mingw64" ]
#then
#  source mingw.sh
#elif [ "$PLATFORM" == "db410c" ]
#then
##  source db410c.sh  
#else
#  echo "The installation script doesn't support current system. (System: $(uname -a))"
#  exit 1
#fi

#-------------------------------------------------------
# Function to parse user's input.
#-------------------------------------------------------
# Arguments are: Yes-Enabled No-Enabled Quit-Enabled
YES_ANSWER=1
NO_ANSWER=2
QUIT_ANSWER=3
parse_user_input()
{
  if [ "$1" = "0" ] && [ "$2" = "0" ] && [ "$3" = "0" ]; then
    return
  fi
  while [ true ]; do
    Options="["
    if [ "$1" = "1" ]; then
      Options="${Options}y"
      if [ "$2" = "1" ] || [ "$3" = "1" ]; then
        Options="$Options/"
      fi
    fi
    if [ "$2" = "1" ]; then
      Options="${Options}n"
      if [ "$3" = "1" ]; then
        Options="$Options/"
      fi
    fi
    if [ "$3" = "1" ]; then
      Options="${Options}quit"
    fi
    Options="$Options]"
    read -p "$Options >> " USER_RESPONSE
    USER_RESPONSE=$(echo $USER_RESPONSE | awk '{print tolower($0)}')
    if [ "$USER_RESPONSE" = "y" ] && [ "$1" = "1" ]; then
      return $YES_ANSWER
    else
      if [ "$USER_RESPONSE" = "n" ] && [ "$2" = "1" ]; then
        return $NO_ANSWER
      else
        if [ "$USER_RESPONSE" = "quit" ] && [ "$3" = "1" ]; then
          printf "\nGoodbye.\n\n"
          exit
        fi
      fi
    fi
    printf "Please enter a valid response.\n"
  done
}


echo "====== Select Menu ======"
echo ""
echo "1. AiVA Full Test"
echo "2. Buddy Setup"
echo "3. Run Google Assistant (Korean)"
echo "4. Run Google Assistant (English)"
echo "5. UART Communication"
echo "6. Sound Pressure Test"
echo "7. Sound Hi Message (Loop)"
echo "8. Quit"
echo ""
echo "========================="

while [[ -z $MenuNo ]] ; do
    echo "Enter Menu NO:"
    read MenuNo
#    export SDK_CONFIG_PRODUCT_ID
done


if [ "$MenuNo" = "1" ]; then
	python ./zigbee/client/pyserial_test.py &
	source ./run_google_assistant_ko.sh
fi
if [ "$MenuNo" = "2" ]; then
	python ./zigbee/loopback/pyserial_test.py &
	if [ "$PLATFORM" == "pi" ]
		source ./sound_hi_play.sh
	else
		source ./sound_hi_pla_db410.sh
	fi	
fi
if [ "$MenuNo" = "3" ]; then
	source ./run_google_assistant_ko.sh
fi
if [ "$MenuNo" = "4" ]; then
	source ./run_google_assistant.sh
fi
if [ "$MenuNo" = "5" ]; then
	python ./zigbee/client/pyserial_test.py
fi
if [ "$MenuNo" = "6" ]; then
	if [ "$PLATFORM" == "pi" ]
		source ./sound_hi_play.sh
	else
		source ./sound_hi_pla_db410.sh
	fi		
fi
if [ "$MenuNo" = "7" ]; then
	source ./sound_pressure_play.sh
	if [ "$PLATFORM" == "pi" ]
		source ./sound_pressure_play.sh
	else
		source ./sound_pressure_play_db410.sh
	fi			
fi
if [ "$MenuNo" = "8" ]; then
	exit 1
fi

