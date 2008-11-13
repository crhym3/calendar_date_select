class CalendarDateSelect
  module IncludesHelper
    def calendar_date_select_stylesheets(options = {})
      options.assert_valid_keys(:style, :format, :locale)
      
      style = options[:style]
      cds_css_file = style ? "calendar_date_select/#{style}" : "calendar_date_select/default"
      return cds_css_file
    end

    def calendar_date_select_javascripts(options = {})
      options.assert_valid_keys(:style, :format, :locale)
      
      style = options[:style]
      locale = options[:locale]
      cds_css_file = style ? "calendar_date_select/#{style}" : "calendar_date_select/default"
      
      output = []
      output << "calendar_date_select/calendar_date_select"
      output << "calendar_date_select/locale/#{locale}" if locale
      output << CalendarDateSelect.javascript_format_include if CalendarDateSelect.javascript_format_include
      return output
    end

    def calendar_date_select_includes(*args)
      return "" if @cds_already_included
      @cds_already_included=true
      
      options = (Hash === args.last) ? args.pop : {}
      options.assert_valid_keys(:style, :format, :locale, :in_place)
      options[:style] ||= args.shift
      CalendarDateSelect.in_place = options.delete(:in_place)

      js = javascript_include_tag(*calendar_date_select_javascripts(options))
      css = stylesheet_link_tag(*calendar_date_select_stylesheets(options))
      "#{js}\n#{css}\n"
    end
    
    def include_calendar_date_select(*args)
      content_for(:head) { calendar_date_select_includes(*args) }
    end
  end
end
