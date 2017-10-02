class UndefinedRule < Exception
  def initialize(msg='No rule found for this week!')
    super
  end
end
