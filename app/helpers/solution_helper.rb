module SolutionHelper
  def really_convert_to_ms(seconds)
    value = (seconds*1000).ceil

    value == 0 ? 1 : value
  end

  def convert_to_ms(seconds)
    value = (seconds*1000).ceil

    value == 0 ? 'too fast to measure!' : value
  end

  def display_author(author)
    author.presence || na_na_na_na_na_batman.sample
  end

  private

  def na_na_na_na_na_batman
    [
      "Batman",
      "Catwoman",
      "Bane",
      "Harley Quinn",
      "Professor Hugo Strange",
      "The Joker",
      "Killer Croc",
      "Mr. Freeze",
      "The Penguin",
      "Scarecrow",
      "Two Face"
    ]
  end
end
