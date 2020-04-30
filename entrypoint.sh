#!/bin/bash

if [[ -z "${MEGA_SESSION}" ]]; then
  if [[ -z "${MEGA_EMAIL}" ]] || [[ -z "${MEGA_PASSWORD}" ]] ; then
    exit -1;
  else 
    mega-login $MEGA_EMAIL $MEGA_PASSWORD
  fi
else
  mega-login $MEGA_SESSION
fi

# Source https://blog.sleeplessbeastie.eu/
usage(){
  echo "Usage:"
  echo "  $0 -p path"
  echo ""
  echo "Options:"
  echo "  -p path : set a path to share over WEBDAV, repeat it multiple times"
  echo ""
  exit
}

while getopts "p:" option; do
  case $option in
    "p")
      arguments+=("$OPTARG")
      ;;
    *)
      usage
      ;;
  esac
done

if [ "$OPTIND" -eq "1" ] || [ "$OPTIND" -le "$#" ]; then
  usage
fi

echo "Sharing these paths:"
for argument in "${arguments[@]}"; do
  mega-webdav --public "${argument}"
done

tail -f /dev/null
