class InvalidJsonFile < Exception
  def initialize(msg='Json file does not include all the needed fileds!')
    super
  end
end
