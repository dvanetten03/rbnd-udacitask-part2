class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @type = "link"
    @description = url
    @site_name = options[:site_name]
  end
 
  def format_name
    @site_name ? @site_name : ""
  end

  def details
    format_description(@description).white + "   site name: ".bold.magenta + format_name.underline + "    item_type: ".blue + @type
  end
end
