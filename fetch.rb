require "open-uri"
require "nokogiri"

class Fetch
  def self.bbc(ingredient)
    url = "https://www.bbcgoodfood.com/search/recipes?query=#{ingredient}"
    doc = open(url)
    object = Nokogiri::HTML(doc)

    # doc = Nokogiri::HTML(open(url), nil, "utf-8")
    recipes = []
    object.search(".node-recipe").each do |node|
      name = node.search(".teaser-item__title").text.strip
      description = node.search(".field-item even").text.strip
      recipes << Recipe.new(name, description)
    end
    recipes
  end
end
