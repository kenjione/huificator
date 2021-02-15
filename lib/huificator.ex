defmodule Huificator do
  @vowels ~r/^[йуеыаоэяию]/u
  @consonant ~r/^([^йуеыаоэяию])*/u
  @punctuation ~r/[\!\?\.\,]/

  @doc """
    Returns a full huificate version of phrase on cyrillic

  ## Examples
      iex> phrase = "Это просто кромешный ад"
      iex> Huificator.convert(phrase)
      "Это просто-хуёсто кромешный-хуёмешный ад"
  """
  def convert(phrase) do
    phrase
    |> String.split(" ")
    |> Enum.map(&convert_string/1)
    |> Enum.join(" ")
  end

  defp convert_string(string) do
    cond do
      String.length(string) < 4 ->
        string
      punctuation_ending?(string) ->
        String.replace(string, @punctuation, "-#{huestring(string)}")
      true ->
        string <> "-" <> huestring(string)
    end
  end

  defp huestring(string) do
    string
    |> String.downcase
    |> remove_consonant_prefix
    |> String.replace(@vowels, convert_vowel_prefix(string))
  end

  defp convert_vowel(vowel) do
    case vowel do
      "а" -> "хуя"
      "о" -> "хуё"
      "у" -> "хую"
      "э" -> "хуе"
      "ы" -> "хуи"
      "й" -> "хуе"
       _  -> "ху#{vowel}"
    end
  end

  defp remove_consonant_prefix(string) do
    String.replace(string, @consonant, "")
  end

  defp punctuation_ending?(string) do
    string
    |> String.last
    |> String.match?(@punctuation)
  end

  defp convert_vowel_prefix(string) do
    string
    |> remove_consonant_prefix
    |> String.first
    |> convert_vowel
  end
end
