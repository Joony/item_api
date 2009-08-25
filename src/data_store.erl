-module(data_store).

-compile(export_all).

-include_lib("stdlib/include/qlc.hrl").
-include_lib("../include/data_config.hrl").

-define(SERVER, data_store).

start() ->
    server_util:start(?SERVER, {data_store, run, [true]}).

stop() ->
    server_util:stop(?SERVER).

run(FirstTime) ->
    if
	FirstTime == true ->
	    init_store(),
	    run(false);
	true ->
	    receive
		shutdown ->
		    io:format("Shutting down...~n"),
		    mnesia:stop()
	    end
    end.

init_store() ->
    mnesia:create_schema([node()]),
    mnesia:start(),
    server_util:create_table(item_type, record_info(fields, item_type)).

teardown_store() ->
    mnesia:stop(),
    mnesia:delete_schema([node()]).
