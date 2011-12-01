module AtticPath
  class Input
  
    attr_accessor :attic_c
  
    def initialize(attic_c)
      @attic_c = attic_c
    end
  
    ############################################
    #                Dir setup                 #
    ############################################
  
    # Code starts here, if the pathing is true then it will be enabled.
    def input
      if attic_c.pathing == true
        @grab_array = []
        @grab_num = 0
        current_dir(".")
      else
        command()
      end
    end

    # Whenever a dir is requested, it will be checked here if it exists or not.
    def check_dir(input)
      if File.directory? File.join(@the_dir, input)
        current_dir(input)
      elsif File.exist? File.join(@the_dir, input)
        puts "\nThe path #{File.join(@the_dir, input)} is a file."
        command()
      else
        puts "\nThe path #{File.join(@the_dir, input)} Doesn't exist."
        command()
      end
    end

    # The current dir the user is in is set here, everytime the location is updated
    # the @the_dir variable changes.
    def current_dir(input)
      Dir.chdir(input)
      @the_dir =  Dir.getwd()
      command()
    end
  
    # Checks if a certain file exists when asked for.
    def check_file(file)
      if File.exists? file
      else
        puts "File or folder doesn't exist"
        command()
      end
    end
  
    # All the files/folders of the current_dir are stored here, if file_ids are enabled
    # every file/folder will have a unique ID.
    def all_files
      Dir.chdir(@the_dir)
      @all_files = Dir.glob("*");
      if attic_c.file_id == true
        file_ids()
      end
    end
  
    # The ID for each file/folder is set here.
    def file_ids
      @file_ids = []
      i = 0
      @all_files.each do |f|
        @file_ids << i 
        i += 1
      end
    end
  
    ############################################
    #              Command inputs              #
    ############################################
  
    # The input starts here, whenever a command has been set, and Attic Path isn't done
    # this function will be called.
    def command
      # If pathing is true, display the current_dir.
    
      if attic_c.pathing_comment != nil
        puts "\n"+attic_c.pathing_comment
      else
        puts "\n"
      end
    
      if attic_c.pathing == true
        puts ">>#{@the_dir}"
        all_files()
      end
    
      # STDOUT.flush if set it is set to true in the options
      flush()
    
      # Converts the input to an array, in order to set multiple functions in 1 input
      @input = $stdin.gets.chomp
      @input_array = @input.scan(/\w+/)
      @input = @input.split(" ")
    
      # All the commands availabe
    
      if @input[0] == "--help"
        help()
      
      elsif @input[0] == "cd" 
        cd()
    
      elsif @input[0] == "ls"
        ls()
      
      elsif @input[0] == "cp"
        cp()
    
      elsif @input[0] == "mv"
        mv()
      
      elsif @input[0] == "grab"
        grabfile()

      else
        submit()
      end
    end
  
    ############################################
    #            Command functions             #
    ############################################
  
    # The STDOUT.flush if true
    def flush
      if attic_c.flush == true
        STDOUT.flush
      end
    end
  
    # --help function
    def help
      puts "Help is here!"
      command()
    end
  
    # The cd function to move from dir to dir
    def cd
      if attic_c.cd == true
        if @input[1] == "--help"
          puts attic_c.cd_help
          command()
        else
          if @input[1] == nil || @input[1][0] == "/"
            if @input[1] == nil
              current_dir("/")
            else
              current_dir(File.join("/", @input[1][1..999999]))
            end
          elsif @input[1][0..1] == "~/"
            current_dir(File.join(ENV["HOME"], @input[1][2..999999]))
          elsif @input[1][0] == "#" && attic_c.file_id == true
            i = 0
            @file_ids.each do |f|
              if @input[1] == "##{f}"
                check_dir(@all_files[f])
                break
              end
              if i+1 == @file_ids.count
                puts "Folder id wasn't found"
                command()
              end
              i += 1 
            end
          else
            check_dir(@input[1])
          end
        end
      else
        invalid()
      end
    end
  
    # The ls method
    def ls
      if attic_c.ls == true
        if @input[1] == "--help"
          puts attic_c.ls_help
          command()
        else
          Dir.chdir(@the_dir)
          if @input[1] == "-a" && attic_c.lsa == true
            ls = Dir.glob("{*,.*}");
          else
            ls = Dir.glob("*");
          end
          rows = []
          if ls.count == 1
            if attic_c.file_id == true
              rows << ["#0", ls[0]]
            else
              rows << [ls[0]]
            end
            table = Terminal::Table.new :rows => rows
            puts table
          else
            i = 0
            while i < ls.count
              if attic_c.file_id == true
                rows << ["##{@file_ids[i]}", ls[i], "##{@file_ids[i+1]}", ls[i+1]]
                i+= 2
              else
                rows << [ls[i], ls[i+1]]
                i+= 2
              end
            end
            table = Terminal::Table.new :rows => rows
            puts table
          end
          command()
        end
      else
        invalid()
      end
    end
  
    # The mv method
    def mv
      if attic_c.mv == true
        if @input[1] == "--help"
          puts attic_c.mv_help
          command()
        else
          if @input[1] != nil && @input[2] != nil
            file_1 = File.join(@the_dir, @input[1])
            file_2 = File.join(@the_dir, @input[2])
            if @input[1][0] == "#"
              number1 = @input[1][1..999].to_i
              number2 = @input[2][1..999].to_i
        
              file_id_1 = File.join(@the_dir, @all_files[number1])
              file_id_2 = File.join(@the_dir, @all_files[number2])
              if @input[2][0] == "#"
                if File.exists? file_id_1
                  if File.exists? file_id_2
                    FileUtils.mv(file_id_1, file_id_2)
                  else
                    puts "Incorrect paths"
                    command()
                  end
                else
                  puts "Incorrect paths"
                  command()
                end
              else
        
              end
            end
            if File.exists? file_1
              if File.exists? file_2
                FileUtils.mv(file_1, file_2)
                command()
              else
                puts "Incorrect paths"
                command()
              end
            else
              puts "Incorrect paths"
              command()
            end
          else
            puts "No target selected"
            command()
          end
        end
      end
    end
  
    # This method is called if the grab method is used with ID instead of file/folder name
    def grab_id()
      i = 0
      this_count = @input.count - 1
      puts this_count
      if this_count > 1
        if @grab_array.count + this_count < attic_c.grab_count+1
          o = 0
          while o < this_count do
            @file_ids.each do |f|
              if @input[o+1] == "##{f}"
                o += 1
                grab_file = File.join(@the_dir, @all_files[f])
                check_file(grab_file)
                puts "Adding #{grab_file} to array"
                @grab_array << grab_file
                i = 0
                @grab_num += 1
                if @grab_num == attic_c.grab_count && attic_c.grab_exit == true && o == this_count

                elsif o == this_count && attic_c.grab_exit == nil
                  command()
                end
              end
              if i == @file_ids.count
                puts attic_c.grab_not_found
                if o == this_count
                  command()
                end
              end
              i += 1
            end
          end
        else
          puts attic_c.grab_full
          command()
        end
      elsif @grab_array.count + 1 < attic_c.grab_count+1
        @file_ids.each do |f|
          if @input[1] == "##{f}"
            grab_file = File.join(@the_dir, @all_files[f])
            check_file(grab_file)
            puts "Adding #{grab_file} to array"
            @grab_array << grab_file
            @grab_num += 1
            if @grab_num == attic_c.grab_count && attic_c.grab_exit == true
            else
              command()
            end
            break
          end
          if i+1 == @file_ids.count
            puts attic_c.grab_not_found
            command()
          end
          i += 1
        end
      else
        puts attic_c.grab_full
        command()
      end
    end
  
    # This method is called if the grab method is used with file/folder name instead of ID
    def grabfile_name
      if @input[2] != nil
        the_count = @input.count-1
        if the_count + @grab_array.count < attic_c.grab_count+1
          i = 1
          puts @input.count
          while i < the_count+1
            grab_file = File.join(@the_dir, @input[i])
            check_file(grab_file)
            @grab_array << grab_file
            puts "Adding #{grab_file} to array"
            if i == the_count
              if attic_c.grab_exit == true
              else
                command()
              end
            end
            i += 1
          end
        else
          puts attic_c.grab_full
          command()
        end
      else
        if @grab_array.count != attic_c.grab_count
          check_file(@grab_file)
          @grab_array << @grab_file
          puts "Adding #{@grab_file} to array"
          if attic_c.grab_count != true
            @grab_num += 1
          end
        else
          puts attic_c.grab_full
          command()
        end
      end
    end
  
    # The grab method, to grab select files.
    # A user can select multiple files at once.
    def grabfile
      if attic_c.grab == true
        if @input[1] == "--help"
          puts attic_c.grab_help
          command()
        else
          if attic_c.grab == true && @input[1] != nil
            @grab_file = File.join(@the_dir, @input[1])
            if @input[1] == "--help"
              puts "grab help"
            else
              if attic_c.file_id == true && @input[1][0] == "#"
                grab_id()
              else
                if attic_c.grab_count == true
                  grabfile_name()
                elsif @grab_num != attic_c.grab_count
                  grabfile_name()
                  if @grab_num == attic_c.grab_count && attic_c.grab_exit == true
                    flush()
                  else
                    command()
                  end
                else
                  if @grab_num == attic_c.grab_count && attic_c.grab_exit == true
                    flush()
                  else
                    puts attic_c.grab_full
                    command()
                  end
                end
              end
            end
          elsif @input[1] == nil
            puts attic_c.grab_no_file
            command()
          else
            invalid()
          end
        end
      end
    end
  
    # Checks if the input is valid for submitting with the selected options
    # If it is not valid the user will be redirected back to input
    def submit
      if attic_c.submit == true
        if @input[0] == attic_c.submit_command
          if attic_c.no_blank == true && @input[1] == nil
            puts attic_c.no_blank_error
            command()
          else
            @input.delete_at(0)
            flush()
          end
        else
          puts "Invalid command, type '#{attic_c.submit_command} [your text]' to submit"
          command()
        end
      else
        if attic_c.no_blank == true && @input[0] == nil
          puts attic_c.no_blank_error
          command()
        end
      end
    end
  
    # Simple error message
    def invalid
      puts "Invalid command '#{@input[0]}'"
      command()
    end
  
    ############################################
    #           AtticInput functions           #
    ############################################
  
    # The output is converted from array to a string
    def output
      @input.map { |i| i.to_s }.join(" ")
    end

    # The output as an array
    def array
      @input_array
    end
  
    # The output counted
    def count
      @input.count
    end
  
    # All the files that were grabbed in an array
    def grab
      @grab_array
    end
  end
end