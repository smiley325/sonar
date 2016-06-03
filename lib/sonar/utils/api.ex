defmodule Sonar.Utils.API do
    @moduledoc ~S"""
    API generation utilities.
    """

    def generate_parameter_map(params) do
        params |> Enum.map(
            fn {key, value} ->
                [jkey_h | jkey_t] = key
                    |> Atom.to_string
                    |> String.split("_")

                jkey = [jkey_h | Enum.map(jkey_t, &String.capitalize/1)]
                    |> Enum.join

                {jkey, value}
            end
        ) |> Enum.into(%{})
    end

    def generate_parameter_qs(params) do
        params
            |> Enum.map(fn {k, v} -> "#{k |> Atom.to_string |> Mix.Utils.camelize |> URI.encode}=#{v |> URI.encode}" end)
            |> Enum.join("&")
    end
end
