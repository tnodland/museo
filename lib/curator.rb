class Curator
  attr_reader :artists,
              :photographs

  def initialize
    @artists = []
    @photographs = []
  end

  def add_photograph(photograph)
    @photographs << photograph
  end

  def add_artist(artist)
    @artists << artist
  end

  def find_artist_by_id(id)
    @artists.each do |artist|
      if artist.id == id
        return artist
      end
    end
  end

  def find_photograph_by_id(id)
    @photographs.each do |photograph|
      if photograph.id == id
        return photograph
      end
    end
  end

  def find_photographs_by_artist(artist)
    artist_id = artist.id
    photos_by_this_artist = []

    @photographs.each do |photograph|
      if photograph.artist_id == artist_id
        photos_by_this_artist << photograph
      end
    end
  end

  def artists_with_multiple_photographs
    multiples = []
    artists.each do |artist|
      photo_number = 0
      artist_id = artist.id
        photographs.each do |photograph|
          if artist_id == photograph.artist_id
            photo_number += 1
          end
        end
      if photo_number > 1
        multiples << artist
      end
    end
    multiples
  end

  def photographs_taken_by_artist_from(country)
    photos = []
    artists_from_country = []

    @artists.each do |artist|
      if artist.country == country
        artists_from_country << artist
      end
    end

    artists_from_country.each do |artist|
      @photographs.each do |photograph|
        if photograph.artist_id == artist.id
          photos << photograph
        end
      end
    end
    photos
  end

  def load_photographs(file)

  end
end
