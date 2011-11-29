class AtticPathCommands
  attr_accessor :submit, :submit_command, :no_blank, :no_blank_error, :flush, :pathing, :file_id, :cd, :ls, :mv, :lsa, :grab, :grab_count, :grab_exit, :grab_no_file, :grab_full, :grab_not_found
  
  def initialize(&block)
    instance_eval(&block) if block_given?
  end
end
