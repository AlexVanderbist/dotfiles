# All the dig info
function digga() {
	dig +nocmd "$1" any +multiline +noall +answer
}

#shortcut voor zhs quick-look command
function ql() {
   quick-look "$1"
}

function weather() {
   city="$1"

   if [ -z "$city" ]; then
      city="Antwerp"
   fi

   eval "curl http://wttr.in/${city}"
}

#  Commit everything
function commit() {
  commitMessage="$*"

  if [ "$commitMessage" = "" ]; then
     commitMessage="wip"
  fi

  git add .
  eval "git commit -a -m '${commitMessage}'"
}

xdebug() {
   iniFileLocation="/usr/local/etc/php/8.1/php.ini";

   currentLine=`cat $iniFileLocation | grep xdebug.so`

   if [[ $currentLine =~ ^#zend_extension ]];
   then
      sed -i -e 's/^#zend_extension/zend_extension/g' $iniFileLocation
      echo "xdebug is now active";
   else
      sed -i -e 's/^zend_extension/#zend_extension/g' $iniFileLocation
      echo "xdebug is now inactive";
   fi
}

function db {
    if [ "$1" = "refresh" ]; then
        mysql -uroot -e "drop database $2; create database $2"
    elif [ "$1" = "create" ]; then
        mysql -uroot -e "create database $2"
    elif [ "$1" = "drop" ]; then
        mysql -uroot -e "drop database $2"
    elif [ "$1" = "list" ]; then
        mysql -uroot -e "show databases" | perl -p -e's/\|| *//g'
    fi
}

function opendb () {
   [ ! -f .env ] && { echo "No .env file found."; exit 1; }

   DB_CONNECTION=$(grep DB_CONNECTION .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_HOST=$(grep DB_HOST .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PORT=$(grep DB_PORT .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_DATABASE=$(grep DB_DATABASE .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_USERNAME=$(grep DB_USERNAME .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)
   DB_PASSWORD=$(grep DB_PASSWORD .env | grep -v -e '^\s*#' | cut -d '=' -f 2-)

   DB_URL="${DB_CONNECTION}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOST}:${DB_PORT}/${DB_DATABASE}"

   echo "Opening ${DB_URL}"
   open $DB_URL
}

function scheduler () {
    while :; do
        php artisan schedule:run
	echo "Sleeping 60 seconds..."
        sleep 60
    done
}

function silent() {
   "$@" >& /dev/null
}

function toggle-dock() {
    if [[ "$(defaults read com.apple.dock autohide)" -eq "1" ]]; then
        defaults write com.apple.dock autohide -bool false && killall Dock
	defaults delete com.apple.dock autohide-delay && killall Dock
	defaults write com.apple.dock no-bouncing -bool FALSE && killall Dock
	exit
    fi

    defaults write com.apple.dock autohide -bool true && killall Dock
    defaults write com.apple.dock autohide-delay -float 1000 && killall Dock
    defaults write com.apple.dock no-bouncing -bool TRUE && killall Dock
}

