module ContactsHelper
    def format_birthday(date)
        Date.iso8601(date).strftime('%Y %B %e')
    end
end
