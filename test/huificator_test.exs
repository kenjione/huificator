defmodule HuificatorTest do
  use ExUnit.Case
  doctest Huificator

  test "with punctuation" do
    huificated = Huificator.convert("Cъешь ещё этих мягких французских булочек, да выпей чаю.")
    assert huificated == "Cъешь-хуешь ещё этих-хуетих мягких-хуягких французских-хуянцузских булочек-хуюлочек, да выпей-хуипей чаю-хуяю."
  end

  test "aidan case" do
    huificated = Huificator.convert("Привет, меня зовут Эйдан")
    assert huificated == "Привет-хуивет, меня-хуеня зовут-хуёвут Эйдан-хуейдан"
  end
end
