Attic-Path
========

A replacement for gets.chomp.

About
=====

Attic Path is a gem that gives you more options to gets.chomp.
With Attic Path you can browse your system while being in the gets.chomp.
The user can select files and add them into an array.
Here are the current available options for Attic Path.

Notes
=====

Please note that this gem is still beta version, I am not responsible if something breaks when using this. Use at own risk.
This gem might not work on Windows.

Bugs
====

- There seems to be a problem with the grab.count option. Using Thor and setting grab.count to true could cause an error, set to 99999999 instead.

Options
======

There are a number of options you can use with Attic-Path

List of options:
----------------

- submit: If set to true the user has to type the submit_command before being able to store the string.
- submit_command: Set the name for the submit command.
- no_blank: If you don't want the user to submit a blank string, set this to true.
- no_blank_error: Set the error message for the no_blank option
- flush: Set flush to true to let Attic-Path STDOUT.flush automatically
- pathing: Set pathing to true if you want the user to be able to see in which directory he is. Pathing is also needed for the next few options.
- pathing_comment: Set a comment that will be shown above the current path.
- file_id: set this to true if you want all files / folders to have a unique id per folder. What this does is makes it easier to navigate around or select files/folder with the grab method.
- cd: Set this to true in order to let the user cd around his system while being inside the input.
- ls: Set to true if you want the user to be able to use ls command while inside the input
- lsa: Set to true in order to enable the "ls -a" command, shows all files including hidden files in a folder.
- mv: Set to true if you want the user to be able to use mv command while inside the input
- grab: Set to true if you want the user to be able to use the grab command while inside the input. The grab command lets the user 'grab' a certain file. When he does this the file will be put into an array, and you can get that array out of the output.
- grab_count: Set max allowed files that can be inserted into array, set true if unlimited. If setting to true gives an error, set to 99999999999 instead.
- grab_exit: Set to true if you want to exit input once the array has enough item
- grab_no_file: Set error message if no file is selected
- grab_full: Set error message for when grab is full
- grab_not_found: Set error message for when grab isn't found
- c.help: Set a help message when typing --help     
- c.cd_help: Set a help message when typing cd cd --help  
- c.ls_help: Set a help message when typing ls --help
- c.mv_help: Set a help message when typing mv --help
- c.grab_help: Set a help message when typing grab --help

Installing
=======

Just require the gem and add this to your code to adjust the options.

## AtticPath Options  
```ruby
ATTIC_C = AtticPath::Commands.new do |c|

  c.submit = true # Set to true if user has to use the submit_command before submitting

  c.submit_command = "submit" # If submit if true then you can set your submit command

  c.no_blank = true # If you don't want blank inputs set this to true

  c.no_blank_error = "Input can't be blank" # If no_blank is true, set your error message
  
  c.flush = true # Set to true if you want AtticInput to automatically do STDOUT.flush



  c.pathing = true # Set to true if you want to be able to browse your system 
                   # and use any available terminal commands that are set to true
  
  if c.pathing == true # These options are only available if pathing is enabled
    c.pathing_comment = "This is your path."
    
    c.file_id = true # Set to true to enable file id, example: instead of cd Users you can do cd -1

    c.cd = true # Set to true if you want the cd command to be usable

    c.ls = true # Set to true if you want the ls command to be usable
    c.lsa = nil # Set to true if you want the ls -a command to be usable

    c.mv = true # Set to true if you want the mv command to be usable
    
    c.grab = true # Set to true if you want to be able to put files in an array
    c.grab_count = 4 # Set max allowed files that can be inserted into array, set true if unlimited 
    c.grab_exit = nil # Set to true if you want to exit input once the array has enough item
    c.grab_no_file = "You didn't select a file." # Set error message if no file is selected
    c.grab_full = "Can't select more than 4 items" # Set error message for when grab is full
    c.grab_not_found = "File you typed in wasn't found" # Set error message for when grab isn't found

    c.help       = "Help is here!" # Set help command for help
    c.cd_help    = "Use the cd command to browse your system." # Set help command for cd
    c.ls_help    = "Type the ls command to view the files and folders in the current directory.\nType ls -a to also view hidden folder and files" # Set help command for ls
    c.mv_help    = "Use the mv command to move files and folders" # Set help command for mv
    c.grab_help  = "Use the grab command to add a file or folder." # Set help command for grab
  end
end
```

AtticPath Input Functions                              
-------------------------

# attic_path = AtticPath::Input.new(ATTIC_C)
New input, you don't HAVE to repeat this if your app is straight forward

# attic_path.input
This is the input, like gets.chomp

# attic_path.output
This is the output for your input, it'll just output a string

# attic_path.array
This is the output but as an array

# puts attic_path.grab
This is the grab function. An array with all the files / folders that the user stored