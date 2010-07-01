module DbCompile
  # Anything that can be expressed in SQL
  class Construct
    attr_accessor :name
    attr_accessor :path
    attr_accessor :root_path
    attr_accessor :dependencies

    def initialize(name, root_path)
      @name = name
      @root_path = root_path
      build_path
    end

    # Override this to set path the SQL source
    def build_path
    end

    # Return the SQL source.  Do any magic wrapping here.
    def source
      f = File.open(File.join(root_path, path))
      data = f.read
      f.close
      data
    end

    def execute
      ActiveRecord::Base.connection.execute(source)
    end
  end
end
