-module(server_util).

-compile(export_all).

start(ServerName, {Module, Function, Args}) ->
    global:trans({ServerName, ServerName},
		 fun() ->
			 case global:whereis_name(ServerName) of
			     undefined ->
				 Pid = spawn(Module, Function, Args),
                                 global:register_name(ServerName, Pid);
			      _ ->
                                 ok
                         end
                 end).

stop(ServerName) ->
    global:trans({ServerName, ServerName},
                 fun() ->
                         case global:whereis_name(ServerName) of
                             undefined ->
                                 ok;
                             _ ->
                                 global:send(ServerName, shutdown)
                         end
                 end).

create_table(Record, Fields) ->
    create_table(Record, Fields, set).
create_table(Record, Fields, Type) ->
    try
        mnesia:table_info(Record, record_name)
    catch
        exit: _ ->
            mnesia:create_table(Record, [{attributes, Fields},
                                         {type, Type},
                                         {disc_copies, [node()]}])
    end.
