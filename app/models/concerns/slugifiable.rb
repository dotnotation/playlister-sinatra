module Slugifiable
    # require relative in files taht are using this module
    module InstanceMethods
        def slug
            # need to replace spaces with - for url also lower case
            self.name.downcase.gsub(" ", "-")
        end
    end

    module ClassMethods
        def find_by_slug(slug)
            # find slug as a params
            self.all.find {|s| s.slug == slug}
        end
    end
end