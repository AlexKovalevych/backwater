defmodule BasicFuncionalityTest do
  use ExUnit.Case
  #doctest BackwaterElixirTests

  test "expose and call erlang module" do
    ref = start_backwater([{:erlang, [{:exports, :all}]}])

    # call existing function
    assert {:ok, [1,2,3]} ==
          :backwater_client.call(ref, :erlang, :binary_to_list, [<<1,2,3>>])

    # call non-existing function
    assert {:error, {:remote, {:not_found, _headers, _body}}} =
          :backwater_client.call(ref, :erlang, :binary_to_listsy, [<<1,2,3>>])

    # call non-existing module
    assert {:error, {:remote, {:forbidden, _headers, _body}}} =
          :backwater_client.call(ref, :erlangsy, :binary_to_list, [<<1,2,3>>])

    stop_backwater(ref)
  end

  test "expose and call elixir module" do
    ref = start_backwater([{Enum, [{:exports, :all}]}])

    # call existing function
    assert {:ok, [2,4,6]} ==
          :backwater_client.call(ref, Enum, :map, [[1,2,3], fn (x) -> x * 2 end])

    # call non-existing function
    assert {:error, {:remote, {:not_found, _headers, _body}}} =
          :backwater_client.call(ref, Enum, :mapsyy, [[1,2,3], fn (x) -> x * 2 end])

    # call non-existing module
    assert {:error, {:remote, {:forbidden, _headers, _body}}} =
          :backwater_client.call(ref, Enumsyy, :map, [[1,2,3], fn (x) -> x * 2 end])

    stop_backwater(ref)
  end

  def start_backwater(exposed_modules) do
    ref = :rand.uniform(999999999)
    # start server
    secret = :crypto.strong_rand_bytes(32)
    {:ok, _pid} =
      :backwater_server.start_clear(ref,
                                    %{:secret => secret,
                                      :exposed_modules => exposed_modules,
                                      :decode_unsafe_terms => true },
                                    [{:port, 8080}],
                                    [])
    # start client
    :ok = :backwater_client.start(ref,
                                  %{ :endpoint => "http://127.0.0.1:8080/",
                                     :secret => secret,
                                     :decode_unsafe_terms => true })
    ref
  end

  def stop_backwater(ref) do
    :ok = :backwater_client.stop(ref)
    :ok = :backwater_server.stop_listener(ref)
  end

end