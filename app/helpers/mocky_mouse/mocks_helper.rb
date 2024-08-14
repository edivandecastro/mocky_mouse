module MockyMouse
  module MocksHelper
    def available_mime_types
      Mime::EXTENSION_LOOKUP.map{ |a| a[1].to_s }.uniq.sort
    end

    def available_script_types
      [ [t(MockyMouse::Mock::SCRIPT_TYPE_EMBEDDED_RUBY), MockyMouse::Mock::SCRIPT_TYPE_EMBEDDED_RUBY],
        [t(MockyMouse::Mock::SCRIPT_TYPE_JS), MockyMouse::Mock::SCRIPT_TYPE_JS],
        [t(MockyMouse::Mock::SCRIPT_TYPE_STATIC), MockyMouse::Mock::SCRIPT_TYPE_STATIC] ]
    end
  end
end
