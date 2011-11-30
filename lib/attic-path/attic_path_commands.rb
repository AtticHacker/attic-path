class AtticPathCommands
  attr_accessor :submit, :submit_command, :no_blank, :no_blank_error, :flush, :pathing, :pathing_comment,
  :file_id, :cd, :ls, :mv, :lsa, :grab, :grab_count, :grab_exit, :grab_no_file, :grab_full, :grab_not_found, 
  :help, :cd_help, :ls_help, :mv_help, :grab_help

  def initialize(&block)
    instance_eval(&block) if block_given?
  end
end
