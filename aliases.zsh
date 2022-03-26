# PHP
alias phpunit="vendor/bin/phpunit"
alias pest="vendor/bin/pest"
alias a="php artisan"
alias c="composer"
alias cu="composer update"
alias cr="composer require"
alias ci="composer install"
alias larastan="vendor/bin/phpstan analyse"
alias deploy='envoy run deploy'
alias deploy-code='envoy run deploy-code'
alias mfs='php artisan migrate:fresh --seed'
alias sail='./vendor/bin/sail'

# JavaScript
alias jest="./node_modules/.bin/jest"

# Git
alias nah='git reset --hard;git clean -df'
alias gc="git checkout"
alias gpo="git push origin"
alias glog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset' --abbrev-commit"

# List all files colorized in long format
alias l="ls -laF"

# PhpStorm
alias phpstorm='open -a /Applications/PhpStorm.app "`pwd`"'

# Redis
alias flush-redis="redis-cli FLUSHALL"

# VSCode
alias code='open -a "/Applications/Visual Studio Code.app" "`pwd`"'

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# IP addresses
alias ip="curl https://diagnostic.opendns.com/myip ; echo"
alias localip="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"

# Flush Directory Service cache
alias flushdns="sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder"

# Empty the Trash on all mounted volumes and the main HDD
# Also, clear Apple’s System Logs to improve shell startup speed
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; sudo rm -rfv ~/.Trash; sudo rm -rfv /private/var/log/asl/*.asl"

# Enable aliases to be sudo’ed
alias sudo='sudo '
