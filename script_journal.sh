#!/usr/bin env bash #﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
#Name:Purushottam Tandon
#Date: Thu Jan  8 11:34:44 PM IST 2026
#Descr: Generate a markdown script using the script command
#FIX; record-proc_mode
#FIX; add logic to eval the first command and throw error if necessary.
#﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏﹏
# Logfile where inputs will be logged (only inputs, no outputs)
# exit command exit from mainsystem and no more command shall move you back 1 step in the process
# NOTE FOR NEW LOGFILE GENERATE WITH MD extension
LOGDIR="$HOME/script_logs/"
LOGFILE="$LOGDIR$2" 
RECORD_PROC_MODE=0 # 0-turned off
# Function to log the input command
usage(){
		echo "================== SCRIPT GEN:======================"
		echo "You must have encountered a situation sometimes you forgot all the steps even though you know that command."
		echo "What if we simply execute the command once and also remember it as a cheatsheet. That'd be great"
		echo "This is what this script does"
		echo "USAGE: sr -[mode] <file_to_save> # NOTE make sure to write the file name along with the extension .md\
				 if no <file_to_save> is found it'll be using a default cmd.md as logfile."
		echo " Usage : title: takes a title | tell me more about this : takes a paragraph  | explain: takes a bullet point "
		echo " nomore : moves you one step back or skip step if not required | exit: exits the program"
		echo "RECORD_PROC_MODE : 0 (default)"
		echo "RECORD_PROC_MODE when enabled. User would be able to record a set of procedure in a step wise manner.They can add a comment and invoke the commmand. Command as well as the comment will be recorded in the log which can later be replayed if you've tested enough of your procedure and it doesn't involves any rm -rf command!!!. For e.g. mounting an external device doing it through raw terminal. "
		echo "NOTE : USER MUST PROVIDE A MODE using -n (normal mode) or -r (record procedure mode) switch else it'll only show error "
}
gen_logfile(){
		if [[ -e $LOGFILE ]];then
				echo "LOGFILE: $LOGFILE exists.Writing content to the same file." >&2
		else 
				touch $LOGFILE
		fi
}
usage_more(){
		echo "SCRIPT_JOURNAL : MAKE YOUR OWN CHEATSHEET AT A GO !!"
		echo "Usage : sr -[mode:-r|-n] <BUF_NAME> "
		echo "3 sets of tags available: 1. title 2. info aka paragraph 3. bullets "
		echo " use no more command in REPL to skip tags if needed"
		echo " To exit the REPL use exit command"
		echo " HOPE :) you'd a great time learning and had fun using this script"
		echo "For more information use -h switch "
 
}
gen_title(){
		read -p  "Enter Title or Subject:#" -e title
		echo "#### $title">> $LOGFILE
}
gen_info(){
		read -p "Tell more about this: " -e whatinfo
		echo "- $whatinfo">> $LOGFILE
}
gen_bullet_point(){ 
		# purpose : to record the event in steps
		# set a count i for bullet points for the sr script
		# while user prompts take input into bullets
		# check if bullet =="nomore" ; exit but do not record nomore in the logfile
		local i=1
		while read -p "[b]:" -e bullet;do
				if [[ $bullet == "nomore" || $bullet=="nm" ]]; then
					break
				fi
				((i++))
				echo "$i. $bullet">>$LOGFILE
		done
}
div(){
		echo "---" >> $LOGFILE
}
log_input() {
    echo  "> \`\`\`  $1  \`\`\`" >> "$LOGFILE"
}

# Main loop to read and execute commands
main(){
		#REPL
gen_logfile 
while true; do
		echo -n "$(tput setaf 1) [nutshell 🔩] :"
		read  -e  command
    if [[ "$command" == "exit" ]]; then
        break
    fi
    
    # Log the input command (without output)
		gen_title
		div
		gen_info
		gen_bullet_point 
		log_input "$command"
		bash -c "$command"
    # Execute the command (output goes to stdout/stderr as usual, not logged)
done
echo "Session ended.Commands logged to $LOGFILE"
}
while getopts ":rnhvc:" opts;do
		case "$opts" in
				r)
						echo "RECORD_PROC_MODE is enabled. check -h for more info"
						# usage_more 
						RECORD_PROC_MODE=1
						main
						;;
				n) echo "normal mode enabled."
						# usage_more 
						RECORD_PROC_MODE=0
						main
						;;
				h)
						usage
						;;
				c) gen_logfile 
						;;
				v) 
						batcat $LOGFILE
						;;
				*) echo "invalid input or params required use -h more information" >&2
						;;
				:) usage_more
						;;
		esac
done
