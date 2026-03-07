# Simultaneous Comamnd execution and recorder 


### Introduction 
Script journal is an interesting script intended to document commands with useful comments and a suitable header. 
Script will invoke a read line terminal that will allow to execute your terminal commands and simultaneously 
dcoument it in a markdown file. 

### Why? 

I personally wrote this script to record my commands which has been complex and require more attention but I'd to 
remember the command or usually do a web search to invoke that command. Also, I wanted to create my own set of 
document or cheatsheet that I can access it anywhere. Yes, claude code and gemini cli are probably such options 
as well but it doeesn't allows the fine gain control over my preferences. 


### Features : 

- Allows user to interact with the terminal as we normally do in any other shell. Tested on Bash and Zsh.
- Allows to record a single command and add a suitable header and comments.
- User if working through multi-chain commands like setting up a ssh server , aws cli or involving multiple steps
  can easily record the set of commands interactively.
- User can create a large cheatsheets for their everyday terminal commands
 
### Installation : 

  - clone the repo using the following command:
 ```python
      git clone https://p12duke/
```

### Usage: 

Create a suitable alias in your .bashrc or your .zshrc profile. You can use simple alias like 'sr' in this case or whatever you prefer. 

> <script_name_alias> [n|r] <file_name>.md

Normal Mode: [-n] [ filename]

- In normal mode, you can execute single command and record your comments for the same in a markdown file.

Record Mode: [ -r] [ filename]
  - In record mode, RECORD_PROC_STATUS would be set to true which allows to invoke the script in intermediate steps. Recording a bullet point for
  - each steps along with suitable header.

NOTE: if a file name already exists, script would be recorded in same file. Or, you can create a new one as per your requirement. 

Available Markdown options: 
  - t :  title 
  - c : comment or paragraph 
  - b : bullet.



