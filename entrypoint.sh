#!/bin/bash

if [ -z "$1" ]; then
   if [ ! -d "/var/mux/game" ]; then
      echo -e "You must mount a volume at /var/mux/game.\n"
      echo "If this is your first time starting the Docker container, create an"
      echo -e "empty directory and mount with an option like this:\n"
      echo -e "    -v \"/path/to/host/game/files:/var/mux/game\"\n"
      exit 1
   fi

   if [ ! -f "/var/mux/game/mux.config" ]; then
      su -s /bin/bash -c "cp -a /usr/local/share/btmux/game.factory_issue/{alias.conf,mux.config,netmux.conf,data,text,mechs,maps} /var/mux/game/" mux
   fi

   source /var/mux/game/mux.config

   ulimit -c unlimited

   ${BIN}/mkindx ${TEXT}/news.txt ${TEXT}/news.indx
   ${BIN}/mkindx ${TEXT}/help.txt ${TEXT}/help.indx
   ${BIN}/mkindx ${TEXT}/wizhelp.txt ${TEXT}/wizhelp.indx
   ${BIN}/mkindx ${TEXT}/plushelp.txt ${TEXT}/plushelp.indx
   ${BIN}/mkindx ${TEXT}/wiznews.txt ${TEXT}/wiznews.indx

   if [ -f ${DATA}/${INPUT_DB}.KILLED -o -f ${DATA}/${INPUT_DB}.CORRUPT -o -f ${DATA}/${INPUT_DB}.CRASH ]; then
      echo "There is a CORRUPT, KILLED or CRASH database present."
      echo "You should salvage what you can before continuing."
      exit 1
   fi

   if [ -f ${DATA}/${NEW_DB} ]; then
      mv ${DATA}/${NEW_DB} ${DATA}/${INPUT_DB}
   else
      cp ${DATA}/${SAVE_DB} ${DATA}/${INPUT_DB}
   fi

   exec "${BIN}/netmux" "${GAMENAME}.conf >${LOGNAME} 2>&1" mux
else
   exec "$1"
fi
