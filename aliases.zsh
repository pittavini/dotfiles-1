# Shortcuts
alias copyssh="pbcopy < $HOME/.ssh/id_rsa.pub"
alias reloadshell="source $HOME/.zshrc"
alias reloaddns="dscacheutil -flushcache && sudo killall -HUP mDNSResponder"
alias shrug="echo '¯\_(ツ)_/¯' | pbcopy"
alias c="clear"

# Directories
alias dotfiles="cd $DOTFILES"
alias library="cd $HOME/Library"
alias dev="cd $HOME/dev"

# Docker
alias docker-composer="docker-compose"

# Git
alias gst="git status"
alias gb="git branch"
alias gc="git checkout"
alias gl="git log --oneline --decorate --color"
alias amend="git add . && git commit --amend --no-edit"
alias commit="git add . && git commit -m"
alias diff="git diff"
alias force="git push --force"
alias nuke="git clean -df && git reset --hard"
alias pop="git stash pop"
alias pull="git pull"
alias push="git push"
alias resolve="git add . && git commit --no-edit"
alias stash="git stash -u"
alias unstage="git restore --staged ."
alias wip="commit wip"

alias ed="open -a TextEdit"
alias j14="export JAVA_HOME=`/usr/libexec/java_home -v 14`; java -version"
alias j8="export JAVA_HOME=`/usr/libexec/java_home -v 1.8`; java -version"
alias tsp="/usr/local/bin/ts"
alias update="softwareupdate -i -a;bubu;omz update" #brew upgrade --cask --greedy
alias vpncon="networksetup -connectpppoeservice 'Unibe VPN'"
alias vpndis="networksetup -disconnectpppoeservice 'Unibe VPN'"


#-------- Transmission CLI {{{                                                                                                                                                                                                                                                
#------------------------------------------------------                                                                                                                                                                                                                       
# lightweight torrent daemon, has option for cli, webui, ncurses, and gui frontend                                                                                                                                                                                            
# demo video: http://www.youtube.com/watch?v=ee4XzWuapsE           
# WebUI:        http://localhost:9091/transmission/web/                                                                                
#               http://192.168.1.xxx:9091/transmission/web/      
tsm-clearcompleted() {         
        transmission-remote -l | grep 100% | grep Done | \
        awk '{print $1}' | xargs -n 1 -I % transmission-remote -t % -r ;}
tsm() { transmission-remote --list ;}
        # numbers of ip being blocked by the blocklist
        # credit: smw from irc #transmission                       
tsm-count() { echo "Blocklist rules:" $(curl -s --data \           
        '{"method": "session-get"}' localhost:9091/transmission/rpc -H \
        "$(curl -s -D - localhost:9091/transmission/rpc | grep X-Transmission-Session-Id)" \
        | cut -d: -f 11 | cut -d, -f1) ;}
# demo video: http://www.youtube.com/watch?v=TyDX50_dC0M
tsm-blocklist() { $PATH_SCRIPTS/blocklist.sh ;}         # update blocklist
tsm-daemon() { transmission-daemon ;}                              
tsm-quit() { pkill -f transmission ;}                              
tsm-altspeedenable() { transmission-remote --alt-speed ;}       # limit bandwidth
tsm-altspeeddisable() { transmission-remote --no-alt-speed ;}   # dont limit bandwidth
tsm-add() { transmission-remote --add "$1" ;}
tsm-askmorepeers() { transmission-remote -t"$1" --reannounce ;}
tsm-pause() { transmission-remote -t"$1" --stop ;}              # <id> or all
tsm-start() { transmission-remote -t"$1" --start ;}             # <id> or all
tsm-purge() { transmission-remote -t"$1" --remove-and-delete ;} # delete data also
tsm-remove() { transmission-remote -t"$1" --remove ;}           # leaves data alone
tsm-info() { transmission-remote -t"$1" --info ;}
tsm-speed() { while true;do clear; transmission-remote -t"$1" -i | grep Speed;sleep 1;done ;}
#}}}


#-------- surf with elvis {{{
#------------------------------------------------------
fzf-surfraw() {
    search="$(sr -elvis | sed '/^$/d' | sed '/^#/d' | sort -n | fzf -e -i)"
    echo -n "Enter keyword: "; read keyword
    surfraw -browser=w3m "$(awk '{print $1}' <<< "$search")" "$keyword"}
#}}}

#-------- Task-Spooler - Queue Task on The Fly {{{
#------------------------------------------------------
# DEMO: https://www.youtube.com/watch?v=jhv-2pNWfr4
# DESC: switch audio stream to different output (HDMI, Headphone, Speakers ...etc)
# REFF: http://askubuntu.com/a/18210
# LINK: http://quvi.sourceforge.net/

alias tsp-ranger='TS_SOCKET=/tmp/ranger tsp'
alias tsp-notoolrush='TS_SOCKET=/tmp/notoolrush tsp'
alias tsp-shorttask='TS_SOCKET=/tmp/shorttask tsp'
alias tsp-mediumtask='TS_SOCKET=/tmp/mediumtask tsp'
alias tsp-w3m='TS_SOCKET=/tmp/w3m tsp'
# }}}

#-------- Docker Stuff {{{
#------------------------------------------------------
dcleanup() {
                echo "--------------- Delete Containers -----------------"
                docker rm $(docker ps -a -q)

                echo "--------------- Delete Images -----------------"
                docker rmi -f $(docker images -q)
                echo "---------------------------------------------------"
}
#}}}
