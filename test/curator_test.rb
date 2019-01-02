require 'minitest/autorun'
require 'minitest/pride'
require './lib/photograph'
require './lib/artist'
require './lib/curator'

class CuratorTest < Minitest::Test
  def test_it_exists
    curator = Curator.new

    assert_instance_of Curator, curator
  end

  def test_it_has_attributes
    curator = Curator.new

    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end

  def test_it_can_add_photographs
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    }
    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    assert_equal [photo_1, photo_2], curator.photographs
  end

  def test_it_can_add_artist_objects
    curator = Curator.new
    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    }
    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    }

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], curator.artists
  end

  def test_it_can_find_artist_by_id
    curator = Curator.new
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    artist_2 = Artist.new({
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
    })
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal artist_1, curator.find_artist_by_id("1")
    assert_equal artist_2, curator.find_artist_by_id("2")
  end

  def test_it_can_find_photograph_by_id
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = Photograph.new({
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal photo_1, curator.find_photograph_by_id("1")
    assert_equal photo_2, curator.find_photograph_by_id("2")
  end

  def test_it_can_find_photographs_by_artist
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    curator.add_photograph(photo_1)
    curator.add_artist(artist_1)

    assert_equal [photo_1], curator.find_photographs_by_artist(artist_1)
  end

  def test_it_knows_artists_with_multiple_photographs
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = Photograph.new({
      id: "2",
      name: "test_picture",
      artist_id: "1",
      year: "2019"
    })
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    photo_3 = Photograph.new({
      id: "3",
      name: "another test picture",
      artist_id: "2",
      year: "1954"
    })
    artist_2 = Artist.new({
      id: "2",
      name: "Testerman",
      born: "1908",
      died: "2004",
      country: "Testerville"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1], curator.artists_with_multiple_photographs
  end

  def test_it_can_return_photographs_taken_by_a_specified_country
    curator = Curator.new
    photo_1 = Photograph.new({
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
    })
    photo_2 = Photograph.new({
      id: "2",
      name: "test_picture",
      artist_id: "1",
      year: "2019"
    })
    artist_1 = Artist.new({
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
    })
    photo_3 = Photograph.new({
      id: "3",
      name: "another test picture",
      artist_id: "2",
      year: "1954"
    })
    artist_2 = Artist.new({
      id: "2",
      name: "Testerman",
      born: "1908",
      died: "2004",
      country: "Testerville"
    })
    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [photo_1, photo_2], curator.photographs_taken_by_artist_from("France")
    assert_equal [photo_3], curator.photographs_taken_by_artist_from("Testerville")
  end
end
