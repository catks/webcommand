class Config
  using Webcommand::Extensions::HashExtension

  def initialize(data)
    @data = data.deep_symbolize_keys
  end

  def [](key)
    @data[key]
  end
end
