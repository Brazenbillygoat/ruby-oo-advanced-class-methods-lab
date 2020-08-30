require 'pry'

class Song
  attr_accessor :name, :artist_name
  @@all = []

  def self.all
    @@all
  end

  def save
    self.class.all << self
  end

  def self.create
    song = self.new
    @@all.push(song)
    return song
  end

  def self.new_by_name(song_name)
    song = self.new
    song.name = song_name
    song
  end

  def self.create_by_name(song_name)
    song = self.new
    song.name = song_name
    @@all.push(song)
    song
  end

  def self.find_by_name(song_name)
    self.all.find do |song|
      song.name == song_name
    end
  end

  def self.find_or_create_by_name(name)
    if self.find_by_name(name) == nil
      self.create_by_name(name)
    else
      self.find_by_name(name)
    end
  end

  def self.alphabetical
    self.all.sort_by { |song| song.name }
  end

  def filename_parser(file)
    artist_song = file.split(" - ")
    artist_song[1].sub!(/\.([^\.]+)$/, "")
    return artist_song
  end

  def self.new_from_filename(file_name)
    song = self.create
    song.artist_name = song.filename_parser(file_name)[0]
    song.name = song.filename_parser(file_name)[1]
    song
  end

  def self.create_from_filename(file_name)
    self.all.push(self.new_from_filename(file_name))
  end

  def self.destroy_all
    self.all.clear
  end

end
