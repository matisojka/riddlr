class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private

  def angular?
    true
  end
  helper_method :angular?

  def na_na_cache(obj)
    @na_na_cache ||= {}

    @na_na_cache.fetch(obj.id) do
      @na_na_cache[obj.id] = na_na_na_na_na_batman.sample
    end
  end
  helper_method :na_na_cache

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
