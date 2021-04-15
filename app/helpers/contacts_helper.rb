module ContactsHelper
    def format_birthday(date)
      format_date = ''
      begin
        format_date = Date.iso8601(date).strftime('%Y %B %e')
      rescue StandardError
        format_date = date
      end
      format_date
    end
end
