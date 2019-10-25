module Webcommand
  module Extensions
    module HashExtension
      refine Hash do
        def symbolize_keys
          self.map { |k,v| [k.to_sym,v] }.to_h
        end

        def deep_symbolize_keys
          self.map do |k, v|
            new_value = v.is_a?(Hash) ? v.deep_symbolize_keys : v
            [k.to_sym, new_value]
          end.to_h
        end
      end
    end
  end
end
